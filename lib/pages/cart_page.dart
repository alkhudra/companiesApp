import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:khudrah_companies/Constant/api_const.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/designs/appbar_design.dart';
import 'package:khudrah_companies/helpers/cart_helper.dart';
import 'package:khudrah_companies/designs/drawar_design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:khudrah_companies/designs/no_item_design.dart';
import 'package:khudrah_companies/dialogs/message_dialog.dart';
import 'package:khudrah_companies/dialogs/progress_dialog.dart';
import 'package:khudrah_companies/helpers/custom_btn.dart';
import 'package:khudrah_companies/helpers/pref/shared_pref_helper.dart';
import 'package:khudrah_companies/helpers/snack_message.dart';
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
import 'package:lottie/lottie.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  static String language = 'ar';
  bool isTrashBtnEnabled = true;
  static String productId = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //add body
      body: FutureBuilder<SuccessCartResponseModel?>(
        future: getListData(),
        builder: (context, snapshot) {
          print(snapshot.toString());
          if (snapshot.hasData) {
            print(snapshot.hasData);
            print(snapshot.data);
            return listDesign(context, snapshot.data!);
          } else {
            return errorCase(snapshot);
          }
        },
      ),
      appBar: bnbAppBar(context, LocaleKeys.cart.tr()),
    );
  }

  //-----------------------

  Future<SuccessCartResponseModel> getListData() async {
    Map<String, dynamic> headerMap = await getHeaderMap();

    CartRepository cartRepository = CartRepository(headerMap);

    ApiResponse apiResponse = await cartRepository.getCart();

    if (apiResponse.apiStatus.code == ApiResponseType.OK.code) {
      SuccessCartResponseModel? responseModel =
          SuccessCartResponseModel.fromJson(apiResponse.result);

      return responseModel;
    } else {
      throw ExceptionHelper(apiResponse.message);
    }
  }
  //-----------------------

  Widget listDesign(BuildContext context, SuccessCartResponseModel? model) {
    if(model!.userCart != null){
      num price = model.userCart!.totalCartPrice!;
      double subtotal = 3;
      double vat = 5;
      num total = model.userCart!.hasDiscount! == true
          ? model.userCart!.priceAfterDiscount!
          : model.userCart!.totalCartPrice!;
      double price_vat = 27.2;
      double discount = 20;

      return SlidingUpPanel(
        body: ListView.builder(
          itemBuilder: (context, index) {
            return /*Slidable(
              endActionPane: ActionPane(
                key: const ValueKey(0),
                motion: const BehindMotion(),
                dismissible: DismissiblePane(onDismissed: () {}),
                children: [
                  SlidableAction(
                    onPressed: deleteFromCart,
                    backgroundColor: CustomColors().redColor,
                    // foregroundColor: CustomColors().primaryWhiteColor,
                    icon: Icons.delete,
                    label: LocaleKeys.delete_from_cart.tr(),
                  )

                ],
              ),
              child: */
              cartTile(context ,language,model.userCart!.cartProductsList!, index);
          },
          itemCount: model.userCart!.cartProductsList!.length,
        ),
        minHeight: 60,
        maxHeight: 270,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        panel: Container(
          //Change height to be adaptable
          height: MediaQuery.of(context).size.height * 0.16,
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
                  cartDetailsItem(LocaleKeys.subtotal.tr() , getTextWithCurrency(subtotal)),
                  cartDetailsItem(LocaleKeys.vat.tr() ,  getTextWithCurrency(vat)),
                  cartDetailsItem( LocaleKeys.discount_percentage.tr(), getTextWithPercentage(discount)),
                  cartDetailsItem(LocaleKeys.discount.tr() ,  getTextWithCurrency(price_vat)),


                ],
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 1,
                indent: 25,
                endIndent: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //total
                  cartTotalDesign(total)
                ,
                  //checkout button
                  Container(
                    child: greenBtn(LocaleKeys.checkout.tr(),
                        EdgeInsets.symmetric(vertical: 4), () {}),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }else{
     return noItemDesign(LocaleKeys.no_items_in_cart.tr(), 'images/not_found.png');
    }

  }

  //--------


  //--------
  void deleteFromCart(BuildContext context, String? productId) async {
    if (isTrashBtnEnabled) {
      isTrashBtnEnabled = false;
      showLoaderDialog(context);
      //----------start api ----------------

      Map<String, dynamic> headerMap = await getHeaderMap();

      CartRepository cartRepository = CartRepository(headerMap);
      ApiResponse apiResponse;

      apiResponse = await cartRepository.deleteProductFromCart(productId!);

      if (apiResponse.apiStatus.code == ApiResponseType.OK.code) {
        MessageResponseModel model =
            MessageResponseModel.fromJson(apiResponse.result);
        Navigator.pop(context);
        isTrashBtnEnabled = true;

        showSuccessMessage(context, model.message!);
      } else {
        Navigator.pop(context);
        isTrashBtnEnabled = true;
        showErrorMessageDialog(context, apiResponse.message);
      }
    }
  }

  void setValue() async {
    language = await PreferencesHelper.getSelectedLanguage;
  }
}
