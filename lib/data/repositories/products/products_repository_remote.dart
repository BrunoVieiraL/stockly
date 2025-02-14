import 'package:stockly/data/repositories/products/products_repository.dart';
import 'package:stockly/data/services/api_client.dart';
import 'package:stockly/domain/models/product/product.dart';
import 'package:stockly/utils/result.dart';

class ProductsRepositoryRemote extends ProductsRepository {
  @override
  Future<Result<List<Product>>> addProduct(Product product) async {
    var productResult = await ApiClient.addProduct(product);
    switch (productResult) {
      case Ok():
        return await getProducts();
      case Error():
        return Result.error(productResult.error);
    }
  }

  @override
  Future<Result<List<Product>>> deleteProduct(String id) async {
    var productResult = await ApiClient.deleteProduct(id);
    switch (productResult) {
      case Ok():
        return await getProducts();
      case Error():
        return Result.error(productResult.error);
    }
  }

  @override
  Future<Result<List<Product>>> getProducts() async {
    var productResult = await ApiClient.getProducts();
    switch (productResult) {
      case Ok<List<Product>>():
        return productResult;

      case Error<List<Product>>():
        return productResult;
    }
  }
}
