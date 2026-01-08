import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:santhosh_bakery/providers/auth_provider.dart';
import 'package:santhosh_bakery/core/app_size.dart';
import 'package:santhosh_bakery/core/app_theme.dart';
import 'package:santhosh_bakery/data/dummy_data/dummy_data.dart';
import 'package:santhosh_bakery/providers/cart_provider.dart';
import 'package:santhosh_bakery/screens/product_details_screen.dart';
import 'package:santhosh_bakery/widgets/category_chip.dart';
import 'package:santhosh_bakery/widgets/product_card.dart';
import 'package:santhosh_bakery/widgets/promo_carousel.dart';

// Placeholder for Cart Screen import
import 'package:santhosh_bakery/screens/cart_screen.dart';
import 'package:santhosh_bakery/screens/about_screen.dart';
import 'package:santhosh_bakery/screens/order_history_screen.dart';
import 'package:santhosh_bakery/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategoryId =
      DummyData.categories.first.id; // Default to first category

  @override
  Widget build(BuildContext context) {
    AppSize.init(context);
    // Filter products based on selection
    final filteredProducts = DummyData.products.where((p) {
      if (_selectedCategoryId == 'all') return true;
      // In dummy data, I used category names instead of IDs for simplicity in product definition
      // Let's map ID to Name or just match loosely.
      // My dummy data product.category is the Name (e.g. 'Cakes').
      // My dummy data category.id is 'c1', category.name is 'Cakes'.
      final categoryName = DummyData.categories
          .firstWhere((c) => c.id == _selectedCategoryId)
          .name;
      return p.category == categoryName;
    }).toList();

    return Scaffold(
      backgroundColor: AppTheme.creamBackground,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Consumer<AuthProvider>(
              builder: (context, auth, _) {
                final user = auth.user;
                final isGuest = auth.isGuest;
                return GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfileScreen(),
                      ),
                    );
                  },
                  child: UserAccountsDrawerHeader(
                    decoration: const BoxDecoration(
                      color: AppTheme.primaryDark,
                    ),
                    accountName: Text(
                      isGuest ? 'Guest User' : (user?.displayName ?? 'User'),
                    ),
                    accountEmail: Text(
                      isGuest ? 'Welcome to KKR Fruits' : (user?.email ?? ''),
                    ),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: user?.photoURL != null
                          ? NetworkImage(user!.photoURL!)
                          : null,
                      child: user?.photoURL == null
                          ? const Icon(
                              Icons.person,
                              color: AppTheme.primaryOrange,
                            )
                          : null,
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('My Profile'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('My Orders'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OrderHistoryScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text('My Cart'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CartScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.store),
              title: const Text('Our Locations'),
              onTap: () {
                Navigator.pop(context);
                _showLocationsDialog(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.privacy_tip),
              title: const Text('Privacy Policy'),
              onTap: () {
                Navigator.pop(context);
                // Placeholder - typically launches a URL
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Privacy Policy coming soon!'),
                    backgroundColor: AppTheme.primaryDark,
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About Us'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // 1. App Bar / Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Builder(
                          builder: (context) => IconButton(
                            icon: const Icon(
                              Icons.menu,
                              color: AppTheme.darkText,
                            ),
                            onPressed: () {
                              Scaffold.of(context).openDrawer();
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Welcome to',
                              style: TextStyle(
                                color: AppTheme.lightText,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              'KKR Fruits',
                              style: Theme.of(context).textTheme.headlineSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.darkText,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Consumer<CartProvider>(
                      builder: (context, cart, child) => Stack(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CartScreen(),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.shopping_cart_outlined,
                              size: 28,
                            ),
                          ),
                          if (cart.itemCount > 0)
                            Positioned(
                              right: 5,
                              top: 5,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: AppTheme.primaryDark,
                                  shape: BoxShape.circle,
                                ),
                                constraints: const BoxConstraints(
                                  minWidth: 16,
                                  minHeight: 16,
                                ),
                                child: Text(
                                  '${cart.itemCount}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 2. Search Bar
            SliverToBoxAdapter(child: _buildSearchBar()),

            // 3. Promotional Banners
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: PromoCarousel(),
              ),
            ),

            // 4. Categories
            SliverToBoxAdapter(
              child: SizedBox(
                height: 50,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  scrollDirection: Axis.horizontal,
                  itemCount: DummyData.categories.length,
                  itemBuilder: (context, index) {
                    final category = DummyData.categories[index];
                    return CategoryChip(
                      category: category,
                      isSelected: _selectedCategoryId == category.id,
                      onTap: () {
                        setState(() {
                          _selectedCategoryId = category.id;
                        });
                      },
                    );
                  },
                ),
              ),
            ),

            // 5. Section Title
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 10),
                child: Text(
                  'Popular Items',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.darkText,
                  ),
                ),
              ),
            ),

            // 6. Product Grid
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: MediaQuery.of(context).size.width < 600
                      ? 2
                      : 4,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                delegate: SliverChildBuilderDelegate((context, index) {
                  final product = filteredProducts[index];
                  return ProductCard(
                    product: product,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProductDetailsScreen(product: product),
                        ),
                      );
                    },
                    onAdd: () {
                      Provider.of<CartProvider>(
                        context,
                        listen: false,
                      ).addItem(product, 'Medium', 1);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Added ${product.name} to cart'),
                          backgroundColor: AppTheme.accentGreen,
                          duration: const Duration(milliseconds: 800),
                        ),
                      );
                    },
                  );
                }, childCount: filteredProducts.length),
              ),
            ),
            // Bottom Padding
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
          ],
        ),
      ),
    );
  }

  void _showLocationsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Our Locations',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView(
            shrinkWrap: true,
            children: const [
              _LocationTile(
                name: 'Gandhipuram (Main)',
                address: '123 Cross Cut Road, Gandhipuram, Coimbatore',
              ),
              _LocationTile(
                name: 'RS Puram',
                address: '45 DB Road, RS Puram, Coimbatore',
              ),
              _LocationTile(
                name: 'Peelamedu',
                address: 'Avinashi Road, Near PSG Tech, Peelamedu',
              ),
              _LocationTile(
                name: 'Saravanampatti',
                address: 'Sathy Road, Near Prozone Mall, Saravanampatti',
              ),
              _LocationTile(
                name: 'Ukkadam',
                address: 'Opp. Bus Stand, Ukkadam, Coimbatore',
              ),
              _LocationTile(
                name: 'Podanur',
                address: 'Railway Station Road, Podanur, Coimbatore',
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Close',
              style: TextStyle(color: AppTheme.primaryDark),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search for fruits, stationery...',
          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
          prefixIcon: const Icon(Icons.search, color: AppTheme.primaryOrange),
          suffixIcon: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.primaryDark.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.tune,
              color: AppTheme.primaryDark,
              size: 20,
            ),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
        ),
        onChanged: (value) {
          // Implement search logic later if needed
        },
      ),
    );
  }
}

class _LocationTile extends StatelessWidget {
  final String name;
  final String address;

  const _LocationTile({required this.name, required this.address});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.location_on, color: AppTheme.primaryOrange),
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(address),
    );
  }
}
