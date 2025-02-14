import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:stockly/data/repositories/products/products_repository.dart';
import 'package:stockly/domain/models/product/product.dart';
import 'package:stockly/utils/command.dart';
import 'package:stockly/utils/result.dart';

class ProdutcsViewmodel extends ChangeNotifier {
  ProdutcsViewmodel({required ProductsRepository productsRepository})
      : _productsRepository = productsRepository {
    load = Command0(_load)..execute();
  }
  final ProductsRepository _productsRepository;
  late Command0 load;
  final Logger _log = Logger('ProductsViewModel');

  ValueNotifier<List<Product>>? _products;
  ValueNotifier<List<Product>>? get products => _products;

  Future<Result<void>> _load() async {
    try {
      final productsResult = await _productsRepository.getProducts();
      switch (productsResult) {
        case Ok<List<Product>>():
          _products = ValueNotifier(productsResult.value);
          _log.fine('Products obtained');
        case Error<List<Product>>():
          _log.warning('Failed to obtain Products');
          return productsResult;
      }

      return productsResult;
    } finally {
      notifyListeners();
    }
  }

  Future<Result<void>> addProduct(Product product) async {
    try {
      final productsResult = await _productsRepository.addProduct(product);
      switch (productsResult) {
        case Ok<List<Product>>():
          _products = ValueNotifier(productsResult.value);
          _log.fine('Product added');
        case Error<List<Product>>():
          _log.warning('Failed to add Product');
          return productsResult;
      }
      return productsResult;
    } finally {
      notifyListeners();
    }
  }

  Future<Result<void>> deleteProduct(String id) async {
    try {
      final productsResult = await _productsRepository.deleteProduct(id);
      switch (productsResult) {
        case Ok<List<Product>>():
          _products = ValueNotifier(productsResult.value);
          _log.fine('Product deleted');
        case Error<List<Product>>():
          _log.warning('Failed to delete Product');
          return productsResult;
      }
      return productsResult;
    } finally {
      products;
      notifyListeners();
      products;
    }
  }
}
