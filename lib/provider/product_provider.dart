import 'dart:collection';
import 'package:collection/src/iterable_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:khudrah_companies/network/models/product/product_model.dart';

class ProductProvider with ChangeNotifier {
  List<ProductsModel> favList = [];
  List<ProductsModel>? productsList = [];
  List<ProductsModel>? cartList = [];
  List<ProductsModel>? homePageList = [];
  List<ProductsModel>? searchPageList = [];

  BuildContext context;
  void resetSearchProvider() {
    searchPageList!.clear();
    pageNumber = 1;
    isThereMoreItems = true;
  }
  void resetProvider() {
    productsList!.clear();
    pageNumber = 1;
    isThereMoreItems = true;
  }

  setHomeProductList(List<ProductsModel>? _productsList) {
    homePageList = _productsList;
  }


  setProductList(List<ProductsModel>? _productsList) {
    productsList = _productsList;
    //notifyListeners();
  }

  UnmodifiableListView<ProductsModel> get getProductList {
    //  if(favList.length =0)
    return UnmodifiableListView(productsList!);
    // else return loadData();
  }

  setFavList(List<ProductsModel> list) {
    favList = list;
    //  notifyListeners();
  }

  UnmodifiableListView<ProductsModel> get getfavList {
    //  if(favList.length =0)
    return UnmodifiableListView(favList);
    // else return loadData();
  }

  ProductProvider(this.context);

  int get favListCount {
    return favList.length;
  }

  int get productListCount {
    return productsList!.length;
  }

  int get productHomeListCount {
    return homePageList!.length;
  }
  addItemsToProductList(List<ProductsModel> pagingList) {
    var set = productsList!.toSet();
    set.addAll(pagingList);
    productsList = set.toList();
    plusPageNumber();

    for (ProductsModel? productsModel in productsList!) {
      if (productsModel!.isAddedToCart!) cartList!.add(productsModel);
    }
    for (ProductsModel? productsModel in productsList!) {
      if (productsModel!.isFavourite!) favList.add(productsModel);
    }
    //  favList.insertAll(favList.indexOf(favList.last),pagingList);
    notifyListeners();
  }

  //---------cart----------
  addCartItemToCartList(ProductsModel model) {
    model.userProductQuantity = model.userProductQuantity! + 1;
    cartList!.insert(0, model);

    print('item added to cart list provider');
    notifyListeners();
  }

  bool isItemInCartList(ProductsModel model) {
    final id = model.productId;
    ProductsModel? productsModel = cartList!.firstWhereOrNull((element) {
      return element.productId == id;
    });
    if (productsModel != null) {
      return true;
    } else
      return false;
  }

  int getQtyOfItem(ProductsModel model) {
    int qty = model.userProductQuantity!;

    final id = model.productId;
    ProductsModel? productsModel = cartList!.firstWhereOrNull((element) {
      return element.productId == id;
    });

    if (productsModel != null) {
      return qty;
    } else {
      return 0;
    }
  }

  increaseQtyOfItem(ProductsModel model) {
    int qty = model.userProductQuantity!;

    qty++;
    final id = model.productId;
    ProductsModel? productsModel = cartList!.firstWhereOrNull((element) {
      return element.productId == id;
    });

    if (productsModel != null) {
      productsModel.userProductQuantity = qty;
      notifyListeners();
    }
  }

  decreaseQtyOfItem(ProductsModel model) {
    int qty = model.userProductQuantity!;

    qty--;
    final id = model.productId;
    ProductsModel? productsModel = cartList!.firstWhereOrNull((element) {
      return element.productId == id;
    });

    if (productsModel != null) {
      productsModel.userProductQuantity = qty;
      notifyListeners();
    }
  }

  removeItemFromCartList(ProductsModel model) {
    final id = model.productId;
    ProductsModel? productsModel = cartList!.firstWhereOrNull((element) {
      return element.productId == id;
    });
    if (productsModel != null) {
      model.userProductQuantity = 0;

      cartList!.remove(productsModel);
      print('item removed from cart list provider');

      notifyListeners();
    }
  }
  //---------Favorite----------

  addFavItemToFavList(ProductsModel model) {
    favList.insert(0, model);
    print('item added to fav provider');
    notifyListeners();
  }

  removeFavItemFromFavList(ProductsModel model) {
    final id = model.productId;
    ProductsModel? productsModel = favList.firstWhereOrNull((element) {
      return element.productId == id;
    });
    if (productsModel != null) {
      favList.remove(productsModel);
      print('item removed from fav provider');

      notifyListeners();
    }
  }

  addItemsToFavList(List<ProductsModel> pagingList) {
    var set = favList.toSet();
    set.addAll(pagingList);
    favList = set.toList();
    plusPageNumber();
    notifyListeners();
  }

  bool isItemInFavList(ProductsModel model) {
    final id = model.productId;
    ProductsModel? productsModel = favList.firstWhereOrNull((element) {
      return element.productId == id;
    });
    if (productsModel != null) {
      return true;
    } else
      return false;
  }

  //////----------pagination-------------------
  int pageNumber = 1;
  bool isThereMoreItems = true;

  void saveLoadMoreDataStatus(bool newStatus) {
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
