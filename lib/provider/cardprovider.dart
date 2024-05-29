import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  int _itemCount = 0;

  int get itemCount => _itemCount;

  void addItem() {
    _itemCount++;
    notifyListeners(); // Notifica os listeners que o estado mudou
  }
}