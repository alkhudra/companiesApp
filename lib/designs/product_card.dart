import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  static bool isAddToFavBtnEnabled = true,
      isTrashBtnEnabled = true,
      isAddToCartBtnEnabled = true,
      isIncreaseBtnEnabled = true,
      isDecreaseBtnEnabled = true;

  static productCardDesign(
    context,
    String language,
    ProductsModel productModel,
    Function() favPressed,
  {onAddBtnClicked , onIncreaseBtnClicked,onDecreaseBtnClicked,
    onDeleteBtnClicked}
    /*    {counter ,increaseCount, decreaseCount}*/
  ) {
    double? price = (productModel.hasSpecialPrice == true
            ? productModel.specialPrice
            : productModel.originalPrice)
        ?.toDouble();

    bool? isFavourite = productModel.isFavourite;

    String? name = language == 'ar' ? productModel.arName : productModel.name;
    num? stockQty = productModel.quantity!;
    int? qty = productModel.userProductQuantity;
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
                        image: productImage(productModel.image) ,
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
                            ("$price " + LocaleKeys.sar_per_kg.tr()),
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
                                onTap: isAddToFavBtnEnabled == true
                                    ? favPressed
                                    : null,
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
                            /* width: MediaQuery.of(context).size.width * 0.23,
                            height: MediaQuery.of(context).size.height * 0.05,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: CustomColors().primaryGreenColor,
                            ),*/
                            child: addToCartBtnContainer(
                              context,
                              productsModel:productModel,
                              userQty:  qty,
                              onBtnClicked: () {
                                if (isAddToCartBtnEnabled) {
                                  onAddBtnClicked();
                                }
                              },
                              onDecreaseBtnClicked: () {

                                  if (isDecreaseBtnEnabled) {
                                    onDecreaseBtnClicked();
                                  }

                              },
                              onDeleteBtnClicked: () {
                                if (isTrashBtnEnabled) {
                                 onDeleteBtnClicked();
                                }
                              },
                              onIncreaseBtnClicked: () {
                                if (isIncreaseBtnEnabled) {
                                  if (productModel.userProductQuantity! < stockQty) {
                                   onIncreaseBtnClicked();
                                  } else
                                    showSuccessMessage(
                                        context, LocaleKeys.no_stock.tr());
                                }
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
  static favoritesCard(    context,
      String language,
      ProductsModel productModel,
      Function() favPressed,
      {onAddBtnClicked , onIncreaseBtnClicked,onDecreaseBtnClicked,
        onDeleteBtnClicked}) {
    Size size = MediaQuery.of(context).size;
    double scWidth = size.width;
    double scHeight = size.height;

    double? price = (productModel.hasSpecialPrice == true
        ? productModel.specialPrice
        : productModel.originalPrice)
        ?.toDouble();

    String productId = productModel.productId!;

    String? name = language == 'ar' ? productModel.arName : productModel.name;
    num? stockQty = productModel.quantity!;
    int? qty = productModel.userProductQuantity;
    return GridTile(
      child: Container(
        decoration: BoxDecoration(
            color: CustomColors().primaryWhiteColor,
            // image: DecorationImage(
            //   image: AssetImage('images/green_fruit.png'),
            // ),
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                  color: CustomColors().darkGrayColor.withOpacity(0.4),
                  offset: Offset(2.0, 2.0),
                  blurRadius: 3.0,
                  spreadRadius: .8)
            ]),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProductDetails(
                      productModel: productModel,
                      language: language,
                    )));
          },
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  //Delete icon
                  Container(
                    margin: EdgeInsets.only(top: 10, left: 15, right: 15),
                    child: IconButton(
                      onPressed: () {
                        if (isAddToFavBtnEnabled) {
                        favPressed();

                        }
                      },
                      icon: Icon(
                        FontAwesomeIcons.trash,
                        color: CustomColors().redColor,
                        size: 20,
                      ),
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                    ),
                  ),
                ],
              ),
              //name and other details
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      width: scWidth*0.18,
                      height: scHeight*0.1,
                      decoration: BoxDecoration(
                        image: ProductCard.productImage(productModel.image) ,
                      )
                  ),
                  //name
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(vertical: 7),
                    child: Text(
                      name!,
                      style: TextStyle(
                        color: CustomColors().brownColor,
                        fontSize: 18.5,
                      ),
                    ),
                  ),
                  Container(
                    width: scWidth * 0.3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //price
                        Container(
                          child: Text(
                            '$price  ' + LocaleKeys.sar_per_kg.tr(),
                            style: TextStyle(
                                color: CustomColors().primaryGreenColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(height: scHeight*0.01,),
                  //Counter and cart icon row
                  Container(
                    /* width: MediaQuery.of(context).size.width * 0.23,
                            height: MediaQuery.of(context).size.height * 0.05,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: CustomColors().primaryGreenColor,
                            ),*/
                    child: addToCartBtnContainer(
                      context,
                      productsModel:productModel,
                      userQty:  qty,
                      onBtnClicked: () {
                        if (isAddToCartBtnEnabled) {
                         onAddBtnClicked();
                        }
                      },
                      onDecreaseBtnClicked: () {

                        if (isDecreaseBtnEnabled) {
                          onDecreaseBtnClicked();

                        }

                      },
                      onDeleteBtnClicked: () {
                        if (isTrashBtnEnabled) {
                          onDeleteBtnClicked();
                        }
                      },
                      onIncreaseBtnClicked: () {
                        if (isIncreaseBtnEnabled) {
                          if (productModel.userProductQuantity! < stockQty) {
                            onIncreaseBtnClicked();
                          } else
                            showSuccessMessage(
                                context, LocaleKeys.no_stock.tr());
                        }
                      },
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
  ///------------------------------------------
  ///---------------DB process-----------------
  ///------------------------------------------

  static void addToFav(
      BuildContext context, bool? isFavourite, String productId) async {
    isAddToFavBtnEnabled = false;
    String message = await dBProcess(context, isFavourite, productId);
    showSuccessMessage(context, message);
  }

  static Future<String> dBProcess(
      BuildContext context, bool? isFavourite, String productId) async {
   // showLoaderDialog(context);
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
     // Navigator.pop(context);
      isAddToFavBtnEnabled = true;
      return model.message!;
    } else {
   //   Navigator.pop(context);
      isAddToFavBtnEnabled = true;
      throw ExceptionHelper(apiResponse.message);
    }
  }

  //----------------
  static void deleteFromCart(
      BuildContext context , String productId) async {
    isTrashBtnEnabled = false;
    String message =
        await cartDBProcess(context, productId,  deleteFromCartConst);
    showSuccessMessage(context, message);

    isTrashBtnEnabled = true;
  }

  static void addToCart(
      BuildContext context , String productId) async {
    isAddToCartBtnEnabled = false;
    String message =
        await cartDBProcess(context, productId,  addToCartConst);
    showSuccessMessage(context, message);

    isAddToCartBtnEnabled = true;

    // Navigator.pop(context);
  }

  //---------------------
  static void addQtyToCart(
      BuildContext context  ,String productId) async {
    isIncreaseBtnEnabled = false;
    String message =
        await cartDBProcess(context, productId,  addQtyToCartConst);
//    showSuccessMessage(context, message);
    print(message);
    isIncreaseBtnEnabled = true;
  }

  //---------------------
  static void deleteQtyFromCart(
      BuildContext context , String productId) async {
    isDecreaseBtnEnabled = false;
    String message = await cartDBProcess(
        context, productId,  deleteQtyFromCartConst);
  //  showSuccessMessage(context, message);
    print(message);
    isDecreaseBtnEnabled = true;
  }

  static productImage(String? imageUrl) {
    return imageUrl != null?
         NetworkImage(ApiConst.images_url + imageUrl)
    :DecorationImage(image:AssetImage('images/green_fruit.png'));
       // : Image.asset('images/green_fruit.png');
  }

//---------------------

}
