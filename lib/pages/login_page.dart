import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khudrah_companies/Constant/conts.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/designs/ButtonsDesign.dart';
import 'package:khudrah_companies/designs/brand_name.dart';
import 'package:khudrah_companies/designs/card_design.dart';
import 'package:khudrah_companies/designs/text_field_design.dart';
import 'package:khudrah_companies/dialogs/alret_dialog.dart';
import 'package:khudrah_companies/dialogs/message_dialog.dart';
import 'package:khudrah_companies/dialogs/progress_dialog.dart';
import 'package:khudrah_companies/helpers/info_correcter_helper.dart';
import 'package:khudrah_companies/helpers/shared_pref_helper.dart';
import 'package:khudrah_companies/network/API/api_response_type.dart';
import 'package:khudrah_companies/network/models/login_response_model.dart';
import 'package:khudrah_companies/network/models/string_response_model.dart';
import 'package:khudrah_companies/network/repository/register_repository.dart';
import 'package:khudrah_companies/pages/home_page.dart';
import 'package:khudrah_companies/pages/reset_password/enter_code_page.dart';
import 'package:khudrah_companies/pages/sign_up_page.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khudrah_companies/router/route_constants.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'add_brunches_page.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  bool isBtnEnabled = true;
  bool isForgetPassBtnEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //todo:
      /********
       *
       * design problems:
       * height of card  , width of main column ,place of btn
       * *********/
      backgroundColor: CustomColors().backgroundColor,
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 120, left: 30, right: 30),
            width: MediaQuery.of(context).size.width / 0.3,
            height: MediaQuery.of(context).size.height / 1.8,
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
            margin: EdgeInsets.only(top: 250, left: 60),
            width: 300,
            height: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFieldDesign.textFieldStyle(
                  context: context,
                  verMarg: 5,
                  horMarg: 0,
                  controller: emailController,
                  kbType: TextInputType.emailAddress,
                  lbTxt: LocaleKeys.email.tr(),
                ),
                TextFieldDesign.textFieldStyle(
                  context: context,
                  verMarg: 5,
                  horMarg: 0,
                  controller: passController,
                  kbType: TextInputType.visiblePassword,
                  lbTxt: LocaleKeys.password.tr(),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                    height: 30,
                    padding: EdgeInsets.only(right: 10, left: 10),
                    child: GestureDetector(
                      onTap: () {
                        if (isForgetPassBtnEnabled)
                          showDialog(
                              builder: (BuildContext context) =>
                                  showEnterEmailDialog(context),
                              context: context);
                      },
                      child: Text(LocaleKeys.forget_pass.tr(),
                          style: TextStyle(
                              color: CustomColors().primaryGreenColor)),
                    )),
                Container(
                    height: 30,
                    padding: EdgeInsets.only(right: 10, left: 10),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return SignUpPage();
                        }));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(LocaleKeys.new_user.tr(),
                              style:
                                  TextStyle(color: CustomColors().blackColor)),
                          Text(LocaleKeys.create_account.tr(),
                              style: TextStyle(
                                  color: CustomColors().primaryGreenColor))
                        ],
                      ),
                    )),
                Container(
                    height: ButtonsDesign.buttonsHeight,
                    margin: EdgeInsets.only(left: 50, right: 50),
                    child: MaterialButton(
                      onPressed: () {
                        if (isBtnEnabled) logIn();
                      },
                      shape: StadiumBorder(),
                      child: ButtonsDesign.buttonsText(LocaleKeys.log_in.tr(),
                          CustomColors().primaryWhiteColor),
                      color: CustomColors().primaryGreenColor,
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showErrorDialog(String txt) {
    isForgetPassBtnEnabled = true;
    isBtnEnabled = true;
    showDialog<String>(
        context: context,
        builder: (BuildContext context) =>
            showMessageDialog(context, LocaleKeys.error.tr(), txt, noPage));
  }

  void logIn() {
    if (emailController.value.text == '') {
      showErrorDialog(LocaleKeys.email_required.tr());
      return;
    }

    if (isValidEmail(emailController.value.text) == false) {
      showErrorDialog(LocaleKeys.email_not_valid.tr());
      return;
    }

    if (passController.value.text == '') {
      showErrorDialog(LocaleKeys.pass_required.tr());
      return;
    }

    isBtnEnabled = false;

    print('continue log in ');

    //----------show progress----------------

    showLoaderDialog(context);
    //----------start api ----------------
    RegisterRepository registerRepository = RegisterRepository();
    registerRepository
        .loginUser(emailController.text, passController.text)
        .then((result) async {
      //-------- fail response ---------

      //todo: edit after adjustments
      if (result == null || result.apiStatus.code != ApiResponseType.OK.code) {
        /* if (result.apiStatus.code == ApiResponseType.BadRequest)*/
        Navigator.pop(context);
        showErrorDialog(result.message);
        return;
      }

      //-------- success response ---------
      LoginResponseModel model = result.result;
      print(model.user.toString());
      User user = model.user!;
      // if(user != null) {
      // print(model.user.get);

      PreferencesHelper.setUserID(user.id!);
      PreferencesHelper.getUserID.then((value) => print('user id : $value'));

      PreferencesHelper.setUserToken(model.token);
      PreferencesHelper.getUserToken.then((value) => print('token : $value'));

      PreferencesHelper.setUser(user);
      bool isHasBranches = user.branches!.isEmpty;
      Navigator.pop(context);

      if (isHasBranches)
        addBranchesPage();
      else
        directToHomePage();

      // }else showErrorDialog(result.message);

      //todo: check user status and show message if not registered
    });
  }
////---------------------------

  Widget showEnterEmailDialog(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      //this right here
      child: Container(
        height: CardDesign.cardsHeight,
        width: CardDesign.cardsWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              LocaleKeys.reset_password.tr(),
              style: TextStyle(
                fontSize: 20,
                color: CustomColors().darkBlueColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (!isValidEmail(controller.text)) {
                    return LocaleKeys.email_not_valid.tr();
                  }
                },
                controller: controller,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(
                    color: CustomColors().blackColor,
                    fontWeight: FontWeight.bold),
                decoration: textFieldDecorationWithIcon(
                    LocaleKeys.email.tr(), Icons.email),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            Container(
                height: ButtonsDesign.buttonsHeight,
                margin: EdgeInsets.only(left: 50, right: 50),
                child: MaterialButton(
                  onPressed: () {
                    forgetPasswordProcess(controller.text);
                  },
                  shape: StadiumBorder(),
                  child: ButtonsDesign.buttonsText(
                      LocaleKeys.reset_password.tr(),
                      CustomColors().primaryWhiteColor),
                  color: CustomColors().primaryGreenColor,
                ))
          ],
        ),
      ),
    );
  }
////---------------------------

  void directToHomePage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return HomePage();
    }));
  }
////---------------------------

  void addBranchesPage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddBranchesPage();
    }));
  }
  ////---------------------------

  void forgetPasswordProcess(String userEmail) {
    if (userEmail != '') {
      isForgetPassBtnEnabled = false;

      print(userEmail);
      //----------show progress----------------

      showLoaderDialog(context);
      //----------start api ----------------
      RegisterRepository registerRepository = RegisterRepository();
      registerRepository.forgetPassword(userEmail).then((result) async {
        //-------- fail response ---------

        if (result == null ||
            result.apiStatus.code != ApiResponseType.OK.code) {
          /* if (result.apiStatus.code == ApiResponseType.BadRequest)*/
          Navigator.pop(context);
          showErrorDialog(result.message);
          return;
        }

        //-------- success response ---------

        Navigator.pop(context);
        Navigator.pop(context);

        Navigator.push(context, MaterialPageRoute(builder: (context) {
          isForgetPassBtnEnabled = true;
          return EnterCodePage(
            userEmail: userEmail,
          );
        }));
      });

      //    Navigator.pop(context, controller.text);
      //---------------
      /*     showDialog(
          builder: (BuildContext context ) =>
              showPinDialog(context ,userEmail,false),
          context: context).then((newPass) {
        if(newPass == success)
        {

        }
      });*/
    }
  }
}
