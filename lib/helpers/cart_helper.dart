import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khudrah_companies/Constant/api_const.dart';
import 'package:khudrah_companies/Constant/conts.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:khudrah_companies/designs/product_card.dart';
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

  return Column(children: [

    ListTile(

      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 5,
          ),
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
                              language: language,
                            )));
            },
            child: Container(
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
                              color: isAvailable == true || isDeleted == false ? CustomColors().brownColor : CustomColors().grayColor ,
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
                                      :isAvailable == true || isDeleted == false? CustomColors().primaryGreenColor : CustomColors().grayColor ,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Container(
                            child: Text(
                              ' ×  $userQty  ',
                              style: TextStyle(
                                  color: isQtyChanged == true
                                      ? CustomColors().redColor
                                      : isAvailable == true || isDeleted == false? CustomColors().primaryGreenColor : CustomColors().grayColor ,
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
                                      : isAvailable == true || isDeleted == false? CustomColors().primaryGreenColor : CustomColors().grayColor ,
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
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    ),
    Divider(
      thickness: 1,
      color: CustomColors().grayColor,
    )
  ]);
}



Widget addToCartBtnContainer(BuildContext context,
    {productsModel,
    userQty,
    onDeleteBtnClicked,
    onIncreaseBtnClicked,
    onDecreaseBtnClicked,
    onBtnClicked}) {
  return Container(
      margin: EdgeInsets.only(top: 10),
      child:
          productsModel.isDeleted == false && productsModel.isAvailabe == true
              //show add to cart options
              ? productsModel.isAddedToCart == false && userQty == 0
                  //show cart button
                  ? cartBtn(
                      Icons.shopping_cart,
                      // LocaleKeys.add_cart.tr(),
                      EdgeInsets.symmetric(horizontal: 5),
                      onBtnClicked)
                  //show counter
                  : qtyContainer(context, userQty, onDeleteBtnClicked,
                      onIncreaseBtnClicked, onDecreaseBtnClicked)
              //show product unavailable
              : unAvailableBtn(
                  LocaleKeys.not_available_product.tr(),
                  EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                  MediaQuery.of(context).size.height * 0.04,
                  11.6));
}

qtyContainer(BuildContext context, int counter, Function() onDeleteBtnClicked,
    Function() onIncreaseBtnClicked, Function() onDecreaseBtnClicked) {
  Size size = MediaQuery.of(context).size;
  double scWidth = size.width;
  double scHeight = size.height;
  return Container(
    margin: EdgeInsets.symmetric(vertical: 5),
    padding: EdgeInsets.symmetric(horizontal: 10),
    width: scWidth * 0.25,
    height: scHeight * 0.04,
    decoration: BoxDecoration(
      color: CustomColors().grayColor,
      borderRadius: BorderRadius.circular(30),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        counter == 1
            ? GestureDetector(
                onTap: onDeleteBtnClicked,
                child: Container(
                  padding: EdgeInsets.all(4),
                  child: Icon(
                    Icons.delete_outline_outlined,
                    color: CustomColors().primaryGreenColor,
                  ),
                ),
              )
            : GestureDetector(
                onTap: onDecreaseBtnClicked,
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
              ),
        SizedBox(
          width: 10,
        ),
        Container(
          child: Text(
            '$counter',
            style: TextStyle(
              color: CustomColors().blackColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        GestureDetector(
          onTap: onIncreaseBtnClicked,
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
        ),
      ],
    ),
  );
}

cartDBProcess(BuildContext context, String productId, String process) async {
  showLoaderDialog(context);
  //----------start api ----------------
  ApiResponse apiResponse;
  Map<String, dynamic> headerMap = await getHeaderMap();

  CartRepository cartRepository = CartRepository(headerMap);
  if (process == addToCartConst)
    apiResponse = await cartRepository.addProductToCart(productId);
  else if (process == addQtyToCartConst)
    apiResponse = await cartRepository.addProductQtyToCart(productId);
  else if (process == deleteFromCartConst)
    apiResponse = await cartRepository.deleteProductFromCart(productId);
  else
    apiResponse = await cartRepository.deleteProductQtyFromCart(productId);

  if (apiResponse.apiStatus.code == ApiResponseType.OK.code) {
    MessageResponseModel model =
        MessageResponseModel.fromJson(apiResponse.result);
    Navigator.pop(context);

    return model.message!;
  } else {
    Navigator.pop(context);
    return apiResponse.message;
    //throw ExceptionHelper(apiResponse.message);
  }
}
