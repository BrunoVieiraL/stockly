import 'package:stockly/data/repositories/dashboard/dashboard_repository.dart';
import 'package:stockly/domain/models/dashboard/dashboard.dart';
import 'package:stockly/domain/models/sales/sale.dart';
import 'package:stockly/utils/result.dart';

class DashboardRepositoryRemote extends DashboardRepository {
  @override
  Future<Result<Dashboard>> getHeaderData() {
    // TODO: implement getDashboardData
    throw UnimplementedError();
  }

  @override
  Future<Result<List<Sale>>> getMostSaleProducts() {
    // TODO: implement getMostSaleProducts
    throw UnimplementedError();
  }

  @override
  Future<Result<List<DataChart>>> getRevenueData() {
    // TODO: implement getRecipeDashboardData
    throw UnimplementedError();
  }
}
