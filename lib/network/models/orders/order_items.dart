import 'package:khudrah_companies/network/models/product/product_model.dart';

class OrderItems {
  OrderItems({
    String? id,
    ProductsModel? product,
    String? userId,
    num? orderedProductPrice,
    num? orderedNetProductPrice,
    num? userProductQuantity,
    num? totalProductPrice,
    num? totalNetProductPrice,
    num? totalProductVAT15,
    num? orderHeaderId,}){
    _id = id;
    _product = product;
    _userId = userId;
    _orderedProductPrice = orderedProductPrice;
    _orderedNetProductPrice = orderedNetProductPrice;
    _userProductQuantity = userProductQuantity;
    _totalProductPrice = totalProductPrice;
    _totalNetProductPrice = totalNetProductPrice;
    _totalProductVAT15 = totalProductVAT15;
    _orderHeaderId = orderHeaderId;
  }

  OrderItems.fromJson(dynamic json) {
    _id = json['id'];
    _product = json['product'] != null ? ProductsModel.fromJson(json['product']) : null;
    _userId = json['userId'];
    _orderedProductPrice = json['orderedProductPrice'];
    _orderedNetProductPrice = json['orderedNetProductPrice'];
    _userProductQuantity = json['userProductQuantity'];
    _totalProductPrice = json['totalProductPrice'];
    _totalNetProductPrice = json['totalNetProductPrice'];
    _totalProductVAT15 = json['totalProductVAT15'];
    _orderHeaderId = json['orderHeaderId'];
  }
  String? _id;
  ProductsModel? _product;
  String? _userId;
  num? _orderedProductPrice;
  num? _orderedNetProductPrice;
  num? _userProductQuantity;
  num? _totalProductPrice;
  num? _totalNetProductPrice;
  num? _totalProductVAT15;
  num? _orderHeaderId;

  String? get id => _id;
  ProductsModel? get product => _product;
  String? get userId => _userId;
  num? get orderedProductPrice => _orderedProductPrice;
  num? get orderedNetProductPrice => _orderedNetProductPrice;
  num? get userProductQuantity => _userProductQuantity;
  num? get totalProductPrice => _totalProductPrice;
  num? get totalNetProductPrice => _totalNetProductPrice;
  num? get totalProductVAT15 => _totalProductVAT15;
  num? get orderHeaderId => _orderHeaderId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    if (_product != null) {
      map['product'] = _product?.toJson();
    }
    map['userId'] = _userId;
    map['orderedProductPrice'] = _orderedProductPrice;
    map['orderedNetProductPrice'] = _orderedNetProductPrice;
    map['userProductQuantity'] = _userProductQuantity;
    map['totalProductPrice'] = _totalProductPrice;
    map['totalNetProductPrice'] = _totalNetProductPrice;
    map['totalProductVAT15'] = _totalProductVAT15;
    map['orderHeaderId'] = _orderHeaderId;
    return map;
  }

}

class SubmitOrderItems {
  SubmitOrderItems({
    String? productId,
    num? orderedProductPrice,
    num? userProductQuantity,
    num? totalProductPrice,
    num? totalNetProductPrice,
    num? totalProductVAT15,
  }) {
    _orderedProductPrice = orderedProductPrice;
    _productId = productId;
    _userProductQuantity = userProductQuantity;
    _totalProductPrice = totalProductPrice;
    _totalNetProductPrice = totalNetProductPrice;
    _totalProductVAT15 = totalProductVAT15;
  }

  SubmitOrderItems.fromJson(dynamic json) {
    _productId = json['productId'];
    _orderedProductPrice = json['orderedProductPrice'];
    _userProductQuantity = json['userProductQuantity'];
    _totalProductPrice = json['totalProductPrice'];
    _totalNetProductPrice = json['totalNetProductPrice'];
    _totalProductVAT15 = json['totalProductVAT15'];
  }
  String? _productId;

  num? _userProductQuantity;
  num? _totalProductPrice;
  num? _totalNetProductPrice;
  num? _totalProductVAT15;
  num? _orderedProductPrice;

  String? get productId => _productId;
  num? get orderedProductPrice => _orderedProductPrice;
  num? get userProductQuantity => _userProductQuantity;
  num? get totalProductPrice => _totalProductPrice;
  num? get totalNetProductPrice => _totalNetProductPrice;
  num? get totalProductVAT15 => _totalProductVAT15;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['productId'] = _productId;
    map['orderedProductPrice'] = _orderedProductPrice;
    map['userProductQuantity'] = _userProductQuantity;
    map['totalProductPrice'] = _totalProductPrice;
    map['totalNetProductPrice'] = _totalNetProductPrice;
    map['totalProductVAT15'] = _totalProductVAT15;
    return map;
  }

  @override
  String toString() {
    return 'SubmitOrderItems{_productId: $_productId, _userProductQuantity: $_userProductQuantity, _totalProductPrice: $_totalProductPrice, _totalNetProductPrice: $_totalNetProductPrice, _totalProductVAT15: $_totalProductVAT15, _orderedProductPrice: $_orderedProductPrice}';
  }
}
