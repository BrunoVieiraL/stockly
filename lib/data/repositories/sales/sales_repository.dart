import 'package:stockly/domain/models/sales/sale.dart';
import 'package:stockly/utils/result.dart';

abstract class SalesRepository {
  Future<Result<List<Sale>>> getSales();

  Future<Result<List<Sale>>> addSale(List<Sale> listSale);

  Future<Result<List<Sale>>> deleteSale(int id);
}
