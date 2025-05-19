// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:stockly/data/repositories/sales/sales_repository.dart';

import 'package:stockly/domain/models/sales/sale.dart';
import 'package:stockly/utils/command.dart';
import 'package:stockly/utils/result.dart';

class SalesViewmodel extends ChangeNotifier {
  SalesViewmodel({required SalesRepository salesRepository})
      : _salesRepository = salesRepository {
    load = Command0(_load)..execute();
  }
  late Command0 load;
  final SalesRepository _salesRepository;
  final Logger _log = Logger('SalesViewModel');

  ValueNotifier<List<Sale>>? _sales;

  ValueNotifier<List<Sale>>? get sales => _sales;

  Future<Result<void>> _load() async {
    try {
      var salesResult = await _salesRepository.getSales();
      switch (salesResult) {
        case Ok<List<Sale>>():
          _sales = ValueNotifier(salesResult.value);
          _log.fine('Sales obtained');
        case Error<List<Sale>>():
          _log.warning('Failed to obtain sales');
          return salesResult;
      }
      return salesResult;
    } finally {
      notifyListeners();
    }
  }

  Future<Result<void>> addSale(List<Sale> listSale) async {
    try {
      var salesResult = await _salesRepository.addSale(listSale);
      switch (salesResult) {
        case Ok<List<Sale>>():
          _sales = ValueNotifier(salesResult.value);
          _log.fine('Sale added');
        case Error<List<Sale>>():
          _log.warning('Failed to add Sale');
          return salesResult;
      }
      return salesResult;
    } finally {
      notifyListeners();
    }
  }

  Future<Result<void>> deleteSale(int id) async {
    try {
      var salesResult = await _salesRepository.deleteSale(id);
      switch (salesResult) {
        case Ok<List<Sale>>():
          _sales = ValueNotifier(salesResult.value);
          _log.fine('Sale deleted');
        case Error<List<Sale>>():
          _log.warning('Failed to delete Sale');
          return salesResult;
      }
      return salesResult;
    } finally {
      notifyListeners();
    }
  }
}
