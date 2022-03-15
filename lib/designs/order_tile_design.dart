import 'package:flutter/material.dart';
import 'package:khudrah_companies/Constant/conts.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/helpers/pref/shared_pref_helper.dart';
import 'package:khudrah_companies/network/models/orders/order_header.dart';

import '../pages/orders/order_details.dart';
import '../resources/custom_colors.dart';
import 'package:easy_localization/easy_localization.dart';

Widget orderTileDesign(context, OrderHeader model, scWidth, scHeight) {
  String orderStatus = '';
  String orderDate = '';

  if (model.orderStatus == underProcess) {
    orderDate = model.orderInitializedDate!;
    orderStatus = LocaleKeys.under_process.tr();
  } else if (model.orderStatus == onDelivery) {
    orderDate = model.onDeliveryStatusDate!;
    orderStatus = LocaleKeys.on_delivery.tr();
  } else {
    orderDate = model.deliveredStatusDate!;
    orderStatus = LocaleKeys.completed_order.tr();
  }

  return ListTile(
    title: Center(
      child: GestureDetector(
        onTap: () {
          // navigate to order status page
          directToOrderDetails(context,model);
        },
        child: Stack(
          children: [
            Positioned(
                left: 0,
                top: 2,
                child: Container(
                  width: 6,
                  height: scHeight * 0.12,
                  color: CustomColors().primaryGreenColor,
                )),
            //background container
            Container(
              margin: EdgeInsets.symmetric(vertical: 2),
              alignment: Alignment.center,
              width: scWidth * 1.2,
              height: scHeight * 0.12,
              // scHeight*0.12
              decoration: BoxDecoration(
                border: Border.all(color: CustomColors().primaryGreenColor),
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
                        color: CustomColors().darkBlueColor,
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

void directToOrderDetails(context,model)async {
  String language = await PreferencesHelper.getSelectedLanguage;

  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => OrderDetails(
            orderModel: model,
            language:language ,
          )));
}
