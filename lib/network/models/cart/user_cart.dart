import 'package:khudrah_companies/network/models/cart/success_cart_response_model.dart';

class UserCart {
  UserCart({
    List<CartProductsList>? cartProductsList,
    num? totalCartPrice,
    bool? hasDiscount,
    num? priceAfterDiscount,}){
    _cartProductsList = cartProductsList;
    _totalCartPrice = totalCartPrice;
    _hasDiscount = hasDiscount;
    _priceAfterDiscount = priceAfterDiscount;
  }

  UserCart.fromJson(dynamic json) {
    if (json['cartProductsList'] != null) {
      _cartProductsList = [];
      json['cartProductsList'].forEach((v) {
        _cartProductsList?.add(CartProductsList.fromJson(v));
      });
    }
    _totalCartPrice = json['totalCartPrice'];
    _hasDiscount = json['hasDiscount'];
    _priceAfterDiscount = json['priceAfterDiscount'];
  }
  List<CartProductsList>? _cartProductsList;
  num? _totalCartPrice;
  bool? _hasDiscount;
  num? _priceAfterDiscount;

  List<CartProductsList>? get cartProductsList => _cartProductsList;
  num? get totalCartPrice => _totalCartPrice;
  bool? get hasDiscount => _hasDiscount;
  num? get priceAfterDiscount => _priceAfterDiscount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_cartProductsList != null) {
      map['cartProductsList'] = _cartProductsList?.map((v) => v.toJson()).toList();
    }
    map['totalCartPrice'] = _totalCartPrice;
    map['hasDiscount'] = _hasDiscount;
    map['priceAfterDiscount'] = _priceAfterDiscount;
    return map;
  }

}