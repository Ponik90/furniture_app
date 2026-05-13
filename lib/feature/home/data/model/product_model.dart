class ProductModel {
  final String? id;
  final String name;
  final String image;
  final String category;
  final String description;
  final double price;
  final double rating;

  ProductModel({
    this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.rating,
    required this.category,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'category': category,
      'price': price,
      'rating': rating,
      'description': description,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map, String id) {
    return ProductModel(
      id: id,
      name: map['name'] ?? '',
      image: map['image'] ?? '',
      category: map['category'] ?? '',
      price: (map['price'] as num).toDouble(),
      rating: (map['rating'] as num).toDouble(),
      description: map['description'],
    );
  }
}
