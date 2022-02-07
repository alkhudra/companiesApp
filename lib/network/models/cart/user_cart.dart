import 'package:khudrah_companies/network/models/cart/success_cart_response_model.dart';

class UserCart {
  UserCart({
    List<CartProductsList>? cartProductsList,
    int? totalCartPrice,
    bool? hasDiscount,
    double? priceAfterDiscount,}){
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
  int? _totalCartPrice;
  bool? _hasDiscount;
  double? _priceAfterDiscount;

  List<CartProductsList>? get cartProductsList => _cartProductsList;
  int? get totalCartPrice => _totalCartPrice;
  bool? get hasDiscount => _hasDiscount;
  double? get priceAfterDiscount => _priceAfterDiscount;

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