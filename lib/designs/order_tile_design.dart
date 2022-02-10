import 'package:flutter/material.dart';

import '../resources/custom_colors.dart';

Widget orderTileDesign(context, scWidth, scHeight) {
  return ListTile(
    title: Center(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Stack(
              children: [
                //Add order detail container
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
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
                        CustomColors().lightGreen.withOpacity(0.7),
                      ]
                    ),
                  ),
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    child: Image.asset('images/ic_fruit_green.png'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                  alignment: Alignment.center,
                  width: scWidth*0.9,
                  height: scHeight*0.3,
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                            alignment: Alignment.center,
                            child: Text('Order Num', 
                            style: TextStyle(
                              color: CustomColors().primaryWhiteColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                            ),),
                          ),
                            Container(
                              child: Text('17/11/2021', 
                              style: TextStyle(
                                color: CustomColors().primaryWhiteColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8,),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
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
              ],
            ),
          ],
        ),
      ),
    ),
  );
}