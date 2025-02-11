class Product {
  int id;
  String name;
  double price;
  int stock;
  DateTime createdAt;
  DateTime updatedAt;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.stock,
    required this.createdAt,
    required this.updatedAt,
  });
}
