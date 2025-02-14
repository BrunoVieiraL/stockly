import 'package:stockly/domain/models/dashboard/dashboard.dart';
import 'package:stockly/domain/models/sales/sale.dart';
import 'package:stockly/utils/result.dart';

class DataChart {
  dynamic x;
  double y;

  DataChart({
    required this.x,
    required this.y,
  });

  @override
  String toString() => 'DataChart(x: $x, y: $y)';
}

abstract class DashboardRepository {
  Future<Result<Dashboard>> getHeaderData();

  Future<Result<List<Sale>>> getMostSaleProducts();

  Future<Result<List<DataChart>>> getRevenueData();
}
