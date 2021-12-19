import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khudrah_companies/Constant/conts.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/designs/ButtonsDesign.dart';
import 'package:khudrah_companies/designs/brand_name.dart';
import 'package:khudrah_companies/designs/card_design.dart';
import 'package:khudrah_companies/designs/text_field_design.dart';
import 'package:khudrah_companies/dialogs/alret_dialog.dart';
import 'package:khudrah_companies/helpers/info_correcter_helper.dart';
import 'package:khudrah_companies/pages/login_page.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'package:easy_localization/easy_localization.dart';

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
  final TextEditingController brunchesController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController commercialNoController = TextEditingController();
  bool isBtnEnabled = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //todo:
      /********
       *
       * design problems:
       * height of card  , width of main column,place of btn
       * *********/
      backgroundColor: CustomColors().backgroundColor,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 90, left: 30, right: 30),
              width: MediaQuery.of(context).size.width / 0.3,
              height: MediaQuery.of(context).size.height / 0.97,
              decoration: CardDesign.largeCardDesign(),
            ),
            SizedBox(
              height: 50,
            ),
            brandNameMiddle(),
            SizedBox(
              height: 50,
            ),
            Container(
              margin: EdgeInsets.only(top: 250, left: 40, right: 30),
              width: 300,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    height: 60,
                    child: TextField(
                      controller: ownerController,
                      keyboardType: TextInputType.name,
                      style: TextStyle(
                          color: CustomColors().blackColor,
                          fontWeight: FontWeight.bold),
                      decoration:
                          textFieldDecoration(LocaleKeys.owner_name.tr()),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  /******/
                  Container(
                    height: 60,
                    child: TextField(
                      controller: companyNameController,
                      keyboardType: TextInputType.name,
                      style: TextStyle(
                          color: CustomColors().blackColor,
                          fontWeight: FontWeight.bold),
                      decoration:
                          textFieldDecoration(LocaleKeys.company_name.tr()),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  /******/

                  Container(
                    height: 60,
                    child: TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(
                          color: CustomColors().blackColor,
                          fontWeight: FontWeight.bold),
                      decoration: textFieldDecoration(LocaleKeys.email.tr()),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  /******/

                  Container(
                    height: 60,
                    child: TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      style: TextStyle(
                          color: CustomColors().blackColor,
                          fontWeight: FontWeight.bold),
                      decoration: textFieldDecoration(LocaleKeys.phone.tr()),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  /******/
                  Container(
                    height: 60,
                    child: TextField(
                      controller: commercialNoController,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                          color: CustomColors().blackColor,
                          fontWeight: FontWeight.bold),
                      decoration:
                          textFieldDecoration(LocaleKeys.commercial_no.tr()),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  /******/
                  Container(
                    height: 60,
                    child: TextField(
                      controller: brunchesController,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                          color: CustomColors().blackColor,
                          fontWeight: FontWeight.bold),
                      decoration:
                          textFieldDecoration(LocaleKeys.brunches_no.tr()),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  /******/

                  Container(
                    height: 60,
                    child: TextField(
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      style: TextStyle(
                          color: CustomColors().blackColor,
                          fontWeight: FontWeight.bold),
                      decoration: textFieldDecoration(LocaleKeys.password.tr()),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  /******/
                  Container(
                    height: 60,
                    child: TextField(
                      controller: confirmPasswordController,
                      keyboardType: TextInputType.visiblePassword,
                      style: TextStyle(
                          color: CustomColors().blackColor,
                          fontWeight: FontWeight.bold),
                      decoration:
                          textFieldDecoration(LocaleKeys.confirm_pass.tr()),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  /******/
                  Container(
                      margin: EdgeInsets.only(bottom: 10),
                      padding: EdgeInsets.only(right: 10, left: 10),
                      child: GestureDetector(
                        onTap: () {
                          //todo: go to terms
                          /*  Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                              return SignUpPage();
                            }));*/
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(LocaleKeys.terms_conditions_note.tr(),
                                style: TextStyle(
                                    color: CustomColors().blackColor)),
                            Text(LocaleKeys.terms_conditions.tr(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: CustomColors().primaryGreenColor))
                          ],
                        ),
                      )),
                  Container(
                      margin: EdgeInsets.only(bottom: 5),
                      padding: EdgeInsets.only(right: 10, left: 10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return LogInPage();
                          }));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(LocaleKeys.already_have_account.tr(),
                                style: TextStyle(
                                    color: CustomColors().blackColor)),
                            Text(LocaleKeys.log_in.tr().toUpperCase(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: CustomColors().primaryGreenColor))
                          ],
                        ),
                      )),
                  Container(
                      height: ButtonsDesign.buttonsHeight,
                      margin: EdgeInsets.only(left: 50, right: 50, bottom: 20),
                      child: MaterialButton(
                        onPressed: () {
                          if (isBtnEnabled) continueSignUp();
                        },
                        shape: StadiumBorder(),
                        child: ButtonsDesign.buttonsText(
                            LocaleKeys.continue_btn.tr(),
                            CustomColors().primaryWhiteColor),
                        color: CustomColors().primaryGreenColor,
                      ))
                ],
              ),
            ),
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
            showMessageDialog(context, LocaleKeys.error.tr(), txt));
  }

  void continueSignUp() {
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
      print(isValidPhone(phoneController.value.text));
      return;
    }

    if (commercialNoController.value.text == '') {
      showErrorDialog(LocaleKeys.commercial_no_required.tr());

      return;
    }

    if (brunchesController.value.text == '') {
      showErrorDialog(LocaleKeys.brunches_no_required.tr());

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

    print('continue sign in ');
  }
}
