import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khudrah_companies/Constant/conts.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/designs/appbar_design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:khudrah_companies/designs/product_card.dart';
import 'package:khudrah_companies/network/models/orders/order_header.dart';
import 'package:khudrah_companies/network/models/orders/order_items.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../helpers/cart_helper.dart';
import '../../helpers/custom_btn.dart';
import '../../network/models/cart/success_cart_response_model.dart';

class OrderDetails extends StatefulWidget {
  final OrderHeader orderModel;
  final String language;
  const OrderDetails(
      {Key? key, required this.orderModel, required this.language})
      : super(key: key);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  bool isTrashBtnEnabled = true;
  static String productId = '';

  // num priceAfterDiscount = model.userCart!.priceAfterDiscount!;
  // num? subtotal = model.userCart!.totalNetCartPrice!;
  // num? vat = model.userCart!.totalCartVAT15!;
  // num total = model.userCart!.totalCartPrice!;
  // num? discount = model.userCart!.discountPercentage! * 100;
  // bool? hasDiscount = model.userCart!.hasDiscount;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double scHeight = size.height;

    OrderHeader model = widget.orderModel;

    return Scaffold(
      appBar: appBarDesign(context, LocaleKeys.order_status.tr()),
      body: model.orderStatus == onDelivery
          ? SlidingUpPanel(
              body: pageContent(model),
              minHeight: scHeight * 0.07,
              maxHeight: 160,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
              //todo: driver info
              panel: Container(
                height: MediaQuery.of(context).size.height * 0.14,
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
                          padding:
                              EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                          child: Text(
                            LocaleKeys.contact_driver.tr(),
                            style: TextStyle(
                                color:
                                    CustomColors().brownColor.withOpacity(0.8),
                                fontWeight: FontWeight.w600,
                                fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            //driver profile pic
                            Container(
                              child: Icon(
                                Icons.person_pin_rounded,
                                color: CustomColors()
                                    .darkGrayColor
                                    .withOpacity(0.3),
                                size: 55,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //driver name
                                Container(
                                  child: Text(
                                    'Driver Name',
                                    style: TextStyle(
                                        color: CustomColors().darkBlueColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                //driver number
                                Container(
                                  child: Text(
                                    '05********',
                                    style: TextStyle(
                                        color: CustomColors()
                                            .darkGrayColor
                                            .withOpacity(0.8),
                                        fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        //Call driver button
                        Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(35),
                                color: CustomColors().primaryGreenColor),
                            child: TextButton(
                              child: Icon(
                                FontAwesomeIcons.phone,
                                color: CustomColors().primaryWhiteColor,
                                size: 24,
                              ),
                              onPressed: () {},
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            )
          : pageContent(model),
    );
  }
//-------------list tile----------------

  Widget orderItem(OrderItems item, scHeight) {
    num? productPrice = item.orderedProductPrice;
    return ListTile(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 5,
          ),
          Container(
            width: double.infinity,
            height: scHeight * 0.1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 75,
                  height: 75,
                  child: ProductCard.productImage(null),
                ),
                //category, name and price
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        'name',
                        style: TextStyle(
                            color: CustomColors().brownColor,
                            fontWeight: FontWeight.w600),
                      ),
                    ),

                    // price
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            getTextWithCurrency(productPrice!),
                            style: TextStyle(
                                color: CustomColors().primaryGreenColor,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          child: Text(
                            ' × ' + item.userProductQuantity.toString(),
                            style: TextStyle(
                                color: CustomColors().primaryGreenColor,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(
                          width: scHeight * 0.08,
                        ),
                        Container(
                          child: Text(
                            getTextWithCurrency(item.totalProductPrice!),
                            style: TextStyle(
                                color: CustomColors().primaryGreenColor,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                //counter
                /*     Container(
                  width: scWidth * 0.071,
                  height: scHeight * 0.13,
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
                          '$userQty',
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
                ),*/
                SizedBox(
                  width: 10,
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
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
    /* return ListTile(
      title: Container(
        // margin: EdgeInsets.symmetric(horizontal: 20),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.14,
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
                SizedBox(
                  width: 18,
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
                        */ /*  Container(
                         child: Text(
                            LocaleKeys.fruit_category.tr(),
                            style: TextStyle(
                              color: CustomColors().darkGrayColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),*/ /*
                        //product name
                        Container(
                          child: Text(
                            "item.",
                            style: TextStyle(
                                color: CustomColors().darkBlueColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    //price
                    Container(
                      child: Text(
                        '$productPrice ' + LocaleKeys.sar.tr(),
                        style:
                            TextStyle(color: CustomColors().primaryGreenColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              width: 7,
            ),
            //quantity
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(
                    getTextWithCurrency(productPrice!),
                    style: TextStyle(
                        color: CustomColors().primaryGreenColor,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  child: Text(
                    ' ×'+item.userProductQuantity.toString(),
                    style: TextStyle(
                        color: CustomColors().primaryGreenColor,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              */ /*  SizedBox(
                  width: scHeight * 0.08,
                ),*/ /*
                Container(
                  child: Text(
                    getTextWithCurrency(productPrice * item.userProductQuantity!),
                    style: TextStyle(
                        color:CustomColors().primaryGreenColor,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
      */ /*      Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Text(
                    item.userProductQuantity!.toString()+' x',
                    style: TextStyle(
                        color: CustomColors().darkGrayColor, fontSize: 18),
                  ),
                ),
              ],
            )*/ /*
          ],
        ),
      ),
    );*/
  }

//-------------status line--------------------
  //maybe add icon
  Container statusChange(String status, bool isActive, isCompleted) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive
                  ? CustomColors().primaryGreenColor
                  : isCompleted
                      ? CustomColors().primaryGreenColor
                      : CustomColors().primaryWhiteColor,
              //change color depending on active stage
              border: Border.all(
                  color: isActive || isCompleted
                      ? Colors.transparent
                      : CustomColors().primaryGreenColor,
                  width: 3),
            ),
          ),
          SizedBox(
            width: 30,
          ),
          Container(
            child: Text(
              status,
              style: TextStyle(
                  color: isActive
                      ? CustomColors().primaryGreenColor
                      : CustomColors().darkGrayColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
//---------------------------------

  pageContent(model) {
    num? priceAfterDiscount = model.totalDiscount;
    num? subtotal = model.totalOrderPrice;
    num? vat = model.totalOrderVAT15;
    num? total = model.totalNetOrderPrice;
    num? discount = model.discountPercentage;
    bool? hasDiscount = model.hasDiscount;

    String orderDate = '';
    if (model.orderStatus == underProcess) {
      orderDate = model.orderInitializedDate!;
    } else if (model.orderStatus == onDelivery) {
      orderDate = model.onDeliveryStatusDate!;
    } else {
      orderDate = model.deliveredStatusDate!;
    }
    int listItemsNumber = model.orderItems!.length;

    Size size = MediaQuery.of(context).size;
    double scWidth = size.width;
    double scHeight = size.height;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          //Stepper container
          ExpansionTile(
              initiallyExpanded: false,
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      LocaleKeys.track_order.tr(),
                      style: TextStyle(
                          color: CustomColors().brownColor,
                          fontWeight: FontWeight.w800,
                          fontSize: 19),
                    ),
                  ),
                ],
              ),
              children: [
                Container(
                  width: scWidth,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Stack(
                    children: [
                      Container(
                        margin:
                            EdgeInsets.only(left: 10, bottom: 10, right: 10),
                        width: 4,
                        height: 200,
                        color: CustomColors().grayColor,
                      ),
                      Column(
                        children: [
                          //status title, isActive, isCompleted
                          statusChange(
                              LocaleKeys.under_process.tr(),
                              model.orderStatus == underProcess,
                              model.orderStatus != underProcess),
                          statusChange(
                              LocaleKeys.on_delivery.tr(),
                              model.orderStatus == onDelivery,
                              model.orderStatus == completed),
                          statusChange(
                              LocaleKeys.completed_order.tr(),
                              model.orderStatus == completed,
                              model.orderStatus == completed),
                        ],
                      ),
                    ],
                  ),
                ),
              ]),
          SizedBox(
            height: 15,
          ),
          //order summary
          Container(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 5),
                  width: scWidth * 0.9,
                  height: scHeight * 0.12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(55),
                      bottomRight: Radius.circular(55),
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
                          height: scHeight * 0.12,
                          color: CustomColors().primaryGreenColor,
                        ),
                      ),
                      Positioned(
                        left: 0,
                        child: Container(
                          width: scWidth * 0.2,
                          height: scHeight * 0.17,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage('images/ic_fruit_green.png'))),
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
                                child: Text(
                                  '#' + model.invoiceNumber.toString(),
                                  style: TextStyle(
                                    color: CustomColors().primaryGreenColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Container(
                                //replace by actual date
                                child: Text(
                                  orderDate,
                                  style: TextStyle(
                                    color: CustomColors().primaryGreenColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            //replace text by notification
                            margin: EdgeInsets.symmetric(
                                horizontal: scWidth * 0.12),
                            child: Text(
                              '($listItemsNumber)' + LocaleKeys.items.tr(),
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: CustomColors().darkBlueColor),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          //ordered products title
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  LocaleKeys.products_in_order.tr(),
                  style: TextStyle(
                      color: CustomColors().brownColor,
                      fontWeight: FontWeight.w800,
                      fontSize: 19),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          //list of ordered products
          LimitedBox(
            maxHeight: scHeight * 20,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return orderItem(model.orderItems![index], scHeight);
                    },
                    itemCount: listItemsNumber,
                    shrinkWrap: true,
                    // dragStartBehavior: DragStartBehavior.down,
                    physics: NeverScrollableScrollPhysics(),
                  ),
                ),
              ],
            ),
          ),
          //order details
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        LocaleKeys.order_details.tr(),
                        style: TextStyle(
                            color: CustomColors().brownColor,
                            fontWeight: FontWeight.w800,
                            fontSize: 19),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    cartDetailsItem(LocaleKeys.subtotal.tr(),
                        getTextWithCurrency(subtotal!)),
                    cartDetailsItem(
                        LocaleKeys.vat.tr(), getTextWithCurrency(vat!)),
                    if (hasDiscount!)
                      Column(
                        children: [
                          cartDetailsItem(LocaleKeys.discount_percentage.tr(),
                              getTextWithPercentage(discount!)),
                          cartDetailsItem(LocaleKeys.discount.tr(),
                              getTextWithCurrency(priceAfterDiscount!)),
                        ],
                      )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //total
                    cartTotalDesign(total!),
                    //Receipt download button
                    InkWell(
                      child: Container(
                          width: 50,
                          height: 50,
                          child: Image.asset('images/ic_file_pdf.png')),
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 220,
          ),

          // //costs summary
          // Container(
          //   height: MediaQuery.of(context).size.height * 0.3,
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       SizedBox(
          //         height: 10,
          //       ),
          //       Row(
          //         children: [
          //           Container(
          //             padding: EdgeInsets.symmetric(horizontal: 30),
          //             child: Text(
          //               LocaleKeys.order_details.tr(),
          //               style: TextStyle(
          //                   color: CustomColors().brownColor.withOpacity(0.7),
          //                   fontWeight: FontWeight.w600,
          //                   fontSize: 18),
          //             ),
          //           ),
          //         ],
          //       ),
          //       SizedBox(
          //         height: 25,
          //       ),
          //       Column(
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           cartDetailsItem(
          //               LocaleKeys.subtotal.tr(), getTextWithCurrency(subtotal!)),
          //           cartDetailsItem(
          //               LocaleKeys.vat.tr(), getTextWithCurrency(vat!)),
          //           if (hasDiscount!)
          //             Column(
          //               children: [
          //                 cartDetailsItem(LocaleKeys.discount_percentage.tr(),
          //                     getTextWithPercentage(discount!)),
          //                 cartDetailsItem(LocaleKeys.discount.tr(),
          //                     getTextWithCurrency(priceAfterDiscount)),
          //               ],
          //             )
          //         ],
          //       ),
          //       SizedBox(
          //         height: 10,
          //       ),
          //       // Divider(
          //       //   thickness: 1,
          //       //   indent: 25,
          //       //   endIndent: 25,
          //       // ),
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceAround,
          //         children: [
          //           //total
          //           cartTotalDesign(total),
          //           //Receipt download button
          //           InkWell(
          //             child: Container(
          //               width: 50,
          //               height: 50,
          //               child: Image.asset('images/ic_file_pdf.png')
          //             ),
          //             onTap: () {},
          //           ),
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
