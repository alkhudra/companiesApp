import 'order_items.dart';

/// companyId : "string"
/// branchId : "string"
/// paymentType : "string"
/// hasPaid : true
/// totalOrderPrice : 0
/// totalNetOrderPrice : 0
/// totalOrderVAT15 : 0
/// hasDiscount : true
/// discountPercentage : 0
/// totalDiscount : 0
/// orderItems : [{"productId":"string","orderedProductPrice":0,"userProductQuantity":0,"totalProductPrice":0,"totalNetProductPrice":0,"totalProductVAT15":0}]

class SendOrderModel {
  SendOrderModel({
      String? companyId, 
      String? branchId, 
      String? paymentType, 
      bool? hasPaid, 
      num? totalOrderPrice, 
      num? totalNetOrderPrice, 
      num? totalOrderVAT15, 
      bool? hasDiscount, 
      num? discountPercentage, 
      num? totalDiscount, 
      List<OrderItems>? orderItems,}){
    _companyId = companyId;
    _branchId = branchId;
    _paymentType = paymentType;
    _hasPaid = hasPaid;
    _totalOrderPrice = totalOrderPrice;
    _totalNetOrderPrice = totalNetOrderPrice;
    _totalOrderVAT15 = totalOrderVAT15;
    _hasDiscount = hasDiscount;
    _discountPercentage = discountPercentage;
    _totalDiscount = totalDiscount;
    _orderItems = orderItems;
}

  SendOrderModel.fromJson(dynamic json) {
    _companyId = json['companyId'];
    _branchId = json['branchId'];
    _paymentType = json['paymentType'];
    _hasPaid = json['hasPaid'];
    _totalOrderPrice = json['totalOrderPrice'];
    _totalNetOrderPrice = json['totalNetOrderPrice'];
    _totalOrderVAT15 = json['totalOrderVAT15'];
    _hasDiscount = json['hasDiscount'];
    _discountPercentage = json['discountPercentage'];
    _totalDiscount = json['totalDiscount'];
    if (json['orderItems'] != null) {
      _orderItems = [];
      json['orderItems'].forEach((v) {
        _orderItems?.add(OrderItems.fromJson(v));
      });
    }
  }
  String? _companyId;
  String? _branchId;
  String? _paymentType;
  bool? _hasPaid;
  num? _totalOrderPrice;
  num? _totalNetOrderPrice;
  num? _totalOrderVAT15;
  bool? _hasDiscount;
  num? _discountPercentage;
  num? _totalDiscount;
  List<OrderItems>? _orderItems;

  String? get companyId => _companyId;
  String? get branchId => _branchId;
  String? get paymentType => _paymentType;
  bool? get hasPaid => _hasPaid;
  num? get totalOrderPrice => _totalOrderPrice;
  num? get totalNetOrderPrice => _totalNetOrderPrice;
  num? get totalOrderVAT15 => _totalOrderVAT15;
  bool? get hasDiscount => _hasDiscount;
  num? get discountPercentage => _discountPercentage;
  num? get totalDiscount => _totalDiscount;
  List<OrderItems>? get orderItems => _orderItems;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['companyId'] = _companyId;
    map['branchId'] = _branchId;
    map['paymentType'] = _paymentType;
    map['hasPaid'] = _hasPaid;
    map['totalOrderPrice'] = _totalOrderPrice;
    map['totalNetOrderPrice'] = _totalNetOrderPrice;
    map['totalOrderVAT15'] = _totalOrderVAT15;
    map['hasDiscount'] = _hasDiscount;
    map['discountPercentage'] = _discountPercentage;
    map['totalDiscount'] = _totalDiscount;
    if (_orderItems != null) {
      map['orderItems'] = _orderItems?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

