import 'package:khudrah_companies/network/models/orders/driver_user.dart';
import 'package:khudrah_companies/network/models/orders/order_header.dart';
import 'package:khudrah_companies/network/models/orders/order_items.dart';


class GetOrdersResponseModel {


  List<OrderHeader> _orderList = [];
  String? message;

  List<OrderHeader> get orderList =>
      _orderList; //BranchListResponseModel(this._branches, this.message);

  GetOrdersResponseModel.fromJson(dynamic json) {
//  message = json['message'];

    if (json != null) {
      _orderList = [];
      json.forEach((v) {
        _orderList.add(OrderHeader.fromJson(v));
      });
    }
  }


  @override
  String toString() {
    return 'GetOrdersResponseModel{_orderList: $_orderList}';
  }

}

