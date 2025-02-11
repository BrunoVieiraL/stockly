
class Sale {
  int id;
  String name;
  double unitPrice;
  int quantitySold;
  DateTime createdAt;
  DateTime updatedAt;
  int stock;

  Sale({
    required this.id,
    required this.name,
    required this.unitPrice,
    required this.quantitySold,
    required this.createdAt,
    required this.updatedAt,
    required this.stock,
  });
}
