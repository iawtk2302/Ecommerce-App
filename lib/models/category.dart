class Category {
  final String id;
  final String name;
  final String imgUrl;
  final int productCount;

  Category({
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.productCount,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      imgUrl: json['imgUrl'],
      productCount: json['productCount'],
    );
  }
}
