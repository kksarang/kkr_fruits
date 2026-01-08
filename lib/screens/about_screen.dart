import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:santhosh_bakery/core/app_theme.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About Us')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Image
            Container(
              height: 200,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    "https://images.unsplash.com/photo-1556910103-1c02745a30bf?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.7),
                      Colors.transparent,
                    ],
                  ),
                ),
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.all(20),
                child: const Text(
                  'KKR Fruits',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Our Story',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.darkText,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'KKR Fruits provides the freshest seasonally available fruits and high-quality stationery for all your needs. Quality and customer satisfaction are our top priorities.',
                    style: TextStyle(color: AppTheme.lightText, height: 1.6),
                  ),
                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 24),
                  _buildContactRow(
                    Icons.location_on,
                    'Coimbatore, Tamil Nadu, India',
                  ),
                  const SizedBox(height: 16),
                  _buildContactRow(Icons.phone, '+91 98765 43210'),
                  const SizedBox(height: 16),
                  _buildContactRow(
                    Icons.access_time,
                    'Mon - Sun: 8:00 AM - 10:00 PM',
                  ),
                  const SizedBox(height: 16),
                  _buildContactRow(Icons.email, 'orders@kkrfruits.com'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactRow(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppTheme.primaryOrange, size: 24),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              color: AppTheme.darkText,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
