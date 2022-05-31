import 'dart:collection';
import 'package:collection/src/iterable_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/network/models/home/home_success_response_model.dart';
import 'package:khudrah_companies/network/models/product/category_model.dart';
import 'package:khudrah_companies/network/models/product/product_model.dart';
import 'package:khudrah_companies/network/models/user_model.dart';
import 'package:easy_localization/easy_localization.dart';

class ProductProvider with ChangeNotifier {
  List<ProductsModel> favList = [];
  List<ProductsModel> productsList = [];
  List<ProductsModel> cartList = [];
  List<ProductsModel> searchPageList = [];
  HomeSuccessResponseModel homeModel = HomeSuccessResponseModel();
  List<ProductsModel>? homePageList = [];
  List<CategoryItem> categoryList = [];
  BuildContext context;
  User user = User(id: 'id');
  bool alreadyHasData = false;

  ProductProvider(this.context);

  resetProductList() {
    productsList = [];
    isThereMoreItems = true;
    //  notifyListeners();
    print('/////////// @@@@@@@@@@@@@@@@@@@ product list reset done');
  }

  clearProvider() {
    favList = [];
    cartList = [];
    productsList = [];
    categoryList = [];
    searchPageList = [];
    homePageList = [];
  }
  ////////////////////////
  ////// home ///////////
  ///////////////////////

  ///////-----category

  get categoryListCount {
    return categoryList.length;
  }

  get homeCategoryList {
    return categoryList;
  }

  setHomeCategoryList(List<CategoryItem>? _categoryList) {
    String categoryName = LocaleKeys.all_category.tr();

    categoryList.insert(
        0, CategoryItem(name: categoryName, arName: categoryName));

    //categoryList .insertAll(1, _categoryList!) ;
    categoryList += _categoryList!;
    categoryList = categoryList.toSet().toList();
    notifyListeners();
  }

  ///////-----product
  setHomeProductList(List<ProductsModel>? _productsList) {
    homePageList = _productsList;
    addItemsToProductList(_productsList!);
  }

  int get productHomeListCount {
    return homePageList!.length;
  }

  //------- user
  setUser(User _user) {
    user = _user;
  }

  getUser() {
    return user;
  }

//-- general
  setAlreadyHasDataStatus(bool _alreadyHasData) {
    alreadyHasData = _alreadyHasData;
    notifyListeners();
  }

  bool getAlreadyHasData() {
    return alreadyHasData;
  }

  setHomeModel(HomeSuccessResponseModel model) {
    homeModel = model;
    // notifyListeners();
  }

  get getHomeModel {
    return homeModel;
  }

  ////////////////////////////
  ////// product ////////////
  ////////////////////////////

  setProductList(List<ProductsModel> _productsList) {
    productsList = _productsList;
    //notifyListeners();
  }

  UnmodifiableListView<ProductsModel> get getProductList {
    //  if(favList.length =0)
    return UnmodifiableListView(productsList);
    // else return loadData();
  }

  int get productListCount {
    return productsList.length;
  }

  addItemsToProductList(List<ProductsModel> pagingList) {
    productsList.addAll(pagingList
        .where((a) => productsList.every((b) => a.productId != b.productId)));

    List<ProductsModel> favList1 = [];
    List<ProductsModel> cartList1 = [];

    for (ProductsModel? productsModel in productsList) {
      if (productsModel!.isAddedToCart!) cartList1.add(productsModel);
    }
    for (ProductsModel? productsModel in pagingList) {
      if (productsModel!.isFavourite!) favList1.add(productsModel);
    }

    addItemsToFavList(favList1);
    addItemsToCartList(cartList1);
    print('product list items is ' + productsList.toString());

 //   notifyListeners();
  }

  ////////////////////////////
  ////// favorite ////////////
  ////////////////////////////

  UnmodifiableListView<ProductsModel> get getfavList {
    //  if(favList.length =0)
    return UnmodifiableListView(favList);
    // else return loadData();
  }

  int get favListCount {
    return favList.length;
  }

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
    favList.addAll(pagingList
        .where((a) => favList.every((b) => a.productId != b.productId)));

    print("fav list items are " + favList.toString());
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

  ////////////////////////////
  ////////// search ////////////
  ////////////////////////////

  resetSearchList() {
    searchPageList = [];
    resetPageNumber();
    isThereMoreItems = true;
    print('search list is reset  @@@@@@@@@@@@@@@@@@@@');
    // notifyListeners();
  }

  int get searchPageListCount {
    return searchPageList.length;
  }

  addItemsToSearchList(List<ProductsModel> pagingList) {
    searchPageList.addAll(pagingList
        .where((a) => searchPageList.every((b) => a.productId != b.productId)));


    print('search list is ' + searchPageList .toString());
    addItemsToProductList(pagingList);
  }

  ////////////////////////////
  ////////// cart ////////////
  ////////////////////////////

  addItemsToCartList(List<ProductsModel> pagingList) {
    cartList.addAll(pagingList
        .where((a) => cartList.every((b) => a.productId != b.productId)));
/*
    cartList += pagingList;
*/ /*    for(ProductsModel productsModel in pagingList) {
      if (favList.contains(productsModel.productId)){
        print('delete item ' + productsModel.name!);
        favList.remove(productsModel);
      }
    }*/ /*

    cartList = cartList.toSet().toList();*/
    print('cart list ' + cartList.toString());
    notifyListeners();
  }

  addCartItemToCartList(ProductsModel model) {
    model.userProductQuantity = model.userProductQuantity! + 1;
    cartList.insert(0, model);

    print('item added to cart list provider');
    notifyListeners();
  }

  bool isItemInCartList(ProductsModel model) {
    final id = model.productId;

    return cartList.contains(id);
    /*   ProductsModel? productsModel = cartList.firstWhereOrNull((element) {
      return element.productId == id;
    });
    if (productsModel != null) {
      return true;
    } else
      return false;*/
  }

  int getQtyOfItem(ProductsModel model) {
    int qty = model.userProductQuantity!;

    final id = model.productId;
    ProductsModel? productsModel = cartList.firstWhereOrNull((element) {
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
    ProductsModel? productsModel = cartList.firstWhereOrNull((element) {
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
    ProductsModel? productsModel = cartList.firstWhereOrNull((element) {
      return element.productId == id;
    });

    if (productsModel != null) {
      productsModel.userProductQuantity = qty;
      notifyListeners();
    }
  }

  removeItemFromCartList(ProductsModel model) {
    final id = model.productId;
    ProductsModel? productsModel = cartList.firstWhereOrNull((element) {
      return element.productId == id;
    });
    if (productsModel != null) {
      model.userProductQuantity = 0;

      cartList.remove(productsModel);
      print('item removed from cart list provider');
      print('items in cart list ' + cartList.toString());

      notifyListeners();
    }
  }

  ////////////////////////////
  ////// pagination //////////
  ////////////////////////////

  int pageNumber = 1;
  bool isThereMoreItems = true;

  void saveLoadMoreDataStatus(bool newStatus) {
    isThereMoreItems = newStatus;
    print('isThereMoreItems == $isThereMoreItems');
    notifyListeners();
  }

  bool get getLoadMoreDataStatus {
    return isThereMoreItems;
  }
  //////---------

  void plusPageNumber() {
    pageNumber += 1;
    print(' /// pageNumber now is $pageNumber /// ');
  }

  void resetPageNumber() {
    pageNumber = 1;
    print(' /// pageNumber now is $pageNumber /// ');

  }

  int get getPageNumber {
    return pageNumber;
  }
}
