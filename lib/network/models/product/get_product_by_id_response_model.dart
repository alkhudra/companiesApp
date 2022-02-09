

import 'package:khudrah_companies/network/models/product/product_model.dart';

class ProductListResponseModel {
  ProductsModel? _products ;
  String? message;

  ProductsModel? get products =>
      _products; //BranchListResponseModel(this._branches, this.message);

  ProductListResponseModel.fromJson(dynamic json) {
    //  message = json['message'];

    if (_products != null && json['message'] == null)  {


        _products = ProductsModel.fromJson(json);

    }else{
      message = json['message'];
    }
  }

  @override
  String toString() {
    String model = _products.toString();
    return 'BranchListResponseModel{branchList: $model}';
  }

  ProductListResponseModel();
}
