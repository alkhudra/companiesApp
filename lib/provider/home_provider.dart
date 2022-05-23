

import 'package:flutter/material.dart';
import 'package:khudrah_companies/network/models/home/home_success_response_model.dart';

class HomeProvider with ChangeNotifier {
  HomeSuccessResponseModel homeModel = HomeSuccessResponseModel();

  BuildContext context;

  bool alreadyHasData = false;

  HomeProvider(this.context);

  setAlreadyHasDataStatus(bool _alreadyHasData){
    alreadyHasData =_alreadyHasData;
    notifyListeners();
  }
  bool getAlreadyHasData(){
    return alreadyHasData;
  }
  setHomeModel(HomeSuccessResponseModel model){
    homeModel = model;
   // notifyListeners();
  }

  getHomeCategoryList(){
    return homeModel.categoriesList;
  }
  getHomeProductList(){
    return homeModel.productsList;
  }




}
