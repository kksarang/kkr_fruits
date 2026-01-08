class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String category;
  final double rating;
  final int reviewCount;
  final List<String> images;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    this.rating = 4.5,
    this.reviewCount = 0,
    this.images = const [],
  });
}

class Category {
  final String id;
  final String name;
  final String iconPath; // Or use IconData for simplicity in dummy data
  final String emoji;

  Category({
    required this.id,
    required this.name,
    required this.iconPath,
    required this.emoji,
  });
}
