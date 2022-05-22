import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:khudrah_companies/Constant/conts.dart';
import 'package:khudrah_companies/designs/product_card.dart';
import 'package:khudrah_companies/helpers/cart_helper.dart';
import 'package:khudrah_companies/network/models/product/product_model.dart';

class ProductListProvider with ChangeNotifier {
  int qty;
  List<ProductsModel>? productsList = [];

  BuildContext context;


  ProductListProvider(this.context, {this.productsList, this.qty = 0});
  UnmodifiableListView<ProductsModel> get items =>
      UnmodifiableListView(productsList!);

  int get listCount {
    return productsList!.length;
  }

  setList(List<ProductsModel>? productsList) {
    this.productsList = productsList;
  }

  increaseQty(int _qty, productId) async {
    qty = _qty;
    qty = qty + 1;
    await cartDBProcessProvider(context, productId, addQtyToCartConst)
        .then((resultMap) {
      if (resultMap.values.first == true) {
        print(resultMap.values.last);
        notifyListeners();
      }
    });
    print('qty is $qty');
  }

  addToCart(productId) async {
    qty = 1;
    await cartDBProcessProvider(context, productId, addToCartConst)
        .then((resultMap) {
      if (resultMap.values.first == true) {
        print(resultMap.values.last);
        notifyListeners();
      }
    });
    print('qty is $qty');
  }

  deleteFromCart(productId) {
    qty = 0;
    print('qty is $qty');
    ProductCard.deleteFromCart(context, productId);

    notifyListeners();
  }

  decreaseQty(int? _qty, productId) {
    qty = _qty!;
    qty--;
    print('qty is $qty');
    ProductCard.deleteQtyFromCart(context, productId);

    notifyListeners();
  }

  addToFav(bool isFavourite, productId) {
    ProductCard.addToFav(context, isFavourite, productId);
    notifyListeners();
  }
}
