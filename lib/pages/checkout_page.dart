import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/designs/appbar_design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:khudrah_companies/helpers/custom_btn.dart';
import 'package:myfatoorah_flutter/embeddedpayment/MFPaymentCardView.dart';
import 'package:myfatoorah_flutter/model/executepayment/MFExecutePaymentRequest.dart';
import 'package:myfatoorah_flutter/model/initsession/SDKInitSessionResponse.dart';
import 'package:myfatoorah_flutter/model/paymentstatus/SDKPaymentStatusResponse.dart';
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';
import 'package:myfatoorah_flutter/utils/MFAPILanguage.dart';
import 'package:myfatoorah_flutter/utils/MFCountry.dart';
import 'package:myfatoorah_flutter/utils/MFEnvironment.dart';
import 'package:myfatoorah_flutter/utils/MFResult.dart';
class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String _response = '';
  final String mAPIKey = 'F96WjHY0jaqWAgvtK2bcaCahmPneBWA0ANaSp0EZNgF7T5Lw0o1PkZ4pnCAry153gBO-ggXS0HvcfR_pdcTh9JTKOsfVqK4kaRR3Or_EHZO2BRwTQj1fTulwV2LEUfzO1-Kw3DXJrqygW9gMwqX7uVrnyCWrZUxILLtaP22e7ubN5UWCU3lIBRYtDErTQ507gg-c3Zs406NdVNlZ-FWjSYAb8voL7p8eW2UpT8Fy-qGH4EaXgIR35QRhv_uX0pZJHqkoCGO7RV5mf8IJvsr3WlKRkEhEHcO5wY_kQ5OzODUEcL6vFG-SaPEeYAgqTsUDe6vWJCCflwLrGW-tqoyODye1N1Bc-cm2lB3zynJI43z321ehbUqwYw1LPXOPA7weE8cafRBQyn8FRtkqeLaWqQqVCrpGPnAfUQS1EfvLLOMeakS1lp9K4VBDueuD_laY0IoynXB8QzGiID1DSV5spvFUknJKnoeWvdTplGgW48R9qrHeapAA0rFUWMsG46xN-GiLcwqG5-hVFR3zECclct3J_2TikDoeI2HZXUF1ALov4SHJHZlfsJoxjoCv0BftO1HHoiyLsercA93iqihvYiW1Wls4CjOdhPJgHmSTHsU2FQC4w0Sqc1CQqjMhKjsOr9GAH7PeCsl02ZR63fpEh727mHsmO0fuFyEfmvnvzrmkd0aGaxSiAKZsMZuEkIBaefeQGQ';

  String _loading = "Loading...";
  var sessionIdValue = "";
  MFPaymentCardView     mfPaymentCardView = MFPaymentCardView(
  /*  inputColor: Colors.red,
    labelColor: Colors.yellow,
    errorColor: Colors.blue,
    borderColor: Colors.green,
    fontSize: 14,
    borderWidth: 1,
    borderRadius: 10,
    cardHeight: 220,
    cardHolderNameHint: "card holder name hint",
    cardNumberHint: "card number hint",
    expiryDateHint: "expiry date hint",
    cvvHint: "cvv hint",
    showLabels: true,
    cardHolderNameLabel: "card holder name label",
    cardNumberLabel: "card number label",
    expiryDateLabel: "expiry date label",
    cvvLabel: "cvv label",*/
  );

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: bnbAppBar(context, LocaleKeys.cart.tr()),
      body:  Column(
        children: [
          greenBtn('online pay', EdgeInsets.all(10), (){

            payWithEmbeddedPayment();
          })
        ],
      ),
    );
  }
  void payWithEmbeddedPayment() {

    var request = MFExecutePaymentRequest.constructor(0.100);
    mfPaymentCardView.pay(
        request,
        MFAPILanguage.EN,
            (String invoiceId, MFResult<MFPaymentStatusResponse> result) => {
          if (result.isSuccess())
            {
              setState(() {
                print("invoiceId: " + invoiceId);
                print("Response: " + result.response!.toJson().toString());
                _response = result.response!.toJson().toString();
              })
            }
          else
            {
              setState(() {
                print("invoiceId: " + invoiceId);
                print("Error: " + result.error!.toJson().toString());
                _response = result.error!.message!;
              })
            }
        });
  }

  @override
  void initState() {
    super.initState();

    if (mAPIKey.isEmpty) {
      setState(() {
        _response =
        "Missing API Token Key.. You can get it from here: https://myfatoorah.readme.io/docs/test-token";
      });
      return;
    }
    MFSDK.init(mAPIKey, MFCountry.SAUDI_ARABIA, MFEnvironment.TEST);
    initiateSession();
   // MFSDK.setUpAppBar(isShowAppBar: false);
  }

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
}
