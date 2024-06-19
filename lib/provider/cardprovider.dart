import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  int _itemCount = 0;
  int get itemCount => _itemCount;
  final List<Map<String, dynamic>>  _products = [];
  List<Map<String, dynamic>> get products => _products;


  void addProduct(String product, int quantity, String value) {
    final existingProductIndex = _products.indexWhere((item) => item['product'] == product);


    if (existingProductIndex != -1) {
      _products[existingProductIndex] = {
        'product': product,
        'qty': _products[existingProductIndex]['qty'] + quantity,
      };
    } else {
      _products.add({
        'product': product,
        'qty': quantity,
        'value': value
      });

    }
    notifyListeners();
  }

  void clearCart() {
    _products.clear();
    notifyListeners();
  }

  void addItem() {
    _itemCount++;
    notifyListeners();
  }

  void removeItem() {
    _itemCount --;
    notifyListeners();
  }

  void endCount() {
    _itemCount = 0;
    notifyListeners();
  }
}