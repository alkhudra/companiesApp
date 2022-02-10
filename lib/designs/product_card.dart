import 'package:flutter/material.dart';
import 'package:khudrah_companies/Constant/api_const.dart';
import 'package:khudrah_companies/Constant/conts.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/dialogs/progress_dialog.dart';
import 'package:khudrah_companies/helpers/cart_helper.dart';
import 'package:khudrah_companies/helpers/snack_message.dart';
import 'package:khudrah_companies/network/API/api_response.dart';
import 'package:khudrah_companies/network/API/api_response_type.dart';
import 'package:khudrah_companies/network/helper/network_helper.dart';
import 'package:khudrah_companies/network/models/message_response_model.dart';
import 'package:khudrah_companies/network/models/product/product_model.dart';
import 'package:khudrah_companies/network/repository/product_repository.dart';
import 'package:khudrah_companies/pages/products/product_details.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:khudrah_companies/network/helper/exception_helper.dart';

class ProductCard {
  static bool isAddToFavBtnEnabled = true,isTrashBtnEnabled=true,isAddToCartBtnEnabled=true,
      isIncreaseBtnEnabled=true,isDecreaseBtnEnabled=true;

  static productCardDesign(context, String language, ProductsModel productModel,Function() favPressed,
  /*    {counter ,increaseCount, decreaseCount}*/) {

    double? price = (productModel.hasSpecialPrice == true
            ? productModel.specialPrice
            : productModel.originalPrice)
        ?.toDouble();

    bool? isFavourite = productModel.isFavourite;
    bool? isAvailable = productModel.isAvailabe;
    String? productId = productModel.productId;
    bool isDeleted = productModel.isDeleted!;
    String? name = language == 'ar' ? productModel.arName : productModel.name;
    String imageUrl = productModel.image != null ?ApiConst.images_url + productModel.image! :
    'images/green_fruit.png';

    int counter = 0;

    //--------------------------


    return GestureDetector(
        child: ListTile(
          title: Column(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //left side of card
                    Container(
                      margin: EdgeInsets.only(bottom: 5),
                      width: MediaQuery.of(context).size.width * 0.17,
                      height: MediaQuery.of(context).size.height * 0.17,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage('$imageUrl'),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    //center of card
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            '$name',
                            style: TextStyle(
                                color: CustomColors().brownColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 22),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                                                  Container(
                            padding: EdgeInsets.all(2),
                            child: Text(
                                ( "$price "+ LocaleKeys.sar_per_kg.tr()),
                              style: TextStyle(
                                  color: CustomColors().primaryGreenColor,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      padding: EdgeInsets.only(right: 5, left: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            child: InkWell(

                                onTap:isAddToFavBtnEnabled == true ? favPressed : null,
                                child: isFavourite! == true
                                    ? Icon(
                                        Icons.favorite,
                                        color: CustomColors().redColor,
                                      )
                                    : Icon(
                                        Icons.favorite,
                                        color: CustomColors().grayColor,
                                      )),
                          ),
                          //Counter

                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.23,
                            height: MediaQuery.of(context).size.height * 0.05,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: CustomColors().primaryGreenColor,
                            ),
                            child:addToCartBtnContainer(
                            context, isDeleted: isDeleted,
                              isAvailable :isAvailable,counter: counter,
                              onBtnClicked: () {
                              /* if (isAddToCartBtnEnabled) {
                                  setState(() {
                                    counter++;
                                  });
                                  addToCart(productId!);
                                }*/
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 2,
                color: CustomColors().grayColor,
              )
            ],
          ),
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductDetails(
                        productModel: productModel,
                        language: language,
                      )));
        });
  }




  ///------------------------------------------
  ///---------------DB process-----------------
  ///------------------------------------------

 /* //----------------
  void deleteFromCart(BuildContext context,String productId ,int counter) async {
    print('counter $counter');
    isTrashBtnEnabled = false;
    String message = await cartDBProcess(context,productId,counter,deleteFromCartConst,isTrashBtnEnabled);
    showSuccessMessage(context, message);
    //total = 0;

    // Navigator.pop(context);
  }
  //----------------

  void addToCart(BuildContext context,String productId ,int counter) async {
    if(isAddToCartBtnEnabled) {
      counter++;
      print('counter $counter');
      isAddToCartBtnEnabled = false;
      String message = await cartDBProcess(
          context, productId, counter, addToCartConst, isAddToCartBtnEnabled);
      showSuccessMessage(context, message);
    }
    // Navigator.pop(context);
  }

  //---------------------
  void addQtyToCart(BuildContext context,String productId ,int counter) async {
    isIncreaseBtnEnabled = false;
    String message = await cartDBProcess(context,productId,counter,addQtyToCartConst,isIncreaseBtnEnabled);
    showSuccessMessage(context, message);
    // total = total + ();

    // total = price * counter;

    //  Navigator.pop(context);
  }

  //---------------------
  void deleteQtyFromCart(BuildContext context,String productId ,int counter) async {
    isDecreaseBtnEnabled = false;
    String message = await cartDBProcess(context,productId,counter,deleteFromCartConst,isDecreaseBtnEnabled);
    showSuccessMessage(context, message);
    // total = 0;

    //  total = total - price;

    //  Navigator.pop(context);
  }*/

  static void addToFav(
      BuildContext context, bool? isFavourite, String productId) async {
    isAddToFavBtnEnabled = false;
    String message = await dBProcess(context, isFavourite, productId);
    showSuccessMessage(context, message);
  }

  static Future<String> dBProcess(
      BuildContext context, bool? isFavourite, String productId) async {
    showLoaderDialog(context);
    //----------start api ----------------

    Map<String, dynamic> headerMap = await getHeaderMap();

    ProductRepository productRepository = ProductRepository(headerMap);
    ApiResponse apiResponse;
    if (isFavourite == false) {
      apiResponse = await productRepository.addProductToFav(productId);
    } else {
      apiResponse = await productRepository.deleteProductFromFav(productId);
    }
    if (apiResponse.apiStatus.code == ApiResponseType.OK.code) {
      MessageResponseModel model =
          MessageResponseModel.fromJson(apiResponse.result);
      Navigator.pop(context);
      isAddToFavBtnEnabled = true;
      return model.message!;
    } else {
      Navigator.pop(context);
      isAddToFavBtnEnabled = true;
      throw ExceptionHelper(apiResponse.message);
    }
  }
}

