import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/designs/appbar_design.dart';
import 'package:khudrah_companies/designs/drawar_design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:khudrah_companies/helpers/custom_btn.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'package:lottie/lottie.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class CartPage extends StatefulWidget {
  const CartPage({ Key? key }) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  double price = 6.0;
  double subtotal = 28.9;
  double vat = 5.1;
  double total = 54;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //add body
      body: SlidingUpPanel(
        minHeight: 60,
        maxHeight: 230,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        // collapsed: Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Center(
        //       child: Container(
        //         margin: EdgeInsets.only(bottom: 25),
        //         child: Text(LocaleKeys.continue_btn.tr(),
        //         style: TextStyle(
        //           color: CustomColors().darkGrayColor,
        //           fontWeight: FontWeight.w600
        //         ),),
        //       ),
        //     ),
        //   ],
        // ),
        panel: Container(
          //Change height to be adaptable
          height: MediaQuery.of(context).size.height*0.16,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Text(LocaleKeys.order_details.tr(), style: TextStyle(
                      color: CustomColors().brownColor.withOpacity(0.7),
                      fontWeight: FontWeight.w600,
                      fontSize: 18
                    ),),
                  ),
                ],
              ),
              SizedBox(height: 25,),
              // SizedBox(height: 40,),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //subtotal
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Almarai',
                          color: CustomColors().primaryGreenColor,
                        ),
                        children: <TextSpan> [
                          TextSpan(text: LocaleKeys.subtotal.tr() + ': ',
                          style: TextStyle(
                            color: CustomColors().darkBlueColor
                          )),
                          TextSpan(text: ' $subtotal SAR',
                          style: TextStyle(
                            color: CustomColors().primaryGreenColor,
                            fontFamily: 'Almarai',
                          )),
                        ]
                      ),
                    ),
                  ),
                  //vat
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Almarai',
                          color: CustomColors().primaryGreenColor,
                        ),
                        children: <TextSpan> [
                          TextSpan(text: LocaleKeys.vat.tr() + ': ',
                          style: TextStyle(
                            color: CustomColors().darkBlueColor,
                            fontFamily: 'Almarai',
                          )),
                          TextSpan(text: ' $vat SAR',
                          style: TextStyle(
                            color: CustomColors().primaryGreenColor,
                          )),
                        ]
                      ),
                    ),
                  ),
                  //add discount price
                ],
              ),
              SizedBox(height: 10,),
              Divider(
                thickness: 1,
                indent: 25,
                endIndent: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //total
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Almarai',
                          color: CustomColors().primaryGreenColor,
                        ),
                        children: <TextSpan> [
                          TextSpan(text: LocaleKeys.total.tr() + ': ',
                          style: TextStyle(
                            color: CustomColors().primaryGreenColor,
                          )),
                          TextSpan(text: ' $total SAR',
                          style: TextStyle(
                            color: CustomColors().primaryGreenColor,
                          )),
                        ]
                      ),
                    ),
                  ),
                  //checkout button
                  Container(
                    child: greenBtn(LocaleKeys.checkout.tr(), EdgeInsets.symmetric(vertical: 4), () {}),
                  ),
                ],
              ),
            ],
          ),
        ),
        body: ListView.builder(
          itemBuilder: (context, indext) {
            return Slidable(
              endActionPane: ActionPane(
                key: const ValueKey(0),
                motion: const BehindMotion(),
                dismissible: DismissiblePane(onDismissed: () {}),
                children: [
                  SlidableAction(
                    onPressed: deleteFromCart(),
                    backgroundColor: CustomColors().redColor,
                    // foregroundColor: CustomColors().primaryWhiteColor,
                    icon: Icons.delete,
                    label: LocaleKeys.delete_from_cart.tr(),
                  )
                ],
              ),
              child: cartTile()
            );
          },
          itemCount: 10,
        ),
      ),
      // endDrawer: drawerDesign(context),
      appBar: bnbAppBar(context, LocaleKeys.cart.tr()),
      // bottomNavigationBar: BottomAppBar(
      //   child: Container(
      //     //Change height to be adaptable
      //     height: MediaQuery.of(context).size.height*0.14,
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.start,
      //       children: [
      //         SizedBox(height: 4,),
      //         Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceAround,
      //           children: [
      //             //subtotal
      //             Container(
      //               margin: EdgeInsets.symmetric(vertical: 5),
      //               child: RichText(
      //                 text: TextSpan(
      //                   style: TextStyle(
      //                     fontSize: 15,
      //                     fontWeight: FontWeight.w500,
      //                     fontFamily: 'Almarai',
      //                     color: CustomColors().primaryGreenColor,
      //                   ),
      //                   children: <TextSpan> [
      //                     TextSpan(text: LocaleKeys.subtotal.tr() + ': ',
      //                     style: TextStyle(
      //                       color: CustomColors().darkBlueColor
      //                     )),
      //                     TextSpan(text: ' $subtotal SAR',
      //                     style: TextStyle(
      //                       color: CustomColors().primaryGreenColor,
      //                       fontFamily: 'Almarai',
      //                     )),
      //                   ]
      //                 ),
      //               ),
      //             ),
      //             //vat
      //             Container(
      //               margin: EdgeInsets.symmetric(vertical: 5),
      //               child: RichText(
      //                 text: TextSpan(
      //                   style: TextStyle(
      //                     fontSize: 15,
      //                     fontWeight: FontWeight.w500,
      //                     fontFamily: 'Almarai',
      //                     color: CustomColors().primaryGreenColor,
      //                   ),
      //                   children: <TextSpan> [
      //                     TextSpan(text: LocaleKeys.vat.tr() + ': ',
      //                     style: TextStyle(
      //                       color: CustomColors().darkBlueColor,
      //                       fontFamily: 'Almarai',
      //                     )),
      //                     TextSpan(text: ' $vat SAR',
      //                     style: TextStyle(
      //                       color: CustomColors().primaryGreenColor,
      //                     )),
      //                   ]
      //                 ),
      //               ),
      //             ),
      //           ],
      //         ),
      //         SizedBox(height: 5,),
      //         // Divider(
      //         //   thickness: 1,
      //         // ),
      //         Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //           children: [
      //             //total
      //             Container(
      //               margin: EdgeInsets.symmetric(vertical: 5),
      //               child: RichText(
      //                 text: TextSpan(
      //                   style: TextStyle(
      //                     fontSize: 19,
      //                     fontWeight: FontWeight.w600,
      //                     fontFamily: 'Almarai',
      //                     color: CustomColors().primaryGreenColor,
      //                   ),
      //                   children: <TextSpan> [
      //                     TextSpan(text: LocaleKeys.total.tr() + ': ',
      //                     style: TextStyle(
      //                       color: CustomColors().primaryGreenColor,
      //                     )),
      //                     TextSpan(text: ' $total SAR',
      //                     style: TextStyle(
      //                       color: CustomColors().primaryGreenColor,
      //                     )),
      //                   ]
      //                 ),
      //               ),
      //             ),
      //             //checkout button
      //             Container(
      //               child: greenBtn(LocaleKeys.checkout.tr(), EdgeInsets.symmetric(vertical: 4), () {}),
      //             ),
      //           ],
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }

  Widget cartTile() {
    Size size = MediaQuery.of(context).size;
    double scWidth = size.width;
    double scHeight = size.height;

    return ListTile(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 5,),
          Container(
            width: MediaQuery.of(context).size.width*0.9,
            height: MediaQuery.of(context).size.height*0.15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              // border: Border.all(
              //   color: CustomColors().primaryGreenColor,
              // ),
              boxShadow: [
                BoxShadow(
                  color: CustomColors().blackColor.withOpacity(0.4),
                  offset: Offset(2, 2),
                  blurRadius: 5,
                  spreadRadius: 0.2,
                )
              ],
              color: CustomColors().primaryWhiteColor,
            ),
            child: Stack( 
              children: [
              //green product icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      child: Image.asset('images/green_fruit.png'),
                    ),
                    //category, name and price
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // SizedBox(height: 20,),
                        //category and name
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //category
                            Container(
                              child: Text(LocaleKeys.fruit_category.tr(),
                              style: TextStyle(
                                color: CustomColors().darkGrayColor,
                              ),),
                            ),
                            //product name
                            Container(
                              child: Text('Banana',
                              style: TextStyle(
                                color: CustomColors().brownColor,
                              ),),
                            ),
                          ],
                        ),
                        // price
                        Container(
                          child: Text('$price  ' + LocaleKeys.sar_per_kg.tr(),
                          style: TextStyle(
                            color: CustomColors().primaryGreenColor,
                            fontWeight: FontWeight.w700
                          ),),
                        ),
                      ],
                    ),
                    //counter
                    Container(
                      width: scWidth*0.071,
                      height: scHeight*0.13,
                      decoration: BoxDecoration(
                        color: CustomColors().grayColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            child: Container(
                              padding: EdgeInsets.all(4),
                              child: Text(
                                '-',
                                style: TextStyle(
                                  color: CustomColors().darkBlueColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            onTap: () {
                              //Decrease count method
                            },
                          ),
                          Container(
                            child: Text(
                              '0',
                              // '$counter',
                              style: TextStyle(
                                color: CustomColors().darkBlueColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          GestureDetector(
                            child: Container(
                              padding: EdgeInsets.all(4),
                              child: Text(
                                '+',
                                style: TextStyle(
                                  color: CustomColors().darkBlueColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            onTap: () {
                              //increase count method
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10,),
                    //Delete icon
                          Container(
                            alignment: Alignment.center,
                            width: 2,
                            child: IconButton(
                              onPressed: () {}, 
                              icon: Icon(Icons.arrow_back_ios,
                                color: CustomColors().darkGrayColor,),
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(),
                            ),
                          ),
                    // Container(
                    //   child: Stack(
                    //     children: [
                    //       VerticalDivider(
                    //         thickness: 30,
                    //         color: CustomColors().primaryGreenColor,
                    //       ),
                    //       Container(
                    //         alignment: Alignment.center,
                    //         width: 2,
                    //         child: IconButton(
                    //           onPressed: () {}, 
                    //           icon: Icon(Icons.arrow_back_ios,
                    //             color: CustomColors().darkGrayColor,),
                    //           padding: EdgeInsets.zero,
                    //           constraints: BoxConstraints(),
                    //         ),
                    //       ),
                    //       // GestureDetector(
                    //       //   child: Container(
                    //       //     child: Center(child: Icon(Icons.arrow_back_ios_new_rounded)),
                    //       //   ),
                    //       //   onTap: () {},
                    //       // ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ]
            ),
          ),
        ],
      ),
    );
  }

  //TODO: Define delete method
  deleteFromCart() {

  }
}


/*
      Center(
        child: Container(
          child: Lottie.asset(
              'images/anim_avocado.json',
              width: 300,
              height: 150,
              fit: BoxFit.fill,
          ),
        ),
      ),
*/