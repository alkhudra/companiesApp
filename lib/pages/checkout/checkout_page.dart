import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khudrah_companies/Constant/api_const.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/designs/appbar_design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:khudrah_companies/designs/text_field_design.dart';
import 'package:khudrah_companies/dialogs/message_dialog.dart';
import 'package:khudrah_companies/helpers/custom_btn.dart';
import 'package:khudrah_companies/helpers/pref/shared_pref_helper.dart';
import 'package:khudrah_companies/network/models/branches/branch_model.dart';
import 'package:khudrah_companies/pages/checkout/payment_page.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
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
  final List<BranchModel>? branchList;

  const CheckoutPage({Key? key, required this.branchList}) : super(key: key);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String _response = '';
  final String mAPIKey = ApiConst.payment_token;
  static BranchModel selectedBranch = BranchModel();

  TextEditingController addressController = TextEditingController();

  String _loading = "Loading...";
  var sessionIdValue = "";

  static String address = '';
  MFPaymentCardView mfPaymentCardView = MFPaymentCardView(
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
  BranchModel dropdownValue =
      BranchModel(branchName: LocaleKeys.select_branch.tr(), address: '----');

  @override
  Widget build(BuildContext context) {
    //  List<BranchModel> branches = widget.branchList!;

    List<BranchModel> branches = [dropdownValue];
    for (BranchModel c in widget.branchList!) branches.add(c);
    Size size = MediaQuery.of(context).size;
    double scWidth = size.width;
    double scHeight = size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBarDesign(context, LocaleKeys.checkout.tr()),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              padding: const EdgeInsets.all(8.0),
              child: Text(
                LocaleKeys.select_branch_note.tr(),
                style: TextStyle(
                    fontSize: 15,
                    height: 1.5,
                    color: CustomColors().blackColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              width: scWidth / 1.15,
              height: scHeight / 15,
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 1, vertical: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: CustomColors().primaryGreenColor,
                    width: 1.5,
                  )),
              child: DropdownButtonHideUnderline(
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButtonFormField<BranchModel>(
                    value: dropdownValue,
                    decoration: InputDecoration.collapsed(hintText: ''),
                    // icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: TextStyle(color: CustomColors().darkGrayColor),
                    onChanged: (BranchModel? newValue) {
                      setState(() {
                        if (newValue != dropdownValue) {
                          print(selectedBranch.toString());
                          selectedBranch = newValue!;

                          addressController.text = selectedBranch.address! +
                              ', ' +
                              selectedBranch.streetName! +
                              ', ' +
                              selectedBranch.districtName! +
                              ', ' +
                              selectedBranch.nationalAddressNo!;
                        } else {
                          addressController.text = '';
                          selectedBranch = dropdownValue;
                        }
                      });
                    },
                    items: branches.map<DropdownMenuItem<BranchModel>>(
                        (BranchModel value) {
                      return DropdownMenuItem<BranchModel>(
                        value: value,
                        child: Text(
                          value.branchName!,
                          style: TextStyle(
                              color: CustomColors().blackColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              padding: const EdgeInsets.all(8.0),
              child: Text(
                LocaleKeys.branch_address.tr(),
                style: TextStyle(
                    fontSize: 15,
                    height: 1.5,
                    color: CustomColors().blackColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
            TextFieldDesign.emptyLargeFieldStyle(
              context: context,
              verMarg: 0,
              horMarg: 0,
              controller: addressController,
              kbType: TextInputType.multiline,
              initValue: LocaleKeys.enter_branch_address.tr(),
            ),
            SizedBox(
              height: 30,
            )
            ,
            Container(
              alignment: Alignment.bottomCenter,
              child: greenBtn(
                  LocaleKeys.continue_payment.tr(), EdgeInsets.all(20), () {
                if (addressController.text != '') {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return PaymentPage();
                  }));
                } else {
                  showErrorMessageDialog(
                      context, LocaleKeys.select_branch_note.tr());
                }
              }),
            ),
          ],
        ),
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

    // initiateSession();
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
