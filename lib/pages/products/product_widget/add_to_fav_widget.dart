import 'package:flutter/material.dart';
import 'package:khudrah_companies/helpers/snack_message.dart';
import 'package:khudrah_companies/network/API/api_response.dart';
import 'package:khudrah_companies/network/API/api_response_type.dart';
import 'package:khudrah_companies/network/helper/exception_helper.dart';
import 'package:khudrah_companies/network/helper/network_helper.dart';
import 'package:khudrah_companies/network/models/message_response_model.dart';
import 'package:khudrah_companies/network/models/product/product_model.dart';
import 'package:khudrah_companies/network/repository/product_repository.dart';
import 'package:khudrah_companies/provider/product_provider.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'package:provider/provider.dart';

class AddToFavWidget extends StatelessWidget {
  final ProductsModel productModel;

  AddToFavWidget({required this.productModel});

  @override
  Widget build(BuildContext context) {
    bool _isAddToFavBtnEnabled = true;

    final productProvider = Provider.of<ProductProvider>(context, listen: true);
    return Container(
      padding: EdgeInsets.all(10),
      child: InkWell(
          onTap: () {
            if (_isAddToFavBtnEnabled) {
              _isAddToFavBtnEnabled = true;
              bool? _isItemFavourite =
                  productProvider.isItemInFavList(productModel);

              favoriteDBProcess(
                      context, _isItemFavourite, productModel.productId!)
                  .then((value) {
                if (value) {
                  _isAddToFavBtnEnabled = true;
                  if (_isItemFavourite == true)
                    productProvider.removeFavItemFromFavList(productModel);
                  else
                    productProvider.addFavItemToFavList(productModel);
                } else
                  _isAddToFavBtnEnabled = true;
              });
            }
          },
          child: productProvider.isItemInFavList(
                  productModel) //productModel.isFavourite! == true
              ? Icon(
                  Icons.favorite,
                  color: CustomColors().redColor,
                )
              : Icon(
                  Icons.favorite,
                  color: CustomColors().grayColor,
                )),
    );
  }

  /////////////////////////////
  /////// fav process ////////
  ////////////////////////////

 static Future<bool> favoriteDBProcess(
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
      showSuccessMessage(context, model.message!);

      return true;
    } else {
      throw ExceptionHelper(apiResponse.message);
    }
  }
}
