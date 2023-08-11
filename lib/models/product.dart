class Product {
  final String id;
  final String categoryId;
  final String name;
  final String brand;
  final String description;
  final double price;
  final double averageRating;
  final int reviewCount;
  final String imgUrl;
  final DateTime createdAt;

  Product(
      {required this.id,
      required this.categoryId,
      required this.name,
      required this.brand,
      required this.description,
      required this.price,
      required this.averageRating,
      required this.reviewCount,
      required this.imgUrl,
      required this.createdAt});

  factory Product.fromMap(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      categoryId: json['categoryId'],
      name: json['name'],
      brand: json['brand'],
      description: json['description'],
      price: json['price'].toDouble(),
      averageRating: json['averageRating'].toDouble(),
      reviewCount: json['reviewCount'],
      imgUrl: json['imgUrl'],
      createdAt: json['createdAt'].toDate(),
    );
  }
}
