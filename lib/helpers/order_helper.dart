import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khudrah_companies/Constant/api_const.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/dialogs/message_dialog.dart';
import 'package:khudrah_companies/dialogs/progress_dialog.dart';
import 'package:khudrah_companies/helpers/contact_helper.dart';
import 'package:khudrah_companies/helpers/route_helper.dart';
import 'package:khudrah_companies/network/API/api_response.dart';
import 'package:khudrah_companies/network/API/api_response_type.dart';
import 'package:khudrah_companies/network/helper/exception_helper.dart';
import 'package:khudrah_companies/network/helper/network_helper.dart';
import 'package:khudrah_companies/network/models/branches/branch_model.dart';
import 'package:khudrah_companies/network/models/cart/success_cart_response_model.dart';
import 'package:khudrah_companies/network/models/cart/user_cart.dart';
import 'package:khudrah_companies/network/models/orders/order_items.dart';
import 'package:khudrah_companies/network/models/orders/submit_order_success_response_model.dart';
import 'package:khudrah_companies/network/repository/order_repository.dart';
import 'package:khudrah_companies/pages/order_completed_page.dart';
import 'package:khudrah_companies/provider/order_provider.dart';
import 'package:khudrah_companies/router/route_constants.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
class OrderHelper {
  static callApi(BuildContext context, UserCart userCart,
      BranchModel selectedBranch, bool hasPaid, String paymentMethod) async {
    //----------show progress----------------
    showLoaderDialog(context);
    //----------start api ----------------
    Map<String, dynamic> headerMap = await getHeaderMap();
    ApiResponse apiResponse;
    OrderRepository orderRepository = OrderRepository(headerMap);

    List<SubmitOrderItems> orderItemsList = [];
    for (CartProductsList cartItems in userCart.cartProductsList!) {
      orderItemsList.add(SubmitOrderItems(
          productId: cartItems.productModel?.productId!,
          userProductQuantity: cartItems.userProductQuantity,
          totalNetProductPrice: cartItems.totalNetProductPrice,
          totalProductPrice: cartItems.totalProductPrice,
          totalProductVAT15: cartItems.totalProductVAT15,
          orderedProductPrice: cartItems.productModel?.hasSpecialPrice == true
              ? cartItems.productModel?.specialPrice
              : cartItems.productModel?.originalPrice,
          orderedNetProductPrice :cartItems.productModel?.hasSpecialPrice == true
              ? cartItems.productModel?.netSpecialPrice
              : cartItems.productModel?.netPrice, ));

    }

    apiResponse = await orderRepository.submitOrder(
        paymentType: paymentMethod,
        hasPaid: hasPaid,
        branchId: selectedBranch.id,
        companyId: selectedBranch.companyId,
        totalOrderPrice: userCart.totalCartPrice,
        totalNetOrderPrice: userCart.totalNetCartPrice,
        totalOrderVAT15: userCart.totalCartVAT15,
        hasDiscount: userCart.hasDiscount,
        discountPercentage: userCart.discountPercentage,
        totalDiscount: userCart.totalDiscount,
        orderItem: orderItemsList);

    if (apiResponse.apiStatus.code == ApiResponseType.OK.code) {

      if(apiResponse.result["orderAccepted"] != null){
        if(apiResponse.result["orderAccepted"]  == false)
          {
            Navigator.pop(context);

            OrderHelper. viewCompleteOrderPage(context , false);

            return;
          }
      }
      SubmitOrderSuccessResponseModel model =
          SubmitOrderSuccessResponseModel.fromJson(apiResponse.result);
      print('result after complete order  ### : ' + model.toString());
      Navigator.pop(context);

    //  Provider.of<OrderProvider>(context, listen: true).addOrderToList(model.orderHeader!);
      OrderHelper. viewCompleteOrderPage(context , true ,model: model);

    } else if(apiResponse.apiStatus.code == ApiResponseType.BadRequest.code) {
      // Company did not pay before the deadline
      Navigator.pop(context);


      print('error in order #### : '+ apiResponse.message);
      showDialog<String>(
          context: context,
          builder: (BuildContext context) =>
              showMessageDialog(context, LocaleKeys.error.tr(),  LocaleKeys.error_in_order.tr(), noPage));


    }else{
      Navigator.pop(context);
      //return apiResponse.message;
      OrderHelper. viewCompleteOrderPage(context , false);

      throw ExceptionHelper(apiResponse.message);
    }



  }

  static displayInvoice(url, isFromDashBoard) {
    if (isFromDashBoard == true)
      openURL(ApiConst.dashboard_url + url);
    else
      openURL(ApiConst.pdf_url +url);
  }


  static viewCompleteOrderPage(context , isSuccess,{model}){

    moveToNewStackWithArgs(context ,MaterialPageRoute(builder: (context) {
      return OrderCompletedPage(isSuccess: isSuccess,model: model);
    } ));

  }


}
