import 'package:dio/dio.dart';
import 'package:stockly/domain/models/product/product.dart';
import 'package:stockly/utils/result.dart';

class ApiClient {
  static const String url = 'https://stockly.pegorari.tech/api';
  static const String productEndpoint = '/products';
  static const String saleEndpoint = '/sales';
  static final Dio dio = Dio();

  static Future<Result<List<Product>>> getProducts() async {
    try {
      List<Product> products = [];
      Response response = await dio.get('$url$productEndpoint');
      List data = response.data;
      for (var element in data) {
        products.add(Product.fromJson(element));
      }

      return Result.ok(products);
    } on DioException catch (e) {
      return Result.error(e);
    }
  }

  static Future<Result<void>> addProduct(Product product) async {
    try {
      Response response = await dio.post(
        '$url$productEndpoint',
        data: {
          "name": product.name,
          "price": product.price,
          "stock": product.stock,
        },
      );
      response.statusCode;
      return Result.ok(null);
    } on DioException catch (e) {
      return Result.error(e);
    }
  }

  static Future<Result<void>> deleteProduct(String id) async {
    try {
      Response response = await dio.delete(
        '$url$productEndpoint',
        data: {"id": id},
      );
      response.statusCode;
      return Result.ok(null);
    } on DioException catch (e) {
      return Result.error(e);
    }
  }
}
