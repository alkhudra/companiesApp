
import 'package:khudrah_companies/network/models/orders/driver_user.dart';
import 'package:khudrah_companies/network/models/orders/order_items.dart';

class OrderHeader {
  OrderHeader({
      num? id,
      String? companyId, 
      String? branchId, 
      String? warehouseCode, 
      String? orderStatus, 
      String? orderCheckCode, 
      num? invoiceNumber, 
      String? orderInitializedDate, 
      String? onDeliveryStatusDate, 
      String? deliveredStatusDate, 
      String? driverId, 
      DriverUser? driverUser, 
      String? paymentType, 
      bool? hasPaid, 
      String? paymentDeadLine, 
      num? totalOrderPrice, 
      num? totalNetOrderPrice, 
      num? totalOrderVAT15, 
      bool? hasDiscount, 
      num? discountPercentage, 
      num? totalDiscount, 
      String? invoicePDFPath, 
      bool? hasOrderCreatedFromDashboard,
      List<OrderItems>? orderItems,}){
    _id = id;
    _companyId = companyId;
    _branchId = branchId;
    _warehouseCode = warehouseCode;
    _orderStatus = orderStatus;
    _orderCheckCode = orderCheckCode;
    _invoiceNumber = invoiceNumber;
    _orderInitializedDate = orderInitializedDate;
    _onDeliveryStatusDate = onDeliveryStatusDate;
    _deliveredStatusDate = deliveredStatusDate;
    _driverId = driverId;
    _driverUser = driverUser;
    _paymentType = paymentType;
    _hasPaid = hasPaid;
    _paymentDeadLine = paymentDeadLine;
    _totalOrderPrice = totalOrderPrice;
    _totalNetOrderPrice = totalNetOrderPrice;
    _totalOrderVAT15 = totalOrderVAT15;
    _hasDiscount = hasDiscount;
    _discountPercentage = discountPercentage;
    _totalDiscount = totalDiscount;
    _invoicePDFPath = invoicePDFPath;
    _hasOrderCreatedFromDashboard = hasOrderCreatedFromDashboard;
    _orderItems = orderItems;
}

  OrderHeader.fromJson(dynamic json) {
    _id = json['id'];
    _companyId = json['companyId'];
    _branchId = json['branchId'];
    _warehouseCode = json['warehouseCode'];
    _orderStatus = json['orderStatus'];
    _orderCheckCode = json['orderCheckCode'];
    _invoiceNumber = json['invoiceNumber'];
    _orderInitializedDate = json['orderInitializedDate'];
    _onDeliveryStatusDate = json['onDeliveryStatusDate'];
    _deliveredStatusDate = json['deliveredStatusDate'];
    _driverId = json['driverId'];
    _driverUser = json['driverUser'] != null ? DriverUser.fromJson(json['driverUser']) : null;
    _paymentType = json['paymentType'];
    _hasPaid = json['hasPaid'];
    _paymentDeadLine = json['paymentDeadLine'];
    _totalOrderPrice = json['totalOrderPrice'];
    _totalNetOrderPrice = json['totalNetOrderPrice'];
    _totalOrderVAT15 = json['totalOrderVAT15'];
    _hasDiscount = json['hasDiscount'];
    _discountPercentage = json['discountPercentage'];
    _totalDiscount = json['totalDiscount'];
    _invoicePDFPath = json['invoicePDFPath'];
    _hasOrderCreatedFromDashboard = json['orderCreatedFromDashboard'];
    if (json['orderItems'] != null) {
      _orderItems = [];
      json['orderItems'].forEach((v) {
        _orderItems?.add(OrderItems.fromJson(v));
      });
    }
  }
  num? _id;
  String? _companyId;
  String? _branchId;
  String? _warehouseCode;
  String? _orderStatus;
  String? _orderCheckCode;
  num? _invoiceNumber;
  String? _orderInitializedDate;
  String? _onDeliveryStatusDate;
  String? _deliveredStatusDate;
  String? _driverId;
  DriverUser? _driverUser;
  String? _paymentType;
  bool? _hasPaid;
  String? _paymentDeadLine;
  num? _totalOrderPrice;
  num? _totalNetOrderPrice;
  num? _totalOrderVAT15;
  bool? _hasDiscount;
  num? _discountPercentage;
  num? _totalDiscount;
  String? _invoicePDFPath;
  bool? _hasOrderCreatedFromDashboard;
  List<OrderItems>? _orderItems;

  num? get id => _id;
  String? get companyId => _companyId;
  String? get branchId => _branchId;
  String? get warehouseCode => _warehouseCode;
  String? get orderStatus => _orderStatus;
  String? get orderCheckCode => _orderCheckCode;
  num? get invoiceNumber => _invoiceNumber;
  String? get orderInitializedDate => _orderInitializedDate;
  String? get onDeliveryStatusDate => _onDeliveryStatusDate;
  String? get deliveredStatusDate => _deliveredStatusDate;
  String? get driverId => _driverId;
  DriverUser? get driverUser => _driverUser;
  String? get paymentType => _paymentType;
  bool? get hasPaid => _hasPaid;
  String? get paymentDeadLine => _paymentDeadLine;
  num? get totalOrderPrice => _totalOrderPrice;
  num? get totalNetOrderPrice => _totalNetOrderPrice;
  num? get totalOrderVAT15 => _totalOrderVAT15;
  bool? get hasDiscount => _hasDiscount;
  num? get discountPercentage => _discountPercentage;
  num? get totalDiscount => _totalDiscount;
  String? get invoicePDFPath => _invoicePDFPath;
  bool? get hasOrderCreatedFromDashboard => _hasOrderCreatedFromDashboard;
  List<OrderItems>? get orderItems => _orderItems;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['companyId'] = _companyId;
    map['branchId'] = _branchId;
    map['warehouseCode'] = _warehouseCode;
    map['orderStatus'] = _orderStatus;
    map['orderCheckCode'] = _orderCheckCode;
    map['invoiceNumber'] = _invoiceNumber;
    map['orderInitializedDate'] = _orderInitializedDate;
    map['onDeliveryStatusDate'] = _onDeliveryStatusDate;
    map['deliveredStatusDate'] = _deliveredStatusDate;
    map['driverId'] = _driverId;
    if (_driverUser != null) {
      map['driverUser'] = _driverUser?.toJson();
    }
    map['paymentType'] = _paymentType;
    map['hasPaid'] = _hasPaid;
    map['paymentDeadLine'] = _paymentDeadLine;
    map['totalOrderPrice'] = _totalOrderPrice;
    map['totalNetOrderPrice'] = _totalNetOrderPrice;
    map['totalOrderVAT15'] = _totalOrderVAT15;
    map['hasDiscount'] = _hasDiscount;
    map['discountPercentage'] = _discountPercentage;
    map['totalDiscount'] = _totalDiscount;
    map['invoicePDFPath'] = _invoicePDFPath;
    map['orderCreatedFromDashboard'] = _hasOrderCreatedFromDashboard;
    if (_orderItems != null) {
      map['orderItems'] = _orderItems?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  @override
  String toString() {
    return 'OrderHeader{_id: $_id}';
  }
}



