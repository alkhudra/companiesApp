import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khudrah_companies/Constant/api_const.dart';
import 'package:khudrah_companies/Constant/conts.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/designs/appbar_design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:khudrah_companies/helpers/cart_helper.dart';
import 'package:khudrah_companies/helpers/custom_btn.dart';
import 'package:khudrah_companies/helpers/number_helper.dart';
import 'package:khudrah_companies/helpers/order_helper.dart';
import 'package:khudrah_companies/network/models/branches/branch_model.dart';
import 'package:khudrah_companies/network/models/cart/user_cart.dart';
import 'package:khudrah_companies/pages/checkout/checkout_page.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'package:myfatoorah_flutter/embeddedpayment/MFPaymentCardView.dart';
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

import '../order_completed_page.dart';

class PaymentPage extends StatefulWidget {
  final UserCart? userCart;
  final String language;
  final BranchModel branchModel;
  const PaymentPage(
      {Key? key,
      required this.userCart,
      required this.language,
      required this.branchModel})
      : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool condition = true;
  final String mAPIKey = ApiConst.payment_token;

  MFPaymentCardView mfPaymentCardView = MFPaymentCardView(
    inputColor: CustomColors().primaryGreenColor,
    //  labelColor: CustomColors().primaryGreenColor,
//      errorColor: Colors.blue,
    borderColor: CustomColors().primaryGreenColor,
//      fontSize: 14,
    borderWidth: 1,
    borderRadius: 10,
//      cardHeight: 220,
    cardHolderNameHint: "card holder name hint",
    cardNumberHint: "card number hint",
    expiryDateHint: "expiry date hint",
    cvvHint: "cvv hint",
    showLabels: true,
//
//cardHolderNameLabel: "card holder name label",
//      cardNumberLabel: "card number label",
//      expiryDateLabel: "expiry date label",
//      cvvLabel: "cvv label",
  );

  String _loading = "Loading...";
  var sessionIdValue = "";
  String _response = '';

  @override
  Widget build(BuildContext context) {
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
      body: SlidingUpPanel(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        panel: Container(
          height: scHeight * 0.16,
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
              Divider(
                thickness: 1,
                indent: 25,
                endIndent: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //total
                  cartTotalDesign(total),
                  //checkout button
                  Container(
                    child: greenBtn(LocaleKeys.continue_payment.tr(),
                        EdgeInsets.symmetric(vertical: 4), () {}),
                  ),
                ],
              ),
            ],
          ),
        ),
        body:
        createPaymentCardView()
    ,
        //slide up panel height
        minHeight: scHeight * 0.07,
        maxHeight: hasDiscount ? scHeight * 0.39 : 235,
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
    // TODO, don't forget to init the MyFatoorah Plugin with the following line
    MFSDK.init(mAPIKey, MFCountry.SAUDI_ARABIA, MFEnvironment.LIVE);
    // (Optional) un comment the following lines if you want to set up properties of AppBar.
    initiatePayment(widget.userCart!.totalNetCartPrice!.toString());
    initiateSession();
  }

  void payWithEmbeddedPayment() {
    var request = MFExecutePaymentRequest.constructor(0.100);
    mfPaymentCardView.pay(
        request,
        widget.language == 'ar' ? MFAPILanguage.AR : MFAPILanguage.EN,
        (String invoiceId, MFResult<MFPaymentStatusResponse> result) => {
              if (result.isSuccess())
                {
                  setState(() {
                    print("invoiceId: " + invoiceId);
                    print("Response: " + result.response!.toJson().toString());
                    _response = result.response!.toJson().toString();
                    // continue order ( api , show success page)

                    OrderHelper.callApi(context, widget.userCart!,
                        widget.branchModel, true, visa);
                  })
                }
              else
                {
                  setState(() {
                    print("invoiceId: " + invoiceId);
                    print("Error: " + result.error!.toJson().toString());
                    _response = result.error!.message!;

                    OrderHelper. viewCompleteOrderPage(context , false);

                    // continue order (  show fail page)
                  })
                }
            });

    setState(() {
      _response = _loading;
    });
  }
  //------------------------

  void initiatePayment(String amount) {
    var request = new MFInitiatePaymentRequest(
        double.parse(amount), MFCurrencyISO.SAUDI_ARABIA_SAR);

    MFSDK.initiatePayment(
        request,
        widget.language == 'ar' ? MFAPILanguage.AR : MFAPILanguage.EN,
        (MFResult<MFInitiatePaymentResponse> result) => {
              if (result.isSuccess())
                {
                  setState(() {
                    print(result.response!.toJson());
                    _response = ""; //result.response.toJson().toString();
                    /*      paymentMethods.addAll(result.response.paymentMethods);
                for (int i = 0; i < paymentMethods.length; i++)
                  isSelected.add(false);*/
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
  }
  //------------------------

  createPaymentCardView() {
    return mfPaymentCardView;
  }
}
