
import 'package:khudrah_companies/network/models/product/product_model.dart';

class ProductListResponseModel {
  List<ProductsModel> _products = [];
  String? message;

  List<ProductsModel> get products =>
      _products; //BranchListResponseModel(this._branches, this.message);

  ProductListResponseModel.fromJson(dynamic json) {
    //  message = json['message'];

    if (json != null) {
      _products = [];
      json.forEach((v) {
        _products.add(ProductsModel.fromJson(v));
      });
    }
  }

  @override
  String toString() {
    String model = _products.toString();
    return 'BranchListResponseModel{branchList: $model}';
  }

  ProductListResponseModel();

}
