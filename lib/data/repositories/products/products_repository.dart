import 'package:stockly/domain/models/product/product.dart';
import 'package:stockly/utils/result.dart';

abstract class ProductsRepository {
  Future<Result<List<Product>>> getProducts();

  Future<Result<List<Product>>> addProduct(Product product);

  Future<Result<List<Product>>> deleteProduct(String id);
}
