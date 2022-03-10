import 'package:flutter/material.dart';

class ProductListProvider with ChangeNotifier {
  int qty = 0;

  increaseQty() {
    qty++;
    print('qty is $qty');
    notifyListeners();
  }

  addToCart() {
    qty = 1;
    print('qty is $qty');
    notifyListeners();
  }

  deleteFromCart() {
    qty = 0;
    print('qty is $qty');
    notifyListeners();
  }

  decreaseQty() {

    qty--;
    print('qty is $qty');
    notifyListeners();
  }

  setQty(int? _qty) {
    _qty = this.qty;
    print('qty is $qty');
  }
}
