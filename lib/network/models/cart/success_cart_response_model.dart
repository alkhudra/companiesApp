import 'package:khudrah_companies/network/models/cart/user_cart.dart';
import 'package:khudrah_companies/network/models/product/product_model.dart';

class SuccessCartResponseModel {
  SuccessCartResponseModel({
    String? message,
    UserCart? userCart,
  }) {
    _message = message;
    _userCart = userCart;
  }

  SuccessCartResponseModel.fromJson(dynamic json) {
    _message = json['message'];
    _userCart =
        json['userCart'] != null ? UserCart.fromJson(json['userCart']) : null;
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

  @override
  String toString() {
    return 'SuccessCartResponseModel{_message: $_message, _userCart: $_userCart}';
  }
}

//-------------------
/*
"totalNetProductPrice": 177.39,
"totalProductVAT15": 26.61,


"hasOriginalProductPriceChanged": true,
*/

class CartProductsList {
  CartProductsList({
    ProductsModel? productDto,
    num? totalProductPrice,
    num? userProductQuantity,
    num? totalProductVAT15,
    bool? hasUserProductQuantityChanged,
    bool? hasSpecialProductPriceChanged,
    bool? hasOriginalProductPriceChanged,
    num? totalNetProductPrice,
  }) {
    _productDto = productDto;
    _hasUserProductQuantityChanged = hasUserProductQuantityChanged;
    _totalProductVAT15 = totalProductVAT15;
    _totalProductPrice = totalProductPrice;
    _hasOriginalProductPriceChanged = hasOriginalProductPriceChanged;
    _hasSpecialProductPriceChanged = hasSpecialProductPriceChanged;
    _totalNetProductPrice = totalNetProductPrice;
    _userProductQuantity = userProductQuantity;
  }

  CartProductsList.fromJson(dynamic json) {
    _productDto = json['productDto'] != null
        ? ProductsModel.fromJson(json['productDto'])
        : null;
    _totalProductPrice = json['totalProductPrice'];
    _userProductQuantity = json['userProductQuantity'];
    _totalNetProductPrice = json['totalNetProductPrice'];
    _totalProductVAT15 = json['totalProductVAT15'];
    _hasOriginalProductPriceChanged = json['hasOriginalProductPriceChanged'];
    _hasSpecialProductPriceChanged = json['hasSpecialProductPriceChanged'];
    _hasUserProductQuantityChanged = json['hasUserProductQuantityChanged'];
  }
  ProductsModel? _productDto;
  num? _totalProductPrice;
  num? _userProductQuantity;
  num? _totalNetProductPrice;
  num? _totalProductVAT15;
  bool? _hasUserProductQuantityChanged;
  bool? _hasOriginalProductPriceChanged;
  bool? _hasSpecialProductPriceChanged;
  ProductsModel? get productDto => _productDto;
  num? get totalProductPrice => _totalProductPrice;
  num? get userProductQuantity => _userProductQuantity;
  num? get totalProductVAT15 => _totalProductVAT15;
  bool? get hasUserProductQuantityChanged => _hasUserProductQuantityChanged;
  bool? get hasOriginalProductPriceChanged => _hasOriginalProductPriceChanged;
  bool? get hasSpecialProductPriceChanged => _hasSpecialProductPriceChanged;
  num? get totalNetProductPrice => _totalNetProductPrice;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_productDto != null) {
      map['productDto'] = _productDto?.toJson();
    }
    map['hasUserProductQuantityChanged'] = _hasUserProductQuantityChanged;
    map['totalProductVAT15'] = _totalProductVAT15;
    map['hasOriginalProductPriceChanged'] = _hasOriginalProductPriceChanged;

    map['hasSpecialProductPriceChanged'] = _hasSpecialProductPriceChanged;
    map['totalProductPrice'] = _totalProductPrice;
    map['userProductQuantity'] = _userProductQuantity;
    map['totalNetProductPrice'] = _totalNetProductPrice;
    return map;
  }

  @override
  String toString() {
    return 'CartProductsList{_productDto: $_productDto, _totalProductPrice: $_totalProductPrice, _userProductQuantity: $_userProductQuantity, _totalNetProductPrice: $_totalNetProductPrice, _totalProductVAT15: $_totalProductVAT15, _hasUserProductQuantityChanged: $_hasUserProductQuantityChanged, _hasOriginalProductPriceChanged: $_hasOriginalProductPriceChanged, _hasSpecialProductPriceChanged: $_hasSpecialProductPriceChanged}';
  }
}
