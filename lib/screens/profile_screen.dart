import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:santhosh_bakery/core/app_theme.dart';
import 'package:santhosh_bakery/providers/auth_provider.dart';
import 'package:santhosh_bakery/providers/cart_provider.dart';
import 'package:santhosh_bakery/providers/orders_provider.dart';
import 'package:santhosh_bakery/screens/login_screen.dart';
import 'package:santhosh_bakery/screens/order_history_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final user = auth.user;
    final isGuest = auth.isGuest;

    return Scaffold(
      appBar: AppBar(title: const Text('My Profile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // User Info Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: AppTheme.primaryOrange.withOpacity(0.1),
                    backgroundImage: user?.photoURL != null
                        ? NetworkImage(user!.photoURL!)
                        : null,
                    child: user?.photoURL == null
                        ? const Icon(
                            Icons.person,
                            size: 40,
                            color: AppTheme.primaryOrange,
                          )
                        : null,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    isGuest ? 'Guest User' : (user?.displayName ?? 'User'),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.darkText,
                    ),
                  ),
                  if (!isGuest && user?.email != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      user!.email!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppTheme.lightText,
                      ),
                    ),
                  ],
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: isGuest
                          ? Colors.grey.withOpacity(0.1)
                          : Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      isGuest ? 'Guest Mode' : 'Logged in with Google',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: isGuest ? Colors.grey : Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Menu Options
            if (!isGuest)
              _buildMenuTile(
                context,
                icon: Icons.history,
                title: 'Order History',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OrderHistoryScreen(),
                    ),
                  );
                },
              ),

            _buildMenuTile(
              context,
              icon: Icons.logout,
              title: 'Logout',
              isDestructive: false,
              onTap: () {
                _showLogoutConfirmDialog(context);
              },
            ),

            if (!isGuest)
              _buildMenuTile(
                context,
                icon: Icons.delete_forever,
                title: 'Delete Account',
                isDestructive: true,
                onTap: () {
                  _showDeleteConfirmDialog(context);
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isDestructive
                ? Colors.red.withOpacity(0.1)
                : AppTheme.primaryOrange.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: isDestructive ? Colors.red : AppTheme.primaryDark,
            size: 20,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: isDestructive ? Colors.red : AppTheme.darkText,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.grey,
        ),
        onTap: onTap,
      ),
    );
  }

  Future<void> _handleLogout(BuildContext context) async {
    // Clear State
    Provider.of<CartProvider>(context, listen: false).clearCart();
    // In a real app, clear Orders if needed or keep cache
    // Provider.of<OrdersProvider>(context, listen: false).clearOrders();

    // Sign Out
    await Provider.of<AuthProvider>(context, listen: false).logout();

    if (context.mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false,
      );
    }
  }

  void _showDeleteConfirmDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Account?'),
        content: const Text(
          'This action is permanent and cannot be undone. All your order history and profile data will be permanently deleted.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              await Provider.of<AuthProvider>(
                context,
                listen: false,
              ).deleteAccount();
              if (context.mounted) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false,
                );
              }
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showLogoutConfirmDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Logout?'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              _handleLogout(context);
            },
            child: const Text(
              'Logout',
              style: TextStyle(color: AppTheme.primaryDark),
            ),
          ),
        ],
      ),
    );
  }
}
