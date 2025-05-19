import 'package:stockly/data/repositories/sales/sales_repository.dart';
import 'package:stockly/domain/models/sales/sale.dart';
import 'package:stockly/utils/result.dart';

class SalesRepositoryDev extends SalesRepository {
  List<Sale> sales = [
    Sale(
      id: 1,
      name: 'Teste1',
      unitPrice: 54.05,
      quantitySold: 452,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      stock: 452,
    ),
  ];

  @override
  Future<Result<List<Sale>>> deleteSale(int id) async {
    sales.removeWhere((element) => element.id == id);
    return Result.ok(sales);
  }

  @override
  Future<Result<List<Sale>>> addSale(List<Sale> listSale) async {
    return Result.ok(sales);
  }

  @override
  Future<Result<List<Sale>>> getSales() async {
    return Result.ok(sales);
  }
}
