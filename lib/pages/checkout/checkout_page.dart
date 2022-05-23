import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khudrah_companies/Constant/api_const.dart';
import 'package:khudrah_companies/Constant/conts.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/designs/appbar_design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:khudrah_companies/designs/text_field_design.dart';
import 'package:khudrah_companies/dialogs/message_dialog.dart';
import 'package:khudrah_companies/dialogs/progress_dialog.dart';
import 'package:khudrah_companies/helpers/cart_helper.dart';
import 'package:khudrah_companies/helpers/custom_btn.dart';
import 'package:khudrah_companies/helpers/number_helper.dart';
import 'package:khudrah_companies/helpers/order_helper.dart';
import 'package:khudrah_companies/helpers/pref/shared_pref_helper.dart';
import 'package:khudrah_companies/network/API/api_response.dart';
import 'package:khudrah_companies/network/API/api_response_type.dart';
import 'package:khudrah_companies/network/helper/exception_helper.dart';
import 'package:khudrah_companies/network/helper/network_helper.dart';
import 'package:khudrah_companies/network/models/branches/branch_list_response_model.dart';
import 'package:khudrah_companies/network/models/branches/branch_model.dart';
import 'package:khudrah_companies/network/models/cart/success_cart_response_model.dart';
import 'package:khudrah_companies/network/models/cart/user_cart.dart';
import 'package:khudrah_companies/network/models/orders/order_items.dart';
import 'package:khudrah_companies/network/models/orders/submit_order_success_response_model.dart';
import 'package:khudrah_companies/network/models/user_model.dart';
import 'package:khudrah_companies/network/repository/branches_repository.dart';
import 'package:khudrah_companies/network/repository/order_repository.dart';
import 'package:khudrah_companies/pages/branch/add_brunches_page.dart';
import 'package:khudrah_companies/pages/branch/branch_list.dart';
import 'package:khudrah_companies/pages/checkout/payment_page.dart';
import 'package:khudrah_companies/pages/order_completed_page.dart';
import 'package:khudrah_companies/provider/branch_provider.dart';
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
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class CheckoutPage extends StatefulWidget {
  final User? currentUser;
  final UserCart? userCart;

  const CheckoutPage({
    Key? key,
    required this.currentUser,
    required this.userCart,
  }) : super(key: key);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  static BranchModel selectedBranch = BranchModel();

  TextEditingController addressController = TextEditingController();

  static String address = '';

  BranchModel dropdownValue =
      BranchModel(branchName: LocaleKeys.select_branch.tr(), address: '----');
  int _selectedValueIndex = 0;

  // for view
  bool isPayOnlineSelected = false;
  bool isPayDebitSelected = false;
  bool isPayCashSelected = true;
  bool isDebitAllow = true;
  bool isOnlineAvailable = true;

  // for api
  bool isSuccess = false;
  bool hasPaid = false;

  String paymentMethod = 'C';
  List<BranchModel> branches = [];

  @override
  Widget build(BuildContext context) {
    //  List<BranchModel> branches = widget.branchList!;
    // isDebitAllow = widget.currentUser!.hasCreditOption!;
    // List<BranchModel> branches = [dropdownValue];
    final provider = Provider.of<BranchProvider>(context, listen: false);

/*
    branches = [dropdownValue];
*/      branches = [dropdownValue];

    setBranchList(provider);
/*    branches.addAll(
        Provider.of<BranchProvider>(context, listen: false).getBranchList);*/
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

    num priceAfterDiscount = widget.userCart!.totalDiscount!;
    num subtotal = widget.userCart!.totalCartPrice!;
    num vat = widget.userCart!.totalCartVAT15!;
    num total = widget.userCart!.totalNetCartPrice!;
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
                    child: greenBtn(LocaleKeys.send_order.tr(),
                        EdgeInsets.symmetric(vertical: 4), () {
                      if (addressController.text != '') {
                        if (isPayDebitSelected == true) {
                          //   payWithEmbeddedPayment();
                          if (widget.currentUser!.companyBalance! <= 0) {
                            showErrorMessageDialog(
                                context, LocaleKeys.no_debit_balance.tr());
                          }
                        } else {
                          //  continue order ( api , show success page)
                          setState(() {
                            OrderHelper.callApi(context, widget.userCart!,
                                selectedBranch, hasPaid, paymentMethod);
                          });
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
          scrollDirection: Axis.vertical,
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
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return BranchList();
                    }));
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.settings,
                        color: CustomColors().brownColor,
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          LocaleKeys.control_branches.tr(),
                          style: TextStyle(
                            fontSize: 15,
                            height: 1.5,
                            color: CustomColors().brownColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
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
                          color: index == _selectedValueIndex
                              ? CustomColors().primaryGreenColor
                              : CustomColors().darkGrayColor.withOpacity(0.6),
                          iconData: iconList[index]),
                    ),
                  ],
                ),

                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ),
        //slide up panel height
        minHeight: scHeight * 0.07,
        maxHeight: hasDiscount ? scHeight * 0.39 : 235,
      ),
    );
  }

  //-----
  setBranchList(BranchProvider value) async {

    if (value.branchList!.isEmpty && value.citiesList!.isEmpty) {
      Map<String, dynamic> headerMap = await getHeaderMap();
      String companyId = await PreferencesHelper.getUserID;

      BranchRepository branchRepository = BranchRepository(headerMap);

      ApiResponse apiResponse = await branchRepository.getAllBranch(companyId);

      if (apiResponse.apiStatus.code == ApiResponseType.OK.code) {
        BranchListResponseModel? responseModel =
            BranchListResponseModel.fromJson(apiResponse.result);

        print(responseModel.branches.toString());
        PreferencesHelper.saveBranchesList(responseModel.branches!);
        PreferencesHelper.saveCitiesList(responseModel.cities!);
        value.setBranchList(responseModel.branches);
        value.setCitiesList(responseModel.cities);
       // branches = [dropdownValue];
        branches.insertAll(1, responseModel.branches!);
        //branches = responseModel.branches!;
      } else {
        throw ExceptionHelper(apiResponse.message);
      }
    } else {
      branches.addAll(value.getBranchList);
    }
  }

  ///********
  ///
  ///general  methods
  ///
  ///********
  @override
  void initState() {
    super.initState();
  }
  //------------------------

  Widget payButton(
      {required String text,
      required IconData iconData,
      required int index,
      color}) {
    return InkWell(
      child: payButtonDesign(context, color, text, iconData),
      onTap: () {
        //could be converted to a switch case if needed
        if (text == LocaleKeys.credit_card.tr()) {
          //credit card payment method
          if (addressController.text != '') {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return PaymentPage(
                userCart: widget.userCart,
                branchModel: selectedBranch,
              );
            }));
          } else {
            showErrorMessageDialog(context, LocaleKeys.select_branch_note.tr());
          }
/*          setState(() {
            if (isOnlineAvailable == true) {
              isPayOnlineSelected = true;
              isPayCashSelected = false;
              isPayDebitSelected = false;
              _selectedValueIndex = index;
              paymentMethod = 'O';
            }
          });*/
        } else {
          if (text == LocaleKeys.postpaid.tr()) {
            setState(() {
              isPayDebitSelected = true;
              isPayOnlineSelected = false;
              isPayCashSelected = false;
              isSuccess = true;
              hasPaid = false;
              paymentMethod = credit;
              _selectedValueIndex = index;
            });
          } else {
            setState(() {
              isPayOnlineSelected = false;
              isPayDebitSelected = false;
              isSuccess = true;
              hasPaid = false;
              _selectedValueIndex = index;
              isPayCashSelected = true;
              paymentMethod = cash;
            });
          }
        }
      },
    );
  }
}
