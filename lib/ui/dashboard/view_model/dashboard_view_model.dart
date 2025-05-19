// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:stockly/data/repositories/dashboard/dashboard_repository.dart';
import 'package:stockly/domain/models/dashboard/dashboard.dart';
import 'package:stockly/domain/models/sales/sale.dart';
import 'package:stockly/utils/command.dart';
import 'package:stockly/utils/result.dart';

class DashboardViewmodel extends ChangeNotifier {
  DashboardViewmodel({required DashboardRepository dashboardRepository})
      : _dashboardRepository = dashboardRepository {
    load = Command0(_load)..execute();
  }
  final DashboardRepository _dashboardRepository;

  final Logger _log = Logger('DashboardViewModel');

  Dashboard? _dashboard;
  Dashboard? get dashboard => _dashboard;
  List<Sale>? _mostSalesProducts;
  List<Sale>? get mostSalesProducts => _mostSalesProducts;
  List<DataChart>? _revenueChart;
  List<DataChart>? get revenueChart => _revenueChart;

  late Command0 load;

  Future<Result<void>> _load() async {
    try {
      final dashboardResult = await _dashboardRepository.getHeaderData();
      switch (dashboardResult) {
        case Ok<Dashboard>():
          _dashboard = dashboardResult.value;
          _log.fine('Total Recipe obtained');
        case Error<Dashboard>():
          _log.warning('Failed to obtain Total Recipe', dashboardResult);
          return dashboardResult;
      }
      final salesResult = await _dashboardRepository.getMostSaleProducts();
      switch (salesResult) {
        case Ok<List<Sale>>():
          _mostSalesProducts = salesResult.value;
          if (_mostSalesProducts != null) {
            if (mostSalesProducts!.length > 5) {
              _mostSalesProducts!.removeRange(5, _mostSalesProducts!.length);
            }
            _mostSalesProducts!
                .sort((a, b) => b.quantitySold.compareTo(a.quantitySold));
          }
          _log.fine('Most Sale Products obtained');
        case Error<List<Sale>>():
          _log.warning(
            'Failed to obtain Most Sale Products',
            salesResult.error,
          );
          return salesResult;
      }

      final chartResult = await _dashboardRepository.getRevenueData();
      switch (chartResult) {
        case Ok<List<DataChart>>():
          _revenueChart = chartResult.value;
          _log.fine('Chart Data Obtained');
        case Error<List<DataChart>>():
          _log.warning(
            'Failed to obtain Chart Data',
            chartResult.error,
          );
          return chartResult;
      }

      return dashboardResult;
    } finally {
      notifyListeners();
    }
  }
}
