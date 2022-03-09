import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khudrah_companies/Constant/api_const.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/designs/appbar_design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:khudrah_companies/designs/text_field_design.dart';
import 'package:khudrah_companies/dialogs/message_dialog.dart';
import 'package:khudrah_companies/helpers/cart_helper.dart';
import 'package:khudrah_companies/helpers/custom_btn.dart';
import 'package:khudrah_companies/helpers/pref/shared_pref_helper.dart';
import 'package:khudrah_companies/network/models/branches/branch_model.dart';
import 'package:khudrah_companies/network/models/cart/user_cart.dart';
import 'package:khudrah_companies/network/models/user_model.dart';
import 'package:khudrah_companies/pages/branch/add_brunches_page.dart';
import 'package:khudrah_companies/pages/branch/branch_list.dart';
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
import 'package:sliding_up_panel/sliding_up_panel.dart';

class CheckoutPage extends StatefulWidget {
  final User? currentUser;
  final UserCart? userCart;
  final List<BranchModel>? branchList;
  const CheckoutPage(
      {Key? key,
      required this.currentUser,
      required this.userCart,
      required this.branchList})
      : super(key: key);

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
  static late MFPaymentCardView mfPaymentCardView;

  BranchModel dropdownValue =
      BranchModel(branchName: LocaleKeys.select_branch.tr(), address: '----');
  int _selectedValueIndex = 0;
  bool isPayOnlineSelected = false;
  bool isPayDebitSelected = false;
  bool isPayCashSelected = true;
  bool isDebitAllow = false;

  Color onlineSelected = CustomColors().primaryWhiteColor;
  static late List<BranchModel> branches;
  String paymentMethod = 'C';
  @override
  Widget build(BuildContext context) {
    //  List<BranchModel> branches = widget.branchList!;
    isDebitAllow = widget.currentUser!.hasCreditOption!;
    branches = [dropdownValue];

    if (widget.branchList!.length != 0) {
      for (BranchModel c in widget.branchList!)
        branches.add(c);
    }
    Size size = MediaQuery.of(context).size;
    double scWidth = size.width;
    double scHeight = size.height;

    List<String> payMethod = [
      LocaleKeys.cash.tr(),
      LocaleKeys.credit_card.tr(),
    ];

    List<IconData> iconList = [
      FontAwesomeIcons.moneyBillWave,
      FontAwesomeIcons.solidCreditCard,
    ];

    if (isDebitAllow == true) {
      iconList.add(FontAwesomeIcons.receipt);
      payMethod.insert(2, LocaleKeys.postpaid.tr());
    }

    num priceAfterDiscount = widget.userCart!.priceAfterDiscount!;
    num subtotal = widget.userCart!.totalNetCartPrice!;
    num vat = widget.userCart!.totalCartVAT15!;
    num total = widget.userCart!.totalCartPrice!;
    num discount = widget.userCart!.discountPercentage! * 100;
    bool? hasDiscount = widget.userCart!.hasDiscount;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBarDesign(context, LocaleKeys.checkout.tr()),
      body: SlidingUpPanel(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        panel: Container(
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
                    child: greenBtn(
                        isPayOnlineSelected == true
                            ? LocaleKeys.continue_payment.tr()
                            : LocaleKeys.send_order.tr(),
                        EdgeInsets.symmetric(vertical: 4), () {
                      if (addressController.text != '') {
                        if (isPayOnlineSelected == true)
                          payWithEmbeddedPayment();
                        else {
                          //  continue order ( api , show success page)
                        }
                      } else {
                        showErrorMessageDialog(
                            context, LocaleKeys.select_branch_note.tr());
                      }
                    }),
                  ),
                ],
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 20, right: 20),
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
                if (widget.branchList!.length == 0)
                  GestureDetector(
                    onTap: () {
                      final model = Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return BranchList();
                      }));
                      BranchModel branchModel = BranchModel();

                      if (model != null) {
                        setState(() {
                          branchModel = model as BranchModel;
                          branches.add(branchModel);
                          print('branhc is $branchModel');
                        });
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'no Branches press to add ',
                        style: TextStyle(
                            fontSize: 15,
                            height: 1.5,
                            color: CustomColors().redColor,
                            fontWeight: FontWeight.bold),
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
                  height: 20,
                ),
                Container(
                  child: Text(
                    LocaleKeys.payment_method.tr(),
                    style: TextStyle(
                        color: CustomColors().blackColor,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                //payment method list
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ...List.generate(
                      payMethod.length,
                      (index) => payButton(
                          index: index,
                          text: payMethod[index],
                          iconData: iconList[index]),
                    ),
                  ],
                ),

                SizedBox(
                  height: 10,
                ),
                if (isPayOnlineSelected == true) onlineView(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget onlineView() {
    return Column(
      children: [
        // cards view
        // apple pay
        // stc pay
        // price view

        createPaymentCardView(),
        Container(
          alignment: Alignment.bottomCenter,
          child: greenBtn(LocaleKeys.continue_payment.tr(), EdgeInsets.all(20),
              () {
            if (addressController.text != '') {
              payWithEmbeddedPayment();
            } else {
              showErrorMessageDialog(
                  context, LocaleKeys.select_branch_note.tr());
            }
          }),
        ),
      ],
    );
  }

  orderDetails() {}

  ///********
  ///
  ///payment methods
  ///
  ///********

  void payWithEmbeddedPayment() {
    var request = MFExecutePaymentRequest.constructor(0.100);
    mfPaymentCardView.pay(
        request,
        MFAPILanguage.AR,
        (String invoiceId, MFResult<MFPaymentStatusResponse> result) => {
              if (result.isSuccess())
                {
                  setState(() {
                    print("invoiceId: " + invoiceId);
                    print("Response: " + result.response!.toJson().toString());
                    _response = result.response!.toJson().toString();
                    // continue order ( api , show success page)
                  })
                }
              else
                {
                  setState(() {
                    print("invoiceId: " + invoiceId);
                    print("Error: " + result.error!.toJson().toString());
                    _response = result.error!.message!;
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
        double.parse(amount), MFCurrencyISO.KUWAIT_KWD);

    MFSDK.initiatePayment(
        request,
        MFAPILanguage.EN,
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
    mfPaymentCardView = MFPaymentCardView(
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
      // showLabels: true,
//      cardHolderNameLabel: "card holder name label",
//      cardNumberLabel: "card number label",
//      expiryDateLabel: "expiry date label",
//      cvvLabel: "cvv label",
    );
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
  //------------------------

  ///********
  ///
  ///general  methods
  ///
  ///********
  @override
  void initState() {
    super.initState();

    // TODO, don't forget to init the MyFatoorah Plugin with the following line
    MFSDK.init(mAPIKey, MFCountry.KUWAIT, MFEnvironment.TEST);
    // (Optional) un comment the following lines if you want to set up properties of AppBar.
    initiatePayment('100');
    initiateSession();
    // MFSDK.setUpAppBar(isShowAppBar: false);
  }
  //------------------------

  Widget payButton(
      {required String text, required IconData iconData, required int index}) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.27,
          height: MediaQuery.of(context).size.height * 0.09,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                  color: index == _selectedValueIndex
                      ? CustomColors().primaryGreenColor
                      : CustomColors().darkGrayColor.withOpacity(0.6))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                iconData,
                color: index == _selectedValueIndex
                    ? CustomColors().primaryGreenColor
                    : CustomColors().darkGrayColor.withOpacity(0.5),
                size: 25,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Text(
                  text,
                  style: TextStyle(
                      color: index == _selectedValueIndex
                          ? CustomColors().primaryGreenColor
                          : CustomColors().darkGrayColor.withOpacity(0.7),
                      fontSize: 13),
                ),
              )
            ],
          ),
        ),
      ),
      onTap: () {
        //could be converted to a switch case if needed
        if (text == LocaleKeys.credit_card.tr()) {
          //credit card payment method
          setState(() {
            isPayOnlineSelected = true;
            _selectedValueIndex = index;
            paymentMethod = 'O';
          });
        } else {
          if (text == LocaleKeys.postpaid.tr()) {
            setState(() {
              isPayDebitSelected = true;
              paymentMethod = 'D';
              _selectedValueIndex = index;
            });
          } else {
            setState(() {
              _selectedValueIndex = index;
              isPayCashSelected = true;
              paymentMethod = 'C';
            });
          }
        }
      },
    );
  }
}
