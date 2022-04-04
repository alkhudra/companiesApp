import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khudrah_companies/Constant/conts.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/Constant/pref_cont.dart';
import 'package:khudrah_companies/designs/ButtonsDesign.dart';
import 'package:khudrah_companies/designs/brand_name.dart';
import 'package:khudrah_companies/designs/card_design.dart';
import 'package:khudrah_companies/designs/text_field_design.dart';
import 'package:khudrah_companies/dialogs/alret_dialog.dart';
import 'package:khudrah_companies/dialogs/message_dialog.dart';
import 'package:khudrah_companies/dialogs/progress_dialog.dart';
import 'package:khudrah_companies/helpers/contact_helper.dart';
import 'package:khudrah_companies/helpers/info_correcter_helper.dart';
import 'package:khudrah_companies/helpers/pref/pref_manager.dart';
import 'package:khudrah_companies/helpers/pref/shared_pref_helper.dart';
import 'package:khudrah_companies/network/API/api_response_type.dart';
import 'package:khudrah_companies/network/models/auth/success_register_response_model.dart';
import 'package:khudrah_companies/network/helper/network_helper.dart';
import 'package:khudrah_companies/network/repository/auth_repository.dart';
import 'package:khudrah_companies/pages/auth/login_page.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:khudrah_companies/router/route_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController ownerController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController branchesController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController commercialNoController = TextEditingController();
  final TextEditingController vatNoController = TextEditingController();

  bool isBtnEnabled = true;

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    double scWidth = size.width;
    double scHeight = size.height;

    return Scaffold(

      backgroundColor: CustomColors().backgroundColor,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 200, bottom: 30),
              width: MediaQuery.of(context).size.width/0.9,
              height: MediaQuery.of(context).size.height*1.05,
              decoration: CardDesign.largeCardDesign(),
              child: Container(
              // color: Colors.red,
              width: scWidth/2,
              height: scHeight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: scHeight*0.05,),
                  Container(
                    child: Text(LocaleKeys.sign_up_title.tr(), 
                    style: TextStyle(
                      color: CustomColors().brownColor,
                      fontSize: 25
                    ),),
                  ),
                  Divider(
                    color: CustomColors().grayColor,
                    thickness: 1.8,
                    indent: 60,
                    endIndent: 60,
                  ),
                  SizedBox(height: scHeight*0.03,),
                  TextFieldDesign.textFieldStyle(
                    context: context,
                    verMarg: 5,
                    horMarg: 0,
                    controller: ownerController,
                    kbType: TextInputType.name,
                    obscTxt: false,
                    lbTxt: LocaleKeys.owner_name.tr(),
                  ),
                  TextFieldDesign.textFieldStyle(
                    context: context,
                    verMarg: 5,
                    horMarg: 0,
                    controller: companyNameController,
                    kbType: TextInputType.name,
                    obscTxt: false,
                    lbTxt: LocaleKeys.company_name.tr(),
                  ),
                  TextFieldDesign.textFieldStyle(
                    context: context,
                    verMarg: 5,
                    horMarg: 0,
                    controller: emailController,
                    kbType: TextInputType.emailAddress,
                    obscTxt: false,
                    lbTxt: LocaleKeys.email.tr(),
                  ),
                  TextFieldDesign.textFieldStyle(
                    context: context,
                    verMarg: 5,
                    horMarg: 0,
                    controller: phoneController,
                    kbType: TextInputType.phone,
                    obscTxt: false,
                    lbTxt: LocaleKeys.phone.tr(),
                  ),
                  TextFieldDesign.textFieldStyle(
                    context: context,
                    verMarg: 5,
                    horMarg: 0,
                    controller: commercialNoController,
                    kbType: TextInputType.number,
                    obscTxt: false,
                    lbTxt: LocaleKeys.commercial_no.tr(),
                  ),
                  TextFieldDesign.textFieldStyle(
                    context: context,
                    verMarg: 5,
                    horMarg: 0,
                    controller: vatNoController,
                    kbType: TextInputType.number,
                    obscTxt: false,
                    lbTxt: LocaleKeys.vat_no.tr(),
                  ),
                  TextFieldDesign.textFieldStyle(
                    context: context,
                    verMarg: 5,
                    horMarg: 0,
                    controller: branchesController,
                    kbType: TextInputType.number,
                    obscTxt: false,
                    lbTxt: LocaleKeys.branches_no.tr(),
                  ),
                  TextFieldDesign.textFieldStyle(
                    context: context,
                    verMarg: 5,
                    horMarg: 0,
                    controller: passwordController,
                    kbType: TextInputType.visiblePassword,
                    obscTxt: true,
                    lbTxt: LocaleKeys.password.tr(),
                  ),
                  TextFieldDesign.textFieldStyle(
                    context: context,
                    verMarg: 5,
                    horMarg: 0,
                    controller: confirmPasswordController,
                    kbType: TextInputType.visiblePassword,
                    obscTxt: true,
                    lbTxt: LocaleKeys.confirm_pass.tr(),
                  ),
                  SizedBox(height: scHeight*0.03,),
                  Container(
                      margin: EdgeInsets.only(bottom: scHeight*0.01),
                      padding: EdgeInsets.only(right: 10, left: 10),
                      child: GestureDetector(
                        onTap: () {
                          directToTerms();
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(LocaleKeys.terms_conditions_note.tr(),
                                style: TextStyle(
                                    color: CustomColors().blackColor)),
                                    SizedBox(height: 8,),
                            Text(LocaleKeys.terms_conditions.tr(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: CustomColors().primaryGreenColor))
                          ],
                        ),
                      )),
                      SizedBox(height: 10,),
                    Container(
                      margin: EdgeInsets.only(bottom: 5),
                      padding: EdgeInsets.only(right: 10, left: 10),
                      child: GestureDetector(
                        onTap: () {

                          directToLogIn();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(LocaleKeys.already_have_account.tr(),
                                style: TextStyle(
                                    color: CustomColors().blackColor)),
                            Text(' ' + LocaleKeys.log_in.tr().toUpperCase(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: CustomColors().primaryGreenColor))
                          ],
                        ),
                      )
                    ),
                      SizedBox(height: scHeight*0.05,),
                  // Container(
                  //     height: ButtonsDesign.buttonsHeight,
                  //     margin: EdgeInsets.only(left: 50, right: 50),
                  //     child: MaterialButton(
                  //       onPressed: () {
                  //         if (isBtnEnabled)
                  //           continueSignUp(emailController.text);
                  //       },
                  //       shape: StadiumBorder(),
                  //       child: ButtonsDesign.buttonsText(
                  //           LocaleKeys.continue_btn.tr(),
                  //           CustomColors().primaryWhiteColor),
                  //       color: CustomColors().primaryGreenColor,
                  //     ))
                ],
              ),
            ),
            ),
            Positioned(
              bottom: scHeight*0.015,
              right: 40,
              left: 40,
              child: Container(
                height: ButtonsDesign.buttonsHeight,
                margin: EdgeInsets.only(left: 20, right: 20),
                child: MaterialButton(
                  onPressed: () {
                    if (isBtnEnabled)
                      continueSignUp(emailController.text);
                  },
                  shape: StadiumBorder(),
                  child: ButtonsDesign.buttonsText(
                      LocaleKeys.continue_btn.tr(),
                      CustomColors().primaryWhiteColor, 15),
                  color: CustomColors().primaryGreenColor,
                )),
            ),
            brandNameMiddle(),
          ],
        ),
      ),
    );
  }

  void showErrorDialog(String txt) {
    isBtnEnabled = true;
    showDialog<String>(
        context: context,
        builder: (BuildContext context) =>
            showMessageDialog(context, LocaleKeys.error.tr(), txt,noPage));
  }

  void continueSignUp(String userEmail) async{
    if (ownerController.value.text == '') {
      // print('owner name');

      showErrorDialog(LocaleKeys.owner_required.tr());

      return;
    }

    if (companyNameController.value.text == '') {
      showErrorDialog(LocaleKeys.company_required.tr());
      return;
    }

    if (emailController.value.text == '') {
      showErrorDialog(LocaleKeys.email_required.tr());

      return;
    }

    if (isValidEmail(emailController.value.text) == false) {
      showErrorDialog(LocaleKeys.email_not_valid.tr());

      return;
    }

    if (phoneController.value.text == '') {
      showErrorDialog(LocaleKeys.phone_required.tr());

      return;
    }
    if (isValidPhone(phoneController.value.text) != validPhone) {
      showErrorDialog(isValidPhone(phoneController.value.text));
      return;
    }

    if (commercialNoController.value.text == '') {
      showErrorDialog(LocaleKeys.commercial_no_required.tr());

      return;
    }

    if (commercialNoController.value.text.length != 10) {
      showErrorDialog(LocaleKeys.commercial_no_error.tr());

      return;
    }


    if (vatNoController.value.text == '') {
      showErrorDialog(LocaleKeys.vat_no_required.tr());

      return;
    }

    if (vatNoController.value.text.length != 15) {
      showErrorDialog(LocaleKeys.vat_no_error.tr());

      return;
    }
    if (branchesController.value.text == '') {
      showErrorDialog(LocaleKeys.branches_no_required.tr());

      return;
    }
    if (branchesController.value.text == '0') {
      showErrorDialog(LocaleKeys.branches_no_not_zero.tr());

      return;
    }

    if (passwordController.value.text == '') {
      showErrorDialog(LocaleKeys.pass_required.tr());

      return;
    }

    if (confirmPasswordController.value.text == '') {
      showErrorDialog(LocaleKeys.confirm_pass_required.tr());

      return;
    }

    if (passwordController.value.text != confirmPasswordController.value.text) {
      showErrorDialog(LocaleKeys.not_match_pass.tr());
      return;

      //// continue sign
    }

    isBtnEnabled = false;

    print('continue sign up ');

    //----------show progress----------------

    showLoaderDialog(context);
    //----------start api ----------------


    AuthRepository registerRepository = AuthRepository();
    registerRepository
        .registerUser(
            emailController.text,
            passwordController.text,
            confirmPasswordController.text,
            phoneController.text,
            ownerController.text,
            companyNameController.text,
            commercialNoController.text,
            vatNoController.text,
            int.parse(branchesController.text))
        .then((result) async {
      //-------- fail response ---------

      if (result == null || result.apiStatus.code != ApiResponseType.OK.code) {
        /* if (result.apiStatus.code == ApiResponseType.BadRequest)*/
        Navigator.pop(context);
        showErrorDialog(result.message);
        return;
      }

      //-------- success response ---------
      print(result.result);
      SuccessRegisterResponseModel model = SuccessRegisterResponseModel.fromJson(result.result);
      print(model.userId);

      PreferencesHelper.setUserID(model.userId);
      PreferencesHelper.getUserID.then((value) =>  print( value));


      PreferencesHelper.setUserLoggedIn(false);
      PreferencesHelper.setUserFirstLogIn(false);
      Navigator.pop(context);



      showWelcomeDialog(context);

    });
  }

  showWelcomeDialog(BuildContext context) {

    showDialog<String>(
        context: context,
        builder: (BuildContext context) =>
            showMessageDialog(context, LocaleKeys.registered_success.tr(),LocaleKeys.auth_note.tr() ,loginRoute));

  }

  void directToLogIn() {

    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) {
          return LogInPage();
        }));
  }

  void directToTerms() async{

    String selectedLanguage = await PreferencesHelper.getSelectedLanguage;

    openURL('http://alkhudrahproject-001-site2.ctempurl.com/GeneralView/GetTermsConditions?lang=$selectedLanguage');

  }
}
