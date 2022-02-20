import 'package:khudrah_companies/network/models/cart/success_cart_response_model.dart';

class UserCart {
  UserCart({
    List<CartProductsList>? cartProductsList,
    num? totalCartPrice,
    bool? hasDiscount,
    num? discountPercentage,
    num? totalCartVAT15,
    num? totalNetCartPrice,
    num? priceAfterDiscount,
  }) {
    _totalCartVAT15 = totalCartVAT15;
    _cartProductsList = cartProductsList;
    _totalCartPrice = totalCartPrice;
    _hasDiscount = hasDiscount;
    _totalNetCartPrice = totalNetCartPrice;
    _discountPercentage = discountPercentage;
    _priceAfterDiscount = priceAfterDiscount;
  }

  UserCart.fromJson(dynamic json) {
    if (json['cartProductsList'] != null) {
      _cartProductsList = [];
      json['cartProductsList'].forEach((v) {
        _cartProductsList?.add(CartProductsList.fromJson(v));
      });
    }
    _discountPercentage = json['discountPercentage'];
    _totalNetCartPrice = json['totalNetCartPrice'];
    _totalCartVAT15 = json['totalCartVAT15'];

    _totalCartPrice = json['totalCartPrice'];
    _hasDiscount = json['hasDiscount'];
    _priceAfterDiscount = json['priceAfterDiscount'];
  }
  List<CartProductsList>? _cartProductsList;
  num? _totalCartPrice;
  bool? _hasDiscount;
  num? _priceAfterDiscount;
  num? _discountPercentage;
  num? _totalCartVAT15;
  num? _totalNetCartPrice;

  List<CartProductsList>? get cartProductsList => _cartProductsList;
  num? get totalCartPrice => _totalCartPrice;
  bool? get hasDiscount => _hasDiscount;
  num? get priceAfterDiscount => _priceAfterDiscount;
  num? get totalCartVAT15 => _totalCartVAT15;
  num? get totalNetCartPrice => _totalNetCartPrice;
  num? get discountPercentage => _discountPercentage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_cartProductsList != null) {
      map['cartProductsList'] =
          _cartProductsList?.map((v) => v.toJson()).toList();
    }
    map['totalNetCartPrice'] = _totalNetCartPrice;
    map['totalCartVAT15'] = _totalCartVAT15;
    map['discountPercentage'] = _discountPercentage;

    map['totalCartPrice'] = _totalCartPrice;
    map['hasDiscount'] = _hasDiscount;
    map['priceAfterDiscount'] = _priceAfterDiscount;
    return map;
  }

  @override
  String toString() {
    return 'UserCart{_cartProductsList: $_cartProductsList, _totalCartPrice: $_totalCartPrice, _hasDiscount: $_hasDiscount, _priceAfterDiscount: $_priceAfterDiscount, _discountPercentage: $_discountPercentage, _totalCartVAT15: $_totalCartVAT15, _totalNetCartPrice: $_totalNetCartPrice}';
  }
}
