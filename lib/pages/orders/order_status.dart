import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:im_stepper/stepper.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/designs/appbar_design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'package:status_change/status_change.dart';

import '../../helpers/cart_helper.dart';
import '../../helpers/custom_btn.dart';
import '../../network/models/cart/success_cart_response_model.dart';

class OrderStatus extends StatefulWidget {
  const OrderStatus({ Key? key }) : super(key: key);

  @override
  _OrderStatusState createState() => _OrderStatusState();
}

class _OrderStatusState extends State<OrderStatus> {

  num price = 21;
  static String language = 'ar';
  bool isTrashBtnEnabled = true;
  static String productId = '';

  // num priceAfterDiscount = model.userCart!.priceAfterDiscount!;
  // num? subtotal = model.userCart!.totalNetCartPrice!;
  // num? vat = model.userCart!.totalCartVAT15!;
  // num total = model.userCart!.totalCartPrice!;
  // num? discount = model.userCart!.discountPercentage! * 100;
  // bool? hasDiscount = model.userCart!.hasDiscount;

  num priceAfterDiscount = 0;
  num? subtotal = 0;
  num? vat = 0;
  num total = 0;
  num? discount = 0;
  bool? hasDiscount = false;
  

  static List<CartProductsList> list = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    double scWidth = size.width;
    double scHeight = size.height;

    return Scaffold(
      appBar: appBarDesign(context, LocaleKeys.order_status.tr()),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 10,),
            //Stepper container
            ExpansionTile(
              initiallyExpanded: false,
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(LocaleKeys.track_order.tr(), style: TextStyle(
                      color: CustomColors().darkBlueColor,
                      fontWeight: FontWeight.w800,
                      fontSize: 19
                    ),),
                  ),
                ],
              ),
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  // color: Colors.red,
                  width: scWidth*0.12,
                  height: scHeight*0.5,
                  // status change as child
                ),
              ]
            ),
            SizedBox(height: 15,),
            //order summary
            Container(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    width: scWidth*0.9,
                    height: scHeight*0.12,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                      border: Border.all(
                        color: CustomColors().primaryGreenColor,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          child: Container(
                            width: 5,
                            height: scHeight*0.12,
                            color: CustomColors().primaryGreenColor,
                          ),
                        ),
                        Positioned(
                          left: 0,
                          child: Container(
                            width: scWidth*0.2,
                            height: scHeight*0.17,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('images/ic_fruit_green.png')
                              )
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  //replace by order no
                                  child: Text('Order ID', style: TextStyle(
                                    color: CustomColors().primaryGreenColor,
                                    fontSize: 20, 
                                    fontWeight: FontWeight.w600,
                                  ),),
                                ),
                                Container(
                                  //replace by actual date
                                  child: Text('25/01/2022', style: TextStyle(
                                    color: CustomColors().primaryGreenColor,
                                    fontSize: 20, 
                                    fontWeight: FontWeight.w600,
                                  ),),
                                ),
                              ],
                            ),
                            Container(
                              //replace text by notification
                              margin: EdgeInsets.symmetric(horizontal: scWidth*0.12),
                              child: Text('(2) Items',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: CustomColors().darkBlueColor
                              ),),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            //items in order
            Container(
              // height: scHeight,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return orderItem();
                },
                itemCount: 7,
                shrinkWrap: true,
                dragStartBehavior: DragStartBehavior.down,
                // physics: NeverScrollableScrollPhysics(),
              ),
            ),
            // SizedBox(height: 50,),

            // //costs summary
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          LocaleKeys.order_details.tr(),
                          style: TextStyle(
                              color: CustomColors().brownColor.withOpacity(0.7),
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  // SizedBox(height: 40,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      cartDetailsItem(
                          LocaleKeys.subtotal.tr(), getTextWithCurrency(subtotal!)),
                      cartDetailsItem(
                          LocaleKeys.vat.tr(), getTextWithCurrency(vat!)),
                      if (hasDiscount!)
                        Column(
                          children: [
                            cartDetailsItem(LocaleKeys.discount_percentage.tr(),
                                getTextWithPercentage(discount!)),
                            cartDetailsItem(LocaleKeys.discount.tr(),
                                getTextWithCurrency(priceAfterDiscount)),
                          ],
                        )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Divider(
                  //   thickness: 1,
                  //   indent: 25,
                  //   endIndent: 25,
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      //total
                      cartTotalDesign(total),
                      //Receipt download button
                      InkWell(
                        child: Container(
                          width: 50,
                          height: 50,
                          child: Image.asset('images/ic_file_pdf.png')
                        ),
                        onTap: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget orderItem() {
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height*0.14,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          //product image
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 75,
                height: 75,
                child: Image.asset('images/green_fruit.png'),
              ),
              //name and price
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                        child: Text('Strawberry',
                        style: TextStyle(
                          color: CustomColors().darkBlueColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 16
                        ),),
                      ),
                    ],
                  ),
                  //price
                  Container(
                    child: Text( '$price ' + LocaleKeys.sar.tr(),
                    style: TextStyle(
                      color: CustomColors().primaryGreenColor
                    ),),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(width: 7,),
          //quantity
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Text('3 x', style: TextStyle(
                  color: CustomColors().darkGrayColor,
                  fontSize: 18
                ),),
              ),
            ],
          )
        ],
      ),
    );
  }
}


                    // child: IconStepper(
                    //   direction: Axis.vertical,
                    //   enableNextPreviousButtons: false,
                    //   stepColor: CustomColors().primaryGreenColor,
                    //   icons: [
                    //     Icon(Icons.receipt_long_rounded),
                    //     Icon(Icons.drive_eta),
                    //     Icon(Icons.store_mall_directory_rounded),
                    //     Icon(Icons.check)
                    //   ],
                    // ),





              //       StatusChange.tileBuilder(
              //   theme: StatusChangeThemeData(
              //     direction: Axis.vertical,
              //     connectorTheme:
              //         ConnectorThemeData(space: 1.0, thickness: 1.0),
              //   ),
              //   builder: StatusChangeTileBuilder.connected(
              //     itemWidth: (_) =>
              //         MediaQuery.of(context).size.width / 5, //_process.length
              //     contentWidgetBuilder: (context, index) {
              //       return Padding(
              //         padding: const EdgeInsets.all(15.0),
              //         child: Text(
              //           'add content here',
              //           style: TextStyle(
              //             color: Colors
              //                 .blue, // change color with dynamic color --> can find it with example section
              //           ),
              //         ),
              //       );
              //     },
              //     nameWidgetBuilder: (context, index) {
              //       return Padding(
              //         padding: const EdgeInsets.all(20),
              //         child: Text(
              //           'your text ',
              //           style: TextStyle(
              //             fontWeight: FontWeight.bold,
              //             color: getColor(index),
              //           ),
              //         ),
              //       );
              //     },
              //     indicatorWidgetBuilder: (_, index) {
              //       if (index <= _processIndex) {
              //         return DotIndicator(
              //           size: 35.0,
              //           border: Border.all(color: Colors.green, width: 1),
              //           child: Padding(
              //             padding: const EdgeInsets.all(6.0),
              //             child: Container(
              //               decoration: BoxDecoration(
              //                 shape: BoxShape.circle,
              //                 color: Colors.green,
              //               ),
              //             ),
              //           ),
              //         );
              //       } else {
              //         return OutlinedDotIndicator(
              //           size: 30,
              //           borderWidth: 1.0,
              //           color: todoColor,
              //         );
              //       }
              //     },
              //     lineWidgetBuilder: (index) {
              //       if (index > 0) {
              //         if (index == _processIndex) {
              //           final prevColor = getColor(index - 1);
              //           final color = getColor(index);
              //           var gradientColors;
              //           gradientColors = [
              //             prevColor,
              //             Color.lerp(prevColor, color, 0.5)
              //           ];
              //           return DecoratedLineConnector(
              //             decoration: BoxDecoration(
              //               gradient: LinearGradient(
              //                 colors: gradientColors,
              //               ),
              //             ),
              //           );
              //         } else {
              //           return SolidLineConnector(
              //             color: getColor(index),
              //           );
              //         }
              //       } else {
              //         return null;
              //       }
              //     },
              //     itemCount: _processes.length,
              //   ),
              // ),