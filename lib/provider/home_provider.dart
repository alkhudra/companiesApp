import 'package:flutter/material.dart';
import 'package:khudrah_companies/network/models/home/home_success_response_model.dart';
import 'package:khudrah_companies/network/models/product/product_model.dart';
import 'package:khudrah_companies/network/models/user_model.dart';

class HomeProvider with ChangeNotifier {
  HomeSuccessResponseModel homeModel = HomeSuccessResponseModel();
  List<ProductsModel>? homePageList = [];

  User user = User(id: 'id');

  BuildContext context;

  bool alreadyHasData = false;

  HomeProvider(this.context);



  ///////-----product
  setHomeProductList(List<ProductsModel>? _productsList) {
    homePageList = _productsList;
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

  getHomeCategoryList() {
    return homeModel.categoriesList;
  }

  getHomeProductList() {
    return homeModel.productsList;
  }
}
