import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khudrah_companies/Constant/conts.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/dialogs/progress_dialog.dart';
import 'package:khudrah_companies/helpers/custom_btn.dart';
import 'package:khudrah_companies/helpers/snack_message.dart';
import 'package:khudrah_companies/network/API/api_response.dart';
import 'package:khudrah_companies/network/API/api_response_type.dart';
import 'package:khudrah_companies/network/helper/exception_helper.dart';
import 'package:khudrah_companies/network/helper/network_helper.dart';
import 'package:khudrah_companies/network/models/message_response_model.dart';
import 'package:khudrah_companies/network/models/product/product_model.dart';
import 'package:khudrah_companies/network/repository/cart_repository.dart';
import 'package:khudrah_companies/provider/product_provider.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

class AddToCartWidget extends StatelessWidget {
  final ProductsModel productModel;

  AddToCartWidget({required this.productModel});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context, listen: true);
    Size size = MediaQuery.of(context).size;
    double scWidth = size.width;
    double scHeight = size.height;

    bool _isAddToCartBtnEnabled = true,
        _isTrashBtnEnabled = true,
        _isIncreaseBtnEnabled = true,
        _isDecreaseBtnEnabled = true;
    return Container(
        margin: EdgeInsets.only(top: 10),
        child: productModel.isDeleted == false &&
                productModel.isAvailabe == true
            //show add to cart options
            ? productProvider.isItemInCartList(productModel) == false &&
                    productProvider.getQtyOfItem(productModel) ==
                        0 //productModel.isAddedToCart == false &&  productModel.userProductQuantity ==  0
                //show cart button
                ? cartBtn(
                    Icons.shopping_cart,
                    // LocaleKeys.add_cart.tr(),
                    EdgeInsets.symmetric(horizontal: 5), () {
                    if (_isAddToCartBtnEnabled) {
                      _isAddToCartBtnEnabled = false;
                      cartDBProcess(
                              context, productModel.productId!, addToCartConst)
                          .then((value) {
                        if (value) {
                          _isAddToCartBtnEnabled = true;
                          productProvider.addCartItemToCartList(productModel);
                        } else
                          _isAddToCartBtnEnabled = true;
                      });
                    }
                  })
                //show counter
                : Container(
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
                        productProvider.getQtyOfItem(productModel) == 1
                            ? GestureDetector(
                                onTap: () {
                                  if (_isTrashBtnEnabled) {
                                    _isTrashBtnEnabled = false;
                                    cartDBProcess(
                                            context,
                                            productModel.productId!,
                                            deleteFromCartConst)
                                        .then((value) {
                                      if (value) {
                                        _isTrashBtnEnabled = true;

                                        productProvider.removeItemFromCartList(
                                            productModel);
                                      } else
                                        _isTrashBtnEnabled = true;
                                    });
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.all(4),
                                  child: Icon(
                                    Icons.delete_outline_outlined,
                                    color: CustomColors().primaryGreenColor,
                                  ),
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  if (_isDecreaseBtnEnabled) {
                                    _isDecreaseBtnEnabled = false;
                                    cartDBProcess(
                                            context,
                                            productModel.productId!,
                                            deleteQtyFromCartConst)
                                        .then((value) {
                                      if (value) {
                                        _isDecreaseBtnEnabled = true;

                                        productProvider
                                            .decreaseQtyOfItem(productModel);
                                      } else
                                        _isDecreaseBtnEnabled = true;
                                    });
                                  }
                                },
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
                            productProvider
                                .getQtyOfItem(productModel)
                                .toString(),
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
                          onTap: () {
                            if (_isIncreaseBtnEnabled) {
                              _isIncreaseBtnEnabled = false;
                              cartDBProcess(context, productModel.productId!,
                                      addQtyToCartConst)
                                  .then((value) {
                                if (value) {
                                  _isIncreaseBtnEnabled = true;
                                  productProvider
                                      .increaseQtyOfItem(productModel);
                                } else
                                  _isIncreaseBtnEnabled = true;
                              });
                            }
                          },
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
                  )
            //show product unavailable
            : unAvailableBtn(
                LocaleKeys.not_available_product.tr(),
                EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                MediaQuery.of(context).size.height * 0.04,
                11.6));
  }

/////////////////////////////
/////// cart process ////////
////////////////////////////

  Future<bool> cartDBProcess(
      BuildContext context, String productId, String process) async {
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
      showSuccessMessage(context, model.message!);

      Navigator.pop(context);

      return true;
    } else {
      Navigator.pop(context);
      throw ExceptionHelper(apiResponse.message);
    }
  }
}
