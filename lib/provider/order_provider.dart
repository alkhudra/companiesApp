import 'dart:collection';

import 'package:collection/src/iterable_extensions.dart';
import 'package:flutter/cupertino.dart';

import 'package:khudrah_companies/network/models/orders/order_header.dart';

class OrderProvider with ChangeNotifier {
  List<OrderHeader> orderList = [];

  BuildContext context;

  OrderProvider(this.context);

  int pageNumber = 1;
  bool isThereMoreItems = true;



  addFavToList(OrderHeader model) {
    orderList.insert(0, model);
    notifyListeners();
  }

  removeFavItemFromList(OrderHeader model) {
    final id = model.id;
    OrderHeader? orderHeader = orderList.firstWhereOrNull((element) {
      return element.id == id;
    });
    if (orderHeader != null) {
      orderList.remove(orderHeader);
      notifyListeners();
    }
  }

  addMoreItemsToList(List<OrderHeader> pagingList) {

    orderList.addAll(pagingList);
    plusPageNumber();

    //  orderList.insertAll(orderList.indexOf(orderList.last),pagingList);
    notifyListeners();
  }

  int get listCount {
    return orderList.length;
  }

  UnmodifiableListView<OrderHeader> get getorderList {
    //  if(orderList.length =0)
    return UnmodifiableListView(orderList);
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
