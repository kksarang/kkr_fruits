import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:santhosh_bakery/core/app_theme.dart';
import 'package:santhosh_bakery/providers/cart_provider.dart';
import 'package:santhosh_bakery/providers/orders_provider.dart';
import 'package:santhosh_bakery/providers/auth_provider.dart';
import 'package:santhosh_bakery/screens/splash_screen.dart';

import 'package:firebase_core/firebase_core.dart'; // Add this

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint("Firebase init failed (expected if no config): $e");
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => OrdersProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const SanthoshBakeryApp(),
    ),
  );
}

class SanthoshBakeryApp extends StatelessWidget {
  const SanthoshBakeryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KKR Fruits',
      theme: AppTheme.theme,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
