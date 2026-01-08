import 'package:santhosh_bakery/data/models/product.dart';

class DummyData {
  static final List<Category> categories = [
    Category(
      id: 'fruits',
      name: 'Fresh Fruits',
      iconPath: 'assets/icons/fruits.png',
      emoji: '🍎',
    ),
    Category(
      id: 'seasonal',
      name: 'Seasonal',
      iconPath: 'assets/icons/seasonal.png',
      emoji: '🥭',
    ),
    Category(
      id: 'stationery',
      name: 'Stationery',
      iconPath: 'assets/icons/stationery.png',
      emoji: '✏️',
    ),
    Category(
      id: 'essentials',
      name: 'Essentials',
      iconPath: 'assets/icons/essentials.png',
      emoji: '🥛',
    ),
  ];

  static final List<Product> products = [
    // --- Fresh Fruits ---
    Product(
      id: 'f1',
      name: 'Fresh Apples (Ooty)',
      description: 'Crisp and sweet apples fresh from Ooty. Price per kg.',
      price: 180.00,
      imageUrl:
          'https://images.unsplash.com/photo-1560806887-1e4cd0b6cbd6?auto=format&fit=crop&q=80&w=800',
      category: 'Fresh Fruits',
      rating: 4.8,
      reviewCount: 120,
    ),
    Product(
      id: 'f2',
      name: 'Robusta Bananas',
      description: 'Healthy and energy-rich Robusta bananas. Price per kg.',
      price: 40.00,
      imageUrl:
          'https://images.unsplash.com/photo-1571771896612-618db53281fb?auto=format&fit=crop&q=80&w=800',
      category: 'Fresh Fruits',
      rating: 4.6,
      reviewCount: 95,
    ),
    Product(
      id: 'f3',
      name: 'Pomegranate (Deluxe)',
      description: 'Rich red pomegranates, high in antioxidants. Price per kg.',
      price: 220.00,
      imageUrl:
          'https://images.unsplash.com/photo-1596386461350-326ea038be20?auto=format&fit=crop&q=80&w=800',
      category: 'Fresh Fruits',
      rating: 4.9,
      reviewCount: 50,
    ),
    Product(
      id: 'f4',
      name: 'Oranges (Nagpur)',
      description: 'Juicy and Vitamin-C rich Nagpur oranges. Price per kg.',
      price: 80.00,
      imageUrl:
          'https://images.unsplash.com/photo-1547514701-42782101795e?auto=format&fit=crop&q=80&w=800',
      category: 'Fresh Fruits',
      rating: 4.5,
      reviewCount: 78,
    ),

    // --- Seasonal Fruits ---
    Product(
      id: 's1',
      name: 'Alphonso Mango',
      description: 'The king of fruits! Sweet and aromatic. Price per kg.',
      price: 350.00,
      imageUrl:
          'https://images.unsplash.com/photo-1553279768-865429fa0078?auto=format&fit=crop&q=80&w=800',
      category: 'Seasonal',
      rating: 5.0,
      reviewCount: 200,
    ),
    Product(
      id: 's2',
      name: 'Seedless Grapes',
      description: 'Sweet seedless black grapes. Price per kg.',
      price: 120.00,
      imageUrl:
          'https://images.unsplash.com/photo-1537640538965-17565236b589?auto=format&fit=crop&q=80&w=800',
      category: 'Seasonal',
      rating: 4.7,
      reviewCount: 65,
    ),

    // --- Stationery ---
    Product(
      id: 'st1',
      name: 'Classmate Notebook',
      description: 'King size, 172 pages, ruled high-quality paper.',
      price: 65.00,
      imageUrl:
          'https://images.unsplash.com/photo-1544816155-12df9643f363?auto=format&fit=crop&q=80&w=800',
      category: 'Stationery',
      rating: 4.8,
      reviewCount: 150,
    ),
    Product(
      id: 'st2',
      name: 'Ballpoint Pens (Pack of 5)',
      description: 'Smooth writing blue ballpoint pens.',
      price: 50.00,
      imageUrl:
          'https://images.unsplash.com/photo-1585336261022-680e295ce3fe?auto=format&fit=crop&q=80&w=800',
      category: 'Stationery',
      rating: 4.5,
      reviewCount: 40,
    ),
    Product(
      id: 'st3',
      name: 'A4 Paper Bundle (500 Sheets)',
      description: '75 GSM multi-purpose office paper.',
      price: 320.00,
      imageUrl:
          'https://images.unsplash.com/photo-1586075010923-2dd4570fb338?auto=format&fit=crop&q=80&w=800',
      category: 'Stationery',
      rating: 4.6,
      reviewCount: 25,
    ),
    Product(
      id: 'st4',
      name: 'Pencil Box (HB)',
      description: 'Pack of 10 HB pencils with eraser and sharpener.',
      price: 60.00,
      imageUrl:
          'https://images.unsplash.com/photo-1519682337058-a94d519337bc?auto=format&fit=crop&q=80&w=800',
      category: 'Stationery',
      rating: 4.7,
      reviewCount: 55,
    ),

    // --- Daily Essentials ---
    Product(
      id: 'e1',
      name: 'Fresh Milk (500ml)',
      description: 'Farm fresh toned milk.',
      price: 28.00,
      imageUrl:
          'https://images.unsplash.com/photo-1550583724-b2692b85b150?auto=format&fit=crop&q=80&w=800',
      category: 'Essentials',
      rating: 4.9,
      reviewCount: 300,
    ),
    Product(
      id: 'e2',
      name: 'Brown Bread',
      description: 'Healthy whole wheat brown bread.',
      price: 45.00,
      imageUrl:
          'https://images.unsplash.com/photo-1509440159596-0249088772ff?auto=format&fit=crop&q=80&w=800',
      category: 'Essentials',
      rating: 4.4,
      reviewCount: 88,
    ),
    Product(
      id: 'e3',
      name: 'Farm Eggs (6 Pack)',
      description: 'Fresh organic eggs.',
      price: 48.00,
      imageUrl:
          'https://images.unsplash.com/photo-1598965402089-897ce52e8355?auto=format&fit=crop&q=80&w=800',
      category: 'Essentials',
      rating: 4.8,
      reviewCount: 110,
    ),
  ];
}
