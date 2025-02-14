// ignore_for_file: public_member_api_docs, sort_constructors_first
class Product {
  String? id;
  String name;
  double price;
  int stock;
  DateTime createdAt;
  DateTime updatedAt;

  Product({
    this.id,
    required this.name,
    required this.price,
    required this.stock,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  String toString() {
    return 'Product(id: $id, name: $name, price: $price, stock: $stock, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  factory Product.fromJson(Map map) {
    return Product(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] as String,
      price: double.tryParse(map['price']) ?? 0,
      stock: map['stock'] as int,
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }
}
