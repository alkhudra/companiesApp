import 'package:khudrah_companies/network/models/branches/branch_model.dart';
import 'package:khudrah_companies/network/models/product/category_model.dart';
import 'package:khudrah_companies/network/models/user_model.dart';
import 'package:khudrah_companies/network/models/product/product_model.dart';

class HomeSuccessResponseModel {
  HomeSuccessResponseModel({
    User? user,
    List<CategoryItem>? categoriesList,
    List<ProductsModel>? productsList,
    List<BranchModel>? branchList,

  }) {
    _user = user;
    _branchList=branchList;
    _categoriesList = categoriesList;
    _productsList = productsList;
  }

  HomeSuccessResponseModel.fromJson(dynamic json) {
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    if (json['categoriesList'] != null) {
      _categoriesList = [];
      json['categoriesList'].forEach((v) {
        _categoriesList?.add(CategoryItem.fromJson(v));
      });
    }
    if (json['productsList'] != null) {
      _productsList = [];
      json['productsList'].forEach((v) {
        _productsList?.add(ProductsModel.fromJson(v));
      });
    }
    if (json['branches'] != null) {
      _branchList = [];
      json['branches'].forEach((v) {
        _branchList?.add(BranchModel.fromJson(v));
      });
    }

  }
  User? _user;
  List<CategoryItem>? _categoriesList;
  List<ProductsModel>? _productsList;
  List<BranchModel>? _branchList;

  List<BranchModel>? get branchList => _branchList;
  User? get user => _user;
  List<CategoryItem>? get categoriesList => _categoriesList;
  List<ProductsModel>? get productsList => _productsList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    if (_categoriesList != null) {
      map['categoriesList'] = _categoriesList?.map((v) => v.toJson()).toList();
    }
    if (_productsList != null) {
      map['productsList'] = _productsList?.map((v) => v.toJson()).toList();
    }
    if (_branchList != null) {
      map['branches'] = _branchList?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}



/// id : "dsjah894"
/// name : "Fruit"
/// arName : "فواكه"
/// isActive : true
/// image : "/categoryImages/44ab9c9e-dac4-468b-b708-f6571d793b96.jpg"


