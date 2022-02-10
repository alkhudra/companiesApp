import 'package:flutter/material.dart';

import '../pages/orders/order_status.dart';
import '../resources/custom_colors.dart';

Widget orderTileDesign(context, scWidth, scHeight) {
  return ListTile(
    title: Center(
      child: Stack(
        children: [
          //background container
          GestureDetector(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              alignment: Alignment.center,
              width: scWidth*0.83,
              height: 85,
              // scHeight*0.12
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(45),
                  bottomRight: Radius.circular(45),
                ),
                gradient: LinearGradient(
                  colors: [
                    CustomColors().primaryGreenColor.withGreen(150),
                    CustomColors().lightGreen.withOpacity(0.8),
                  ]
                ),
              ),
              child: Container(
                alignment: Alignment.bottomLeft,
                child: Image.asset('images/ic_light_grape.png'),
              ),
            ),
            onTap: () {
              // navigate to order status page
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => OrderStatus())
              );
            },
          ),
          // Container(),
          //details container
          GestureDetector(
            child: Container(
              // margin: EdgeInsets.symmetric(horizontal: 60, vertical: 20),
              alignment: Alignment.center,
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      //Order ID
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                        alignment: Alignment.center,
                        child: Text('Order ID', 
                        style: TextStyle(
                          color: CustomColors().primaryWhiteColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),),
                      ),
                      //Order Date
                        Container(
                          child: Text('17/11/2021', 
                          style: TextStyle(
                            color: CustomColors().primaryWhiteColor,
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
                        color: CustomColors().primaryWhiteColor,
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