import 'package:flutter/material.dart';

import '../pages/orders/order_status.dart';
import '../resources/custom_colors.dart';

Widget orderTileDesign(context, scWidth, scHeight) {
  return ListTile(
    title: Center(
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 2,
            child: Container(
              width: 4, 
              height: scHeight*0.12,
              color: CustomColors().primaryGreenColor,
            )
          ),
          //background container
          GestureDetector(
            
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 2),
              alignment: Alignment.center,
              width: scWidth*0.83,
              height: scHeight*0.12,
              // scHeight*0.12
              decoration: BoxDecoration(
                border: Border.all(color: CustomColors().primaryGreenColor),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(45),
                  bottomRight: Radius.circular(45),
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
            onTap: () {
              // navigate to order status page
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => OrderStatus())
              );
            },
          ),
          //details container
          GestureDetector(
            child: Container(
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
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 17),
                        alignment: Alignment.center,
                        child: Text('Order ID', 
                        style: TextStyle(
                          color: CustomColors().primaryGreenColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),),
                      ),
                      //Order Date
                        Container(
                          child: Text('17/11/2021', 
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
                    padding: EdgeInsets.symmetric(horizontal: scWidth*0.145),
                    child: Text('2 items', 
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
            onTap: () {
              // navigate to order status page
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => OrderStatus())
              );
            },
          ),
        ],
      ),
    ),
  );
}