import 'dart:collection';

import 'package:collection/src/iterable_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:khudrah_companies/network/models/branches/branch_list_response_model.dart';
import 'package:khudrah_companies/network/models/branches/branch_model.dart';
import 'package:khudrah_companies/network/models/product/product_model.dart';

class FavoriteProvider with ChangeNotifier {
  List<ProductsModel>? favList = [];
  List<Cities>? citiesList = [];

  BuildContext context;

  FavoriteProvider(this.context);


  setfavList(List<ProductsModel>? list){
    favList = list;
    notifyListeners();
  }
  setCitiesList( List<Cities>?  list){
    citiesList = list;
    notifyListeners();
  }
  addBranchToList(ProductsModel model) {
    favList!.insert(0,model);
    notifyListeners();
  }

  removeBranchFromList(ProductsModel model) {
    final id = model.productId;
    ProductsModel? productsModel =
    favList!.firstWhereOrNull((element) {
      return element.productId == id;
    });
    if (productsModel != null) {
      favList!.remove(productsModel);
      notifyListeners();
    }

  }

  addPagingListToList(List<ProductsModel> pagingList) {
    favList!.insertAll(favList!.indexOf(favList!.last),pagingList);
    notifyListeners();
  }

  int get listCount {
    return favList!.length;
  }

  UnmodifiableListView<ProductsModel> get getfavList {
    //  if(favList!.length !=0)
    return UnmodifiableListView(favList!);
    // else return loadData();

  }
  UnmodifiableListView<Cities> get getCitiesList {
    return UnmodifiableListView(citiesList!);

  }
}
