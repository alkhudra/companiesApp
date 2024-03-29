import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khudrah_companies/Constant/conts.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/designs/appbar_design.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:khudrah_companies/helpers/contact_helper.dart';
import 'package:khudrah_companies/helpers/image_helper.dart';
import 'package:khudrah_companies/helpers/number_helper.dart';
import 'package:khudrah_companies/helpers/order_helper.dart';
import 'package:khudrah_companies/network/models/orders/driver_user.dart';
import 'package:khudrah_companies/network/models/orders/order_header.dart';
import 'package:khudrah_companies/network/models/orders/order_items.dart';
import 'package:khudrah_companies/pages/orders/order_list.dart';
import 'package:khudrah_companies/provider/genral_provider.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../designs/order_tile_design.dart';
import '../../helpers/cart_helper.dart';
import '../../helpers/custom_btn.dart';
import '../../network/models/cart/success_cart_response_model.dart';

class OrderDetails extends StatefulWidget {
  final OrderHeader orderModel;

  const OrderDetails({Key? key, required this.orderModel}) : super(key: key);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  bool isTrashBtnEnabled = true;

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
    DriverUser driverUser = DriverUser();
    if (widget.orderModel.driverUser != null)
      driverUser = widget.orderModel.driverUser!;
    return Scaffold(
      appBar: appBarDesign(context, LocaleKeys.order_status.tr()),
      body: /* model.orderStatus == onDelivery
          ? SlidingUpPanel(
              body: pageContent(model),
              minHeight: scHeight * 0.07,
              maxHeight: 160,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
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
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            //driver profile pic
                            ImageHelper.driverImage(context, driverUser.image),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //driver name
                                Container(
                                  child: Text(
                                    driverUser.driverName != null
                                        ? driverUser.driverName!
                                        : '',
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
                                    driverUser.phoneNumber != null
                                        ? driverUser.phoneNumber!
                                        : '',
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
                              onPressed: () {
                                directToPhoneCall(driverUser.phoneNumber != null
                                    ? driverUser.phoneNumber!
                                    : '');
                              },
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            )
          :*/
          pageContent(model),
    );
  }
//-------------list tile----------------

  Widget orderItem(OrderItems item, scHeight) {
    num? productPrice = item.orderedProductPrice;
    String? name = Provider.of<GeneralProvider>(context, listen: false)
                .userSelectedLanguage ==
            "ar"
        ? item.product!.arName!
        : item.product!.name!;
    return ListTile(
      leading: ImageHelper.productImage(item.product!.image),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //product name
          Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Text(
                // '$name',
                '$name'.length > 20 ? '${name.substring(0, 20)} ...' : '$name',
                maxLines: 1,
                style: TextStyle(
                    color: CustomColors().brownColor,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),

          // price
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      getTextWithCurrency(productPrice!),
                      maxLines: 1,
                      style: TextStyle(
                          color: CustomColors().primaryGreenColor,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      ' ×  ' + item.userProductQuantity.toString(),
                      maxLines: 1,
                      style: TextStyle(
                          color: CustomColors().primaryGreenColor,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Text(
                  getTextWithCurrency(item.totalProductPrice!),
                  maxLines: 1,
                  style: TextStyle(
                      color: CustomColors().primaryGreenColor,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
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

  pageContent(OrderHeader model) {
    num? priceAfterDiscount = model.totalDiscount;
    num? subtotal = model.totalOrderPrice;
    num? vat = model.totalOrderVAT15;
    num? total = model.totalNetOrderPrice;
    num? discount = model.discountPercentage;
    bool? hasDiscount = model.hasDiscount;

    //------ date
    String orderDate = '';
    if (model.orderStatus == underProcess) {
      orderDate = model.orderInitializedDate!;
    } else if (model.orderStatus == onDelivery) {
      orderDate = model.onDeliveryStatusDate!;
    } else {
      orderDate = model.deliveredStatusDate!;
    }
    //----- payment
    Color paymentColor = CustomColors().primaryGreenColor;
    String paymentText = '';
    IconData paymentIcon = FontAwesomeIcons.moneyBillWave;

    if (model.paymentType == visa) {
      paymentText = LocaleKeys.credit_card.tr();
      paymentIcon = FontAwesomeIcons.solidCreditCard;
    } else if (model.paymentType == cash) {
      paymentText = LocaleKeys.cash.tr();
      paymentIcon = FontAwesomeIcons.moneyBillWave;
    } else if (model.paymentType == applePay) {
      paymentText = LocaleKeys.apple_pay.tr();
      paymentIcon = FontAwesomeIcons.applePay;
    } else if (model.paymentType == stcPay) {
      paymentText = LocaleKeys.stc_pay.tr();
      //todo:edit stc pay icon
      paymentIcon = FontAwesomeIcons.gratipay;
    } else if (model.paymentType == credit) {
      paymentText = LocaleKeys.postpaid.tr();
      paymentIcon = FontAwesomeIcons.receipt;
    } else {
      paymentText = LocaleKeys.transfer.tr();
      paymentIcon = FontAwesomeIcons.peopleArrows;
    }

    DriverUser driverUser = DriverUser();
    if (model.driverUser != null) driverUser = widget.orderModel.driverUser!;
    //--------
    int listItemsNumber = model.orderItems!.length;

    Size size = MediaQuery.of(context).size;
    double scWidth = size.width;
    double scHeight = size.height;
    return ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //Stepper container
              ExpansionTile(
                  initiallyExpanded: false,
                  title:
                      titleTextDesignForExpanTile(LocaleKeys.track_order.tr()),
                  children: [
                    Container(
                      width: scWidth,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                left: 10, bottom: 10, right: 10),
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
                                  model.orderStatus == delivered),
                              statusChange(
                                  LocaleKeys.completed_order.tr(),
                                  model.orderStatus == delivered,
                                  model.orderStatus == delivered),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ]),
              Divider(),
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
                                      image: AssetImage(
                                          'images/ic_fruit_green.png'))),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                                  '($listItemsNumber) ' + LocaleKeys.items.tr(),
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
              Divider(),
              //ordered products title
              titleTextDesign(LocaleKeys.products_in_order.tr()),

              //list of ordered products

              Column(
                children: [
                  ListView.builder(
                    itemBuilder: (context, index) {
                      return orderItem(model.orderItems![index], scHeight);
                    },
                    itemCount: listItemsNumber,
                    shrinkWrap: true,
                    // dragStartBehavior: DragStartBehavior.down,
                    physics: NeverScrollableScrollPhysics(),
                  ),
                ],
              ),

              if (model.orderStatus == onDelivery)
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(),
                    titleTextDesign(LocaleKeys.contact_driver.tr()),
                    ListTile(
                      trailing: //Call driver button
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
                                onPressed: () {
                                  directToPhoneCall(
                                      driverUser.phoneNumber != null
                                          ? driverUser.phoneNumber!
                                          : '');
                                },
                              )),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //driver name
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              driverUser.driverName != null
                                  ? driverUser.driverName!
                                  : '',
                              style: TextStyle(
                                  color: CustomColors().darkBlueColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),

                          //driver number
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              driverUser.phoneNumber != null
                                  ? driverUser.phoneNumber!
                                  : '',
                              style: TextStyle(
                                  color: CustomColors()
                                      .darkGrayColor
                                      .withOpacity(0.8),
                                  fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      leading:
                          ImageHelper.driverImage(context, driverUser.image),
                    ),

                  ],
                ),
              Divider(),
              //payment method
              titleTextDesign(LocaleKeys.payment_method.tr()),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: payButtonDesign(
                        context, paymentColor, paymentText, paymentIcon),
                    padding: EdgeInsets.symmetric(horizontal: 30),
                  ),
                  /*       if (model.paymentType == credit)
                          greenBtn(
                              LocaleKeys.pay_now.tr(),
                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                              () {

                              })*/
                ],
              ),

              //order details

              Divider(),
              titleTextDesign(LocaleKeys.order_details.tr()),

              Row(
                children: [
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
                ],
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
                    onTap: () {
                      print(widget.orderModel.invoicePDFPath!);
                      OrderHelper.displayInvoice(
                          widget.orderModel.invoicePDFPath!,
                          widget.orderModel.hasOrderCreatedFromDashboard!);
                    },
                  ),
                ],
              ),
              SizedBox(
                height: widget.orderModel.orderStatus == 'Delivered' ? 220 : 25,
              ),
            ],
          );
        });
  }



  titleTextDesignForExpanTile(text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        text,
        style: TextStyle(
            color: CustomColors().brownColor,
            fontWeight: FontWeight.w800,
            fontSize: 19),
      ),
    );
  }
}
