import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:santhosh_bakery/core/app_theme.dart';
import 'package:santhosh_bakery/providers/auth_provider.dart';
import 'package:santhosh_bakery/screens/home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Logo or Image
              const Spacer(),
              Material(
                elevation: 10,
                shadowColor: Colors.black.withOpacity(0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/images/logo.jpg',
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'KKR Fruits',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.darkText,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Fresh Fruits & Stationery Shop',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: AppTheme.lightText),
              ),
              const Spacer(),

              // Google Sign In
              ElevatedButton(
                onPressed: () async {
                  final authProvider = Provider.of<AuthProvider>(
                    context,
                    listen: false,
                  );
                  // Initial implementation assumes success or handles null internally
                  // In real app, check result
                  await authProvider.signInWithGoogle();
                  if (context.mounted &&
                      (authProvider.user != null ||
                          authProvider.isGuest == false)) {
                    // Check if actually logged in (isGuest false and user not null)
                    // But wait, Provider updates might not be instant in this sync block?
                    // signInWithGoogle returns User? so we can check that.
                    if (authProvider.user != null) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const HomeScreen()),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  elevation: 2,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // You might want a Google Icon asset here
                    const Icon(Icons.login, color: Colors.blue), // Placeholder
                    const SizedBox(width: 12),
                    const Text(
                      'Sign in with Google',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Guest Option
              TextButton(
                onPressed: () {
                  Provider.of<AuthProvider>(
                    context,
                    listen: false,
                  ).signInAsGuest();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const HomeScreen()),
                  );
                },
                child: const Text(
                  'Continue as Guest',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppTheme.lightText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
