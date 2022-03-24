import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khudrah_companies/Constant/api_const.dart';
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
import 'package:khudrah_companies/router/route_constants.dart';

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
        totalDiscount: userCart.priceAfterDiscount,
        orderItem: orderItemsList);

    if (apiResponse.apiStatus.code == ApiResponseType.OK.code) {
      SubmitOrderSuccessResponseModel model =
          SubmitOrderSuccessResponseModel.fromJson(apiResponse.result);
      print(model.toString());
      Navigator.pop(context);
      OrderHelper. viewCompleteOrderPage(context , true ,model: model);

    } else {
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
