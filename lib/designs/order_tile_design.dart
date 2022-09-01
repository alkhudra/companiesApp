import 'package:flutter/material.dart';
import 'package:khudrah_companies/Constant/conts.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/helpers/pref/shared_pref_helper.dart';
import 'package:khudrah_companies/network/API/api_response.dart';
import 'package:khudrah_companies/network/API/api_response_type.dart';
import 'package:khudrah_companies/network/helper/network_helper.dart';
import 'package:khudrah_companies/network/models/orders/order_header.dart';
import 'package:khudrah_companies/network/repository/order_repository.dart';
import 'package:khudrah_companies/pages/orders/order_list.dart';

import '../pages/orders/order_details.dart';
import '../resources/custom_colors.dart';
import 'package:easy_localization/easy_localization.dart';

Widget orderTileDesign(context, OrderHeader model) {
  String orderStatus = '';
  String orderDate = '';
  Size size = MediaQuery.of(context).size;
  double scWidth = size.width;
  double scHeight = size.height;
  Color statusColor;
  if (model.orderStatus == underProcess) {
    orderDate = model.orderInitializedDate!;
    orderStatus = LocaleKeys.under_process.tr();
    statusColor = CustomColors().brownColor;
  } else if (model.orderStatus == onDelivery) {
    orderDate = model.onDeliveryStatusDate!;
    orderStatus = LocaleKeys.on_delivery.tr();
    statusColor = CustomColors().darkBlueColor;
  } else {
    orderDate = model.deliveredStatusDate!;
    orderStatus = LocaleKeys.completed_order.tr();
    statusColor = CustomColors().primaryGreenColor;
  }

  return ListTile(
    title: Center(
      child: GestureDetector(
        onTap: () {
          // navigate to order status page
          directToOrderDetails(context, model: model);
        },
        child: Stack(
          children: [
            Positioned(
                left: 0,
                top: 2,
                child: Container(
                  width: 6,
                  height: scHeight * 0.12,
                  color: statusColor,
                )),
            //background container
            Container(
              margin: EdgeInsets.symmetric(vertical: 2),
              alignment: Alignment.center,
              width: scWidth * 1.2,
              height: scHeight * 0.12,
              // scHeight*0.12
              decoration: BoxDecoration(
                border: Border.all(color: statusColor),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
                // gradient: LinearGradient(
                //   colors: [
                //     CustomColors().primaryGreenColor.withGreen(150),
                //     CustomColors().lightGreen.withOpacity(0.8),
                //   ]
                // ),
              ),
              child: Container(
                alignment: Alignment.bottomLeft,
                child: Image.asset('images/ic_fruit_green.png'),
              ),
            ),
            //details container
            Container(
              alignment: Alignment.center,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      //Order ID
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 17),
                        alignment: Alignment.center,
                        child: Text(
                          '#' + model.invoiceNumber.toString(),
                          style: TextStyle(
                            color: CustomColors().primaryGreenColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      //Order Date
                      Container(
                        child: Text(
                          orderDate,
                          style: TextStyle(
                            color: CustomColors().primaryGreenColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  //Order quantity
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: scWidth * 0.145),
                    child: Text(
                      orderStatus,
                      style: TextStyle(
                        color: statusColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 19,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

void directToOrderDetails(context, {model, orderId}) async {

  if (orderId != null && orderId!= 0 ) {
    Map<String, dynamic> headerMap = await getHeaderMap();

    OrderRepository orderRepository = OrderRepository(headerMap);

    ApiResponse apiResponse = await orderRepository.getOrderById(orderId);

    if (apiResponse.apiStatus.code == ApiResponseType.OK.code) {
      OrderHeader? responseModel = OrderHeader.fromJson(apiResponse.result);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OrderDetails(
                    orderModel: responseModel,
                  )));
    }
  } else if (model != null)
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => OrderDetails(
                  orderModel: model,
                )));
}

titleTextDesign(text) {
  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          text,
          style: TextStyle(
              color: CustomColors().brownColor,
              fontWeight: FontWeight.w800,
              fontSize: 19),
        ),
      ),
    ],
  );
}
