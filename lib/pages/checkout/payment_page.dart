import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khudrah_companies/Constant/api_const.dart';
import 'package:khudrah_companies/Constant/conts.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/designs/appbar_design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:khudrah_companies/dialogs/message_dialog.dart';
import 'package:khudrah_companies/helpers/cart_helper.dart';
import 'package:khudrah_companies/helpers/custom_btn.dart';
import 'package:khudrah_companies/helpers/number_helper.dart';
import 'package:khudrah_companies/helpers/order_helper.dart';
import 'package:khudrah_companies/network/models/branches/branch_model.dart';
import 'package:khudrah_companies/network/models/cart/user_cart.dart';
import 'package:khudrah_companies/pages/checkout/checkout_page.dart';
import 'package:khudrah_companies/provider/genral_provider.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'package:myfatoorah_flutter/embeddedpayment/MFPaymentCardView.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:myfatoorah_flutter/embeddedpayment/MFPaymentCardView.dart';
import 'package:myfatoorah_flutter/model/executepayment/MFExecutePaymentRequest.dart';
import 'package:myfatoorah_flutter/model/initsession/SDKInitSessionResponse.dart';
import 'package:myfatoorah_flutter/model/paymentstatus/SDKPaymentStatusResponse.dart';
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';
import 'package:myfatoorah_flutter/utils/MFAPILanguage.dart';
import 'package:myfatoorah_flutter/utils/MFCountry.dart';
import 'package:myfatoorah_flutter/utils/MFEnvironment.dart';
import 'package:myfatoorah_flutter/utils/MFResult.dart';

import '../../designs/order_tile_design.dart';
import '../order_completed_page.dart';

class PaymentPage extends StatefulWidget {
  final UserCart? userCart;

  final BranchModel branchModel;
  const PaymentPage(
      {Key? key, required this.userCart, required this.branchModel})
      : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final String mAPIKey = ApiConst.payment_token;

  List<PaymentMethods> paymentMethods = [];
  List<bool> isSelected = [];
  int selectedPaymentMethodIndex = -1;
  String _loading = "Loading...";
  var sessionIdValue = "";
  String _response = '';
  bool hasPaid = false;
  String language = '';
  @override
  Widget build(BuildContext context) {
    language = Provider.of<GeneralProvider>(context, listen: false)
        .userSelectedLanguage;

    num priceAfterDiscount = widget.userCart!.totalDiscount!;
    num subtotal = widget.userCart!.totalCartPrice!;
    num vat = widget.userCart!.totalCartVAT15!;
    num total = widget.userCart!.totalNetCartPrice!;
    num discount = widget.userCart!.discountPercentage! * 100;
    bool? hasDiscount = widget.userCart!.hasDiscount;
    Size size = MediaQuery.of(context).size;
    double scWidth = size.width;
    double scHeight = size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBarDesign(context, LocaleKeys.checkout.tr()),
      body: SingleChildScrollView(
        child: Column(children: [
          titleTextDesign(LocaleKeys.select_online_payment.tr()),
          paymentMethods.length != 0
              ? Container(
                  height: 200,
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        /* crossAxisSpacing: 0.0,
                      mainAxisSpacing: 0.0,
                  childAspectRatio: 10/10.5*/
                      ),
                      itemCount: paymentMethods.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Image.network(paymentMethods[index].imageUrl!,
                                  width: 60.0, height: 60.0),
                              Checkbox(
                                  value: isSelected[index],
                                  onChanged: (bool? value) {
                                    setState(() {
                                      setPaymentMethodSelected(index, value!);
                                    });
                                  })
                            ],
                          ),
                        );
                      }),
                )
              : CircularProgressIndicator(),
          Divider(),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  titleTextDesign(LocaleKeys.order_details.tr()),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  cartDetailsItem(
                      LocaleKeys.subtotal.tr(), getTextWithCurrency(subtotal)),
                  cartDetailsItem(
                      LocaleKeys.vat.tr(), getTextWithCurrency(vat)),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30, vertical: 2),
                    child: Text(
                      LocaleKeys.vat_inc.tr(),
                      style: TextStyle(
                          color: CustomColors().darkBlueColor, fontSize: 14.5),
                    ),
                  ),
                  if (hasDiscount!)
                    Column(
                      children: [
                        cartDetailsItem(LocaleKeys.discount_percentage.tr(),
                            getTextWithPercentage(discount)),
                        cartDetailsItem(LocaleKeys.discount.tr(),
                            getTextWithCurrency(priceAfterDiscount)),
                      ],
                    )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //total
                  cartTotalDesign(total),
                  //checkout button
                  Container(
                    child: greenBtn(LocaleKeys.continue_payment.tr(),
                        EdgeInsets.symmetric(vertical: 4), pay),
                  ),
                ],
              ),
            ],
          ),
        ]),
      ),
    );
  }

  ///********
  ///
  ///payment methods
  ///
  ///********
  @override
  void initState() {
    super.initState();
    MFSDK.init(mAPIKey, MFCountry.SAUDI_ARABIA, MFEnvironment.LIVE);
    // (Optional) un comment the following lines if you want to set up properties of AppBar.
    initiatePayment(widget.userCart!.totalNetCartPrice!.toString());
    //initiateSession();
  }

  //------------------------

  void initiatePayment(String amount) {
    var request = new MFInitiatePaymentRequest(
        double.parse(amount), MFCurrencyISO.SAUDI_ARABIA_SAR);

    MFSDK.initiatePayment(
        request,
        displayLanguage(language),
        (MFResult<MFInitiatePaymentResponse> result) => {
              if (result.isSuccess())
                {
                  setState(() {
                    print(result.response!.toJson());
                    _response = result.response!.toJson().toString();
                    paymentMethods.addAll(result.response!.paymentMethods!);

                    for (int i = 0; i < paymentMethods.length; i++) {
                      if (Platform.isAndroid &&
                          paymentMethods[i].paymentMethodId == 13) {
                        paymentMethods.removeAt(i);
                      }
                      isSelected.add(false);
                    }
                  })
                }
              else
                {
                  setState(() {
                    print(result.error!.toJson());
                    _response = result.error!.message!;
                  })
                }
            });

    setState(() {
      _response = _loading;
    });
  }
  //------------------------
/*
  void initiateSession() {
    MFSDK.initiateSession((MFResult<MFInitiateSessionResponse> result) => {
          if (result.isSuccess())
            {mfPaymentCardView.load(result.response!)}
          else
            {
              setState(() {
                print("Response: " +
                    result.error!.toJson().toString().toString());
                _response = result.error!.message!;
              })
            }
        });
  }*/
  //------------------------

/*  createPaymentCardView() {
    return mfPaymentCardView;
  }*/
  //------------------------

  void pay() {
    if (selectedPaymentMethodIndex == -1) {
      showErrorMessageDialog(context, "Please select payment method first");
    } else {
      executeRegularPayment(
          paymentMethods[selectedPaymentMethodIndex].paymentMethodId!);
    }
  }

  void executeRegularPayment(int paymentMethodId) {
    var request = new MFExecutePaymentRequest(paymentMethodId,
        double.parse(widget.userCart!.totalNetCartPrice!.toString()));

    // For recurring
    // request?.recurringModel = RecurringModel(MFRecurringType.monthly, iteration: 5);

    MFSDK.executePayment(
        context,
        request,
        displayLanguage(language),
        (String invoiceId, MFResult<MFPaymentStatusResponse> result) => {
              if (result.isSuccess())
                {
                  setState(() {
                    print(invoiceId);
                    print(result.response!.toJson());
                    _response = result.response!.toJson().toString();

                    setState(() {
                      hasPaid = true;

                      OrderHelper.callApi(context, widget.userCart!,
                          widget.branchModel, hasPaid, visa);
                    });
                  })
                }
              else
                {
                  setState(() {
                    print(invoiceId);
                    print(result.error!.toJson());
                    _response = result.error!.message!;
                    OrderHelper.viewCompleteOrderPage(context, false);
                  })
                }
            });

    setState(() {
      _response = _loading;
    });
  }

  static displayLanguage(lan) {
    return lan == 'ar' ? MFAPILanguage.AR : MFAPILanguage.EN;
  }

  void setPaymentMethodSelected(int index, bool value) {
    for (int i = 0; i < isSelected.length; i++) {
      if (i == index) {
        isSelected[i] = value;
        if (value) {
          selectedPaymentMethodIndex = index;
          //   visibilityObs = paymentMethods[index].isDirectPayment;
        } else {
          selectedPaymentMethodIndex = -1;
          //  visibilityObs = false;
        }
      } else
        isSelected[i] = false;
    }
  }
}
