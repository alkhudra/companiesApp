import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khudrah_companies/Constant/api_const.dart';
import 'package:khudrah_companies/Constant/conts.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:khudrah_companies/dialogs/progress_dialog.dart';
import 'package:khudrah_companies/helpers/custom_btn.dart';
import 'package:khudrah_companies/helpers/image_helper.dart';
import 'package:khudrah_companies/network/API/api_response.dart';
import 'package:khudrah_companies/network/API/api_response_type.dart';
import 'package:khudrah_companies/network/helper/exception_helper.dart';
import 'package:khudrah_companies/network/helper/network_helper.dart';
import 'package:khudrah_companies/network/models/cart/success_cart_response_model.dart';
import 'package:khudrah_companies/network/models/message_response_model.dart';
import 'package:khudrah_companies/network/models/product/product_model.dart';
import 'package:khudrah_companies/network/repository/cart_repository.dart';
import 'package:khudrah_companies/pages/products/product_details.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';

import 'number_helper.dart';

Widget cartDetailsItem(String title, String value) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
    child: RichText(
      text: TextSpan(
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: 'Almarai',
            color: CustomColors().primaryGreenColor,
          ),
          children: <TextSpan>[
            TextSpan(
                text: title + ': ',
                style: TextStyle(color: CustomColors().darkBlueColor)),
            TextSpan(
                text: value,
                style: TextStyle(
                  color: CustomColors().primaryGreenColor,
                  fontFamily: 'Almarai',
                )),
          ]),
    ),
  );
}

Widget cartTotalDesign(num total) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 5),
    child: RichText(
      text: TextSpan(
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w600,
            fontFamily: 'Almarai',
            color: CustomColors().primaryGreenColor,
          ),
          children: <TextSpan>[
            TextSpan(
                text: LocaleKeys.total.tr() + ': ',
                style: TextStyle(
                  color: CustomColors().primaryGreenColor,
                )),
            TextSpan(
                text: getTextWithCurrency(total),
                style: TextStyle(
                  color: CustomColors().primaryGreenColor,
                )),
          ]),
    ),
  );
}

Widget cartTile(BuildContext context, String language,
    List<CartProductsList?> list, int index) {
  ProductsModel model = list[index]!.productModel!;
  Size size = MediaQuery.of(context).size;
  double scWidth = size.width;
  double scHeight = size.height;

  num? price =
      (model.hasSpecialPrice == true ? model.specialPrice : model.originalPrice)
          ?.toDouble();
  String? name = language == 'ar' ? model.arName : model.name;

  bool? isPriceChanged = model.hasSpecialPrice == true
      ? list[index]!.hasSpecialProductPriceChanged
      : list[index]!.hasOriginalProductPriceChanged;

  bool? isQtyChanged = list[index]!.hasUserProductQuantityChanged;
  num? userQty = list[index]!.userProductQuantity! != null
      ? list[index]!.userProductQuantity!
      : 0;
  num stockQty = list[index]!.productModel!.quantity!;

  num productTotal = list[index]!.totalProductPrice != null
      ? list[index]!.totalProductPrice!
      : 0;
  bool isAvailable = model.isAvailabe!;
  bool isDeleted = model.isDeleted!;

  return
         Column(
           children: [
             GestureDetector(
               onTap: () {
                 if (isDeleted == false &&
                     isAvailable == true &&
                     userQty <= stockQty)
                   Navigator.push(
                       context,
                       MaterialPageRoute(
                           builder: (context) => ProductDetails(
                                 productModel: model,

                               )));
               },
               child: ListTile(
                 title: Column(
                   mainAxisAlignment: MainAxisAlignment.start,
                   children: [
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
                             child: ImageHelper.productImage(model.image),
                           ),
                           //category, name and price
                           Column(
                             mainAxisAlignment: MainAxisAlignment.spaceAround,
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               //product name
                               Container(
                                 child: Text(
                                   '$name',
                                   style: TextStyle(
                                       color: isAvailable == true || isDeleted == false
                                           ? CustomColors().brownColor
                                           : CustomColors().grayColor,
                                       fontWeight: FontWeight.w600),
                                 ),
                               ),

                               // price
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   Container(
                                     child: Text(
                                       getTextWithCurrency(price!),
                                       style: TextStyle(
                                           color: isPriceChanged!
                                               ? CustomColors().redColor
                                               : isAvailable == true ||
                                                       isDeleted == false
                                                   ? CustomColors().primaryGreenColor
                                                   : CustomColors().grayColor,
                                           fontWeight: FontWeight.w500),
                                     ),
                                   ),
                                   Container(
                                     child: Text(
                                       ' ×  $userQty  ',
                                       style: TextStyle(
                                           color: isQtyChanged == true
                                               ? CustomColors().redColor
                                               : isAvailable == true ||
                                                       isDeleted == false
                                                   ? CustomColors().primaryGreenColor
                                                   : CustomColors().grayColor,
                                           fontWeight: FontWeight.w500),
                                     ),
                                   ),
                                   SizedBox(
                                     width: scHeight * 0.08,
                                   ),
                                   Container(
                                     child: Text(
                                       getTextWithCurrency(productTotal),
                                       style: TextStyle(
                                           color: isPriceChanged
                                               ? CustomColors().redColor
                                               : isAvailable == true ||
                                                       isDeleted == false
                                                   ? CustomColors().primaryGreenColor
                                                   : CustomColors().grayColor,
                                           fontWeight: FontWeight.w600),
                                     ),
                                   ),


                                 ],
                               ),
                             ],
                           ),
                         ],
                       ),
                     ),
                   ],
                 ),
               ),
             ),

             Divider(
               thickness: 1,
               color: CustomColors().grayColor,
             ),
           ],
         );
}

