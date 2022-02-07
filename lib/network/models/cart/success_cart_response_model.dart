import 'package:khudrah_companies/network/models/cart/user_cart.dart';
import 'package:khudrah_companies/network/models/product/product_model.dart';


class SuccessCartResponseModel {
  SuccessCartResponseModel({
      String? message, 
      UserCart? userCart,}){
    _message = message;
    _userCart = userCart;
}

  SuccessCartResponseModel.fromJson(dynamic json) {
    _message = json['message'];
    _userCart = json['userCart'] != null ? UserCart.fromJson(json['userCart']) : null;
  }
  String? _message;
  UserCart? _userCart;

  String? get message => _message;
  UserCart? get userCart => _userCart;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    if (_userCart != null) {
      map['userCart'] = _userCart?.toJson();
    }
    return map;
  }

}

//-------------------

class CartProductsList {
  CartProductsList({
      ProductsModel? productDto,
      int? totalProductPrice, 
      int? userProductQuantity,}){
    _productDto = productDto;
    _totalProductPrice = totalProductPrice;
    _userProductQuantity = userProductQuantity;
}

  CartProductsList.fromJson(dynamic json) {
    _productDto = json['productDto'] != null ? ProductsModel.fromJson(json['productDto']) : null;
    _totalProductPrice = json['totalProductPrice'];
    _userProductQuantity = json['userProductQuantity'];
  }
  ProductsModel? _productDto;
  int? _totalProductPrice;
  int? _userProductQuantity;

  ProductsModel? get productDto => _productDto;
  int? get totalProductPrice => _totalProductPrice;
  int? get userProductQuantity => _userProductQuantity;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_productDto != null) {
      map['productDto'] = _productDto?.toJson();
    }
    map['totalProductPrice'] = _totalProductPrice;
    map['userProductQuantity'] = _userProductQuantity;
    return map;
  }

}
