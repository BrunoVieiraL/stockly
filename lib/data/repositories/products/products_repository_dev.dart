import 'package:stockly/data/repositories/products/products_repository.dart';
import 'package:stockly/domain/models/product/product.dart';
import 'package:stockly/utils/result.dart';

class ProductsRepositoryDev extends ProductsRepository {
  List<Product> listProducts = [
    Product(
      id: 'adasd1755',
      name: 'Teste1',
      price: 50,
      stock: 10,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Product(
      id: 'adasd1756',
      name: 'Teste2',
      price: 500,
      stock: 100,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Product(
      id: 'adasd1757',
      name: 'Teste3',
      price: 5,
      stock: 1,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Product(
      id: 'adasd1758',
      name: 'Teste4',
      price: 20,
      stock: 20,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Product(
      id: 'adasd1759',
      name: 'Teste5',
      price: 60,
      stock: 40,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];

  @override
  Future<Result<List<Product>>> getProducts() async {
    return Result.ok(listProducts);
  }

  @override
  Future<Result<List<Product>>> deleteProduct(String id) async {
    listProducts.removeWhere((element) => element.id == id);
    return Result.ok(listProducts);
  }

  @override
  Future<Result<List<Product>>> addProduct(Product product) async {
    Product prod = Product(
      id: listProducts.last.id ?? 'adasd175' '${listProducts.length}',
      name: product.name,
      price: product.price,
      stock: product.stock,
      createdAt: product.createdAt,
      updatedAt: product.updatedAt,
    );
    listProducts.add(prod);
    return Result.ok(listProducts);
  }
}
