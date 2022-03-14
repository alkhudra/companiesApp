import 'order_header.dart';
import 'order_items.dart';

/// message : "The order has been added successfully"
/// orderHeaderDto : {"id":257,"companyId":"d2fa0b28-905e-4477-bcaa-159eacbdb71b","branchId":"9303167f-c884-4089-a021-1b5d9b8de030","warehouseCode":null,"orderStatus":"under_process","orderCheckCode":null,"invoiceNumber":1257,"orderInitializedDate":"2022-03-14","onDeliveryStatusDate":null,"deliveredStatusDate":null,"driverId":null,"driverUser":null,"paymentType":"C","hasPaid":false,"paymentDeadLine":"2022-06-12","totalOrderPrice":0,"totalNetOrderPrice":0,"totalOrderVAT15":0,"hasDiscount":false,"discountPercentage":0,"totalDiscount":0,"orderItems":[{"id":"df046f3d-df6f-4f1f-816c-d46971fcce57","productId":"1","userId":"d2fa0b28-905e-4477-bcaa-159eacbdb71b","orderedProductPrice":0,"orderedNetProductPrice":0,"userProductQuantity":0,"totalProductPrice":0,"totalNetProductPrice":0,"totalProductVAT15":0,"orderHeaderId":257}]}
/// invoicePDFPath : "http://alkhudrahproject-001-site2.ctempurl.com/PdfFiles/ac3d99c7-2be8-412f-9fdd-a6ec3f84e438.pdf"
/// companyBalance : 10000
/// status : false
/// htmlpath : "http://alkhudrahproject-001-site2.ctempurl.com/HTMLFiles/88ac4072-d467-4cd0-8ee1-e4fb9c6e70b3.html"

class SubmitOrderSuccessResponseModel {
  SubmitOrderSuccessResponseModel({
      String? message, 
      OrderHeader? orderHeaderDto,
      String? invoicePDFPath, 
      num? companyBalance, 
      bool? status, 
      String? htmlpath,}){
    _message = message;
    _orderHeaderDto = orderHeaderDto;
    _invoicePDFPath = invoicePDFPath;
    _companyBalance = companyBalance;
    _status = status;
    _htmlpath = htmlpath;
}

  SubmitOrderSuccessResponseModel.fromJson(dynamic json) {
    _message = json['message'];
    _orderHeaderDto = json['orderHeaderDto'] != null ? OrderHeader.fromJson(json['orderHeaderDto']) : null;
    _invoicePDFPath = json['invoicePDFPath'];
    _companyBalance = json['companyBalance'];
    _status = json['status'];
    _htmlpath = json['htmlpath'];
  }
  String? _message;
  OrderHeader? _orderHeaderDto;
  String? _invoicePDFPath;
  num? _companyBalance;
  bool? _status;
  String? _htmlpath;

  String? get message => _message;
  OrderHeader? get orderHeader => _orderHeaderDto;
  String? get invoicePDFPath => _invoicePDFPath;
  num? get companyBalance => _companyBalance;
  bool? get status => _status;
  String? get htmlpath => _htmlpath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    if (_orderHeaderDto != null) {
      map['orderHeaderDto'] = _orderHeaderDto?.toJson();
    }
    map['invoicePDFPath'] = _invoicePDFPath;
    map['companyBalance'] = _companyBalance;
    map['status'] = _status;
    map['htmlpath'] = _htmlpath;
    return map;
  }

  @override
  String toString() {
    return 'SubmitOrderSuccessResponseModel{_message: $_message, _orderHeaderDto: $_orderHeaderDto, _invoicePDFPath: $_invoicePDFPath, _companyBalance: $_companyBalance, _status: $_status, _htmlpath: $_htmlpath}';
  }
}


