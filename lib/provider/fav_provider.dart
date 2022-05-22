import 'dart:collection';

import 'package:collection/src/iterable_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:khudrah_companies/network/models/branches/branch_list_response_model.dart';
import 'package:khudrah_companies/network/models/branches/branch_model.dart';
import 'package:khudrah_companies/network/models/product/product_model.dart';

class FavoriteProvider with ChangeNotifier {
  List<ProductsModel> favList = [];

  BuildContext context;

  FavoriteProvider(this.context);

  int pageNumber = 1;
  bool isThereMoreItems = true;

  setFavList(List<ProductsModel> list) {
    favList = list;
    notifyListeners();
  }

  addFavToList(ProductsModel model) {
    favList.insert(0, model);
    notifyListeners();
  }

  removeFavItemFromList(ProductsModel model) {
    final id = model.productId;
    ProductsModel? productsModel = favList.firstWhereOrNull((element) {
      return element.productId == id;
    });
    if (productsModel != null) {
      favList.remove(productsModel);
      notifyListeners();
    }
  }

  addMoreItemsToList(List<ProductsModel> pagingList) {

    favList.addAll(pagingList);
    plusPageNumber();

    //  favList.insertAll(favList.indexOf(favList.last),pagingList);
    notifyListeners();
  }

  int get listCount {
    return favList.length;
  }

  UnmodifiableListView<ProductsModel> get getfavList {
    //  if(favList.length =0)
    return UnmodifiableListView(favList);
    // else return loadData();
  }


  //////---------


  void saveLoadMoreDataStatus( bool newStatus) {
    isThereMoreItems = newStatus;
  }

  bool get getLoadMoreDataStatus {
    return isThereMoreItems;
  }
  //////---------

  void plusPageNumber() {
    pageNumber += 1;
  }

  void resetPageNumber() {
    pageNumber = 1;
  }

  int get getPageNumber {
    return pageNumber;
  }
}
