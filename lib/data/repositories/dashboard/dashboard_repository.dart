import 'package:flutter/material.dart';
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
}

abstract class DashboardRepository extends ChangeNotifier {
  Future<Result<Dashboard>> getHeaderData();

  Future<Result<List<Sale>>> getMostSaleProducts();

  Future<Result<List<DataChart>>> getRevenueData();
}
