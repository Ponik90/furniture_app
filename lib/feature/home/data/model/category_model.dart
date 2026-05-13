class CategoryModel {
  final String? id;
  final String icon;
  final String name;

  CategoryModel({this.id, required this.icon, required this.name});

  Map<String, dynamic> toMap() {
    return {
      'icon': icon,
      'name': name,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map, String id) {
    return CategoryModel(
      id: id,
      icon: map['icon'] ?? '',
      name: map['name'] ?? '',
    );
  }
}
