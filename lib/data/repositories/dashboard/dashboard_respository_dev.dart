// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:stockly/data/repositories/dashboard/dashboard_repository.dart';
import 'package:stockly/domain/models/dashboard/dashboard.dart';
import 'package:stockly/domain/models/sales/sale.dart';
import 'package:stockly/utils/result.dart';

class DashboardRespositoryDev extends DashboardRepository {
  @override
  Future<Result<List<Sale>>> getMostSaleProducts() async {
    return Result.ok(
      <Sale>[
        Sale(
          id: 1,
          name: 'Produto 1',
          unitPrice: 40.00,
          stock: 10,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          quantitySold: 5,
          saleTotal: 5 * 40,
        ),
        Sale(
          id: 2,
          name: 'Produto 2',
          unitPrice: 50.00,
          stock: 10,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          quantitySold: 10,
          saleTotal: 10 * 50,
        ),
        Sale(
          id: 3,
          name: 'Produto 3',
          unitPrice: 60.00,
          stock: 10,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          quantitySold: 5,
          saleTotal: 5 * 60,
        ),
      ],
    );
  }

  @override
  Future<Result<Dashboard>> getHeaderData() async {
    return Result.ok(
      Dashboard(
        totalRecipe: 2500.0,
        todayRecipe: 300.0,
        totalSales: 150,
        stock: 5000,
        products: 10,
      ),
    );
  }

  @override
  Future<Result<List<DataChart>>> getRevenueData() async {
    return Result.ok(
      [
        DataChart(x: DateTime(2025, 1, 1), y: 100),
        DataChart(x: DateTime(2025, 1, 2), y: 150),
        DataChart(x: DateTime(2025, 1, 3), y: 50),
        DataChart(x: DateTime(2025, 1, 4), y: 200),
        DataChart(x: DateTime(2025, 1, 5), y: 250),
      ],
    );
  }
}
