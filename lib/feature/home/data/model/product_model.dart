class ProductModel {
  final String name;
  final String image;
  final double price;
  final double rating;
  final bool isFav;

  ProductModel({
    required this.name,
    required this.image,
    required this.price,
    required this.rating,
    this.isFav = false,
  });
}
