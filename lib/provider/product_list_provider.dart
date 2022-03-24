import 'package:flutter/material.dart';
import 'package:khudrah_companies/designs/product_card.dart';

class ProductListProvider with ChangeNotifier {
  int qty = 0;

  increaseQty(int? _qty ,context , productId) {
    qty = _qty!;
    qty++;
    ProductCard.addQtyToCart(context, productId);

    print('qty is $qty');
    notifyListeners();
  }

  addToCart(context , productId) {
    qty = 1;
    print('qty is $qty');
    ProductCard.addToCart(context, productId);

    notifyListeners();
  }

  deleteFromCart(context , productId) {
    qty = 0;
    print('qty is $qty');
    ProductCard.deleteFromCart(context, productId);

    notifyListeners();
  }

  decreaseQty(int? _qty,context , productId) {
    qty = _qty!;
    qty--;
    print('qty is $qty');
    ProductCard.deleteQtyFromCart(context, productId);

    notifyListeners();
  }

  setQty(int? _qty) {
    _qty = this.qty;
    print('qty is $qty');
  }
}
