import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:santhosh_bakery/core/app_size.dart';
import 'package:santhosh_bakery/core/app_theme.dart';
import 'package:santhosh_bakery/data/models/product.dart';
import 'package:santhosh_bakery/providers/cart_provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  String _selectedSize = 'Medium';
  int _quantity = 1;

  final List<String> _sizes = ['Small', 'Medium', 'Large'];

  @override
  Widget build(BuildContext context) {
    AppSize.init(context);
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: AppSize.height * 0.45,
            child: CachedNetworkImage(
              imageUrl: widget.product.imageUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: Colors.grey[100],
                child: const Center(
                  child: CircularProgressIndicator(
                    color: AppTheme.primaryOrange,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                color: const Color(0xFFFFF0E0), // Light peach
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _getCategoryIcon(widget.product.category),
                      color: AppTheme.primaryOrange.withValues(alpha: 0.5),
                      size: 60,
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Custom Back Button
          Positioned(
            top: 50,
            left: 20,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: AppTheme.darkText),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
          // Content Scrollable
          Positioned.fill(
            top: AppSize.height * 0.4,
            child: Container(
              decoration: const BoxDecoration(
                color: AppTheme.creamBackground,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 50,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.product.name,
                            style: Theme.of(context).textTheme.headlineMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryOrange.withValues(
                              alpha: 0.1,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 20,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                widget.product.rating.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.primaryDark,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.product.description,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppTheme.lightText,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Size',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: _sizes.map((size) {
                        final isSelected = _selectedSize == size;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedSize = size;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 12),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppTheme.primaryOrange
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: isSelected
                                  ? null
                                  : Border.all(color: Colors.grey.shade300),
                            ),
                            child: Text(
                              size,
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : AppTheme.darkText,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Quantity',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () {
                                  if (_quantity > 1) {
                                    setState(() {
                                      _quantity--;
                                    });
                                  }
                                },
                              ),
                              Text(
                                '$_quantity',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  setState(() {
                                    _quantity++;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 100), // Space for bottom bar
                  ],
                ),
              ),
            ),
          ),
          // Bottom Cart Bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 20,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: SafeArea(
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Total Price',
                          style: TextStyle(
                            color: AppTheme.lightText,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          '₹${(widget.product.price * _quantity).toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            color: AppTheme.darkText,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Provider.of<CartProvider>(
                            context,
                            listen: false,
                          ).addItem(widget.product, _selectedSize, _quantity);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Added ${widget.product.name} to cart',
                              ),
                              backgroundColor: AppTheme.accentGreen,
                              duration: const Duration(seconds: 1),
                            ),
                          );
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.darkText,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text('Add to Cart'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    if (category.contains('Cake')) return Icons.cake;
    if (category.contains('Pastry')) return Icons.cake;
    if (category.contains('Bread')) return Icons.bakery_dining;
    if (category.contains('Cookie')) return Icons.cookie;
    if (category.contains('Snack')) return Icons.fastfood;
    if (category.contains('Sweet')) return Icons.emoji_food_beverage;
    return Icons.restaurant;
  }
}
