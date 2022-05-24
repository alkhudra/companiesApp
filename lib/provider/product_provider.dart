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
  List<ProductsModel>? productsList = [];
  List<ProductsModel>? cartList = [];
  List<ProductsModel>? searchPageList = [];
  HomeSuccessResponseModel homeModel = HomeSuccessResponseModel();
  List<ProductsModel>? homePageList = [];
  List<CategoryItem> categoryList = [];
  BuildContext context;
  User user = User(id: 'id');
  bool alreadyHasData = false;

  ProductProvider(this.context);

  ////////////////////////
  ////// home ///////////
  ///////////////////////

  ///////-----category

  get categoryListCount{
    return categoryList.length;
  }
  get homeCategoryList{
    return categoryList;
  }
  setHomeCategoryList(List<CategoryItem>? _categoryList){
    String categoryName = LocaleKeys.all_category.tr();

    categoryList.insert(0, CategoryItem(name: categoryName, arName: categoryName));

    categoryList .insertAll(1, _categoryList!) ;
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
  getUser(){
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

  get getHomeModel{
    return homeModel;
  }


  ////////////////////////////
  ////// product ////////////
  ////////////////////////////


  setProductList(List<ProductsModel>? _productsList) {
    productsList = _productsList;
    //notifyListeners();
  }

  UnmodifiableListView<ProductsModel> get getProductList {
    //  if(favList.length =0)
    return UnmodifiableListView(productsList!);
    // else return loadData();
  }

  int get productListCount {
    return productsList!.length;
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

  ////////////////////////////
  ////// favorite ////////////
  ////////////////////////////

  setFavList(List<ProductsModel> list) {
    favList = list;
    //  notifyListeners();
  }

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

  ////////////////////////////
  ////////// search ////////////
  ////////////////////////////

  bool _isNewSearch = true;
  resetSearchList(){
   // productsList!.removeWhere((element) => searchPageList!.contains(element.productId) );
    searchPageList = [];
    _isNewSearch = true;
    print('search list is reset  @@@@@@@@@@@@@@@@@@@@');
  }

  get isNewSearch{
    return _isNewSearch;
  }
  int get searchPageListCount {
    return searchPageList!.length;
  }
  addItemsToSearchList(List<ProductsModel> pagingList ) {
    var set = searchPageList!.toSet();
    set.addAll(pagingList);
    searchPageList = set.toList();
    plusPageNumber();
    _isNewSearch = false;


    //  addItemsToProductList(pagingList);

  }

  ////////////////////////////
  ////////// cart ////////////
  ////////////////////////////

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


  ////////////////////////////
  ////// pagination //////////
  ////////////////////////////


  int pageNumber = 1;
  bool isThereMoreItems = true;

  void saveLoadMoreDataStatus(bool newStatus) {
    isThereMoreItems = newStatus;
    notifyListeners();
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
