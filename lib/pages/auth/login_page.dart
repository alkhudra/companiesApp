import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:khudrah_companies/Constant/conts.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/designs/ButtonsDesign.dart';
import 'package:khudrah_companies/designs/brand_name.dart';
import 'package:khudrah_companies/designs/card_design.dart';
import 'package:khudrah_companies/designs/text_field_design.dart';
import 'package:khudrah_companies/dialogs/message_dialog.dart';
import 'package:khudrah_companies/dialogs/passowrd_dialog.dart';
import 'package:khudrah_companies/dialogs/progress_dialog.dart';
import 'package:khudrah_companies/dialogs/two_btns_dialog.dart';
import 'package:khudrah_companies/helpers/custom_btn.dart';
import 'package:khudrah_companies/helpers/forget_pass_helper.dart';
import 'package:khudrah_companies/helpers/info_correcter_helper.dart';
import 'package:khudrah_companies/helpers/pref/shared_pref_helper.dart';
import 'package:khudrah_companies/helpers/route_helper.dart';
import 'package:khudrah_companies/network/API/api_response_type.dart';
import 'package:khudrah_companies/network/models/auth/fail_login_response_model.dart';
import 'package:khudrah_companies/network/models/auth/forget_password_response_model.dart';
import 'package:khudrah_companies/network/models/auth/success_login_response_model.dart';
import 'package:khudrah_companies/network/models/user_model.dart';
import 'package:khudrah_companies/network/helper/network_helper.dart';
import 'package:khudrah_companies/network/repository/auth_repository.dart';
import 'package:khudrah_companies/pages/dashboard.dart';
import 'package:khudrah_companies/pages/home_page.dart';
import 'package:khudrah_companies/pages/reset_password/enter_code_page.dart';
import 'package:khudrah_companies/pages/auth/sign_up_page.dart';
import 'package:khudrah_companies/provider/product_provider.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:khudrah_companies/router/route_constants.dart';
import 'package:provider/provider.dart';

import '../branch/add_brunches_page.dart';

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
  static bool isHasBranches = false;

  @override
  void initState() {
    super.initState();
    print('welcome in log in  ');
  }

  @override
  Widget build(BuildContext context) {
    Size? size = MediaQuery.of(context).size;
    double scWidth = size.width;
    double scHeight = size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: CustomColors().backgroundColor,
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 120, left: 30, right: 30),
            width: MediaQuery.of(context).size.width / 0.3,
            height: MediaQuery.of(context).size.height / 1.8,
            decoration: CardDesign.largeCardDesign(),
          ),
          // SizedBox(
          //   height: 10,
          // ),
          brandNameMiddle(),
          // SizedBox(
          //   height: 10,
          // ),
          Container(
            margin: EdgeInsets.only(
                top: scHeight * 0.13,
                right: scWidth * 0.1,
                left: scWidth * 0.1),
            // padding: EdgeInsets.symmetric(horizontal: scWidth/9, vertical: scHeight/5),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: scHeight * 0.19,
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
                SizedBox(
                  height: 3,
                ),
                TextFieldDesign.textFieldStyle(
                  context: context,
                  verMarg: 5,
                  horMarg: 0,
                  controller: passController,
                  kbType: TextInputType.visiblePassword,
                  obscTxt: true,
                  lbTxt: LocaleKeys.password.tr(),
                ),
                SizedBox(
                  height: scHeight / 20,
                ),
                Container(
                    height: scHeight / 30,
                    padding: EdgeInsets.only(right: 10, left: 10),
                    child: GestureDetector(
                      onTap: () {
                        if (isForgetPassBtnEnabled)
                          showDialog(
                              builder: (BuildContext context) =>
                                  showEnterEmailDialog(
                                      context, isForgetPassBtnEnabled),
                              context: context);
                      },
                      child: Text(LocaleKeys.forget_pass.tr(),
                          style: TextStyle(
                              color: CustomColors().primaryGreenColor)),
                    )),
                Container(
                    height: scHeight / 33,
                    padding: EdgeInsets.only(right: 10, left: 10),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(context,
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
                SizedBox(
                  height: scHeight * 0.065,
                ),
                greenBtn(LocaleKeys.log_in.tr(),
                    EdgeInsets.only(left: 50, right: 50), () {
                  if (isBtnEnabled) logIn();
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardPage(isHasBranch: true)));
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //-------------------------
  void showErrorDialog(String txt) {
    isForgetPassBtnEnabled = true;
    isBtnEnabled = true;
    showDialog<String>(
        context: context,
        builder: (BuildContext context) =>
            showMessageDialog(context, LocaleKeys.error.tr(), txt, noPage));
  }

  ////---------------------------

  void logIn() async {
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
   // String? token;
  //  FirebaseMessaging.instance.getToken().onError((error, stackTrace) => token = '').then((value) => token = value);
    String? token = await FirebaseMessaging.instance.getToken();
    print('notification token is $token');
    Map<String, dynamic> headerMap = await getAuthHeaderMap();

    AuthRepository registerRepository = AuthRepository(headerMap);


    registerRepository
        .loginUser(
            emailController.text, passController.text, token)
        .then((result) async {
      //-------- fail response ---------

      if (result.apiStatus.code != ApiResponseType.OK.code) {
        Navigator.pop(context);
        showErrorDialog(result.message);
        return;
      }

      //-------- success response ---------
      SuccessLoginResponseModel model =
          SuccessLoginResponseModel.fromJson(result.result);

      //check if account is not deleted
      if(model.user!.isDeleted == true){
        Navigator.pop(context);
        showErrorDialog(LocaleKeys.deleted_account.tr());
        return;
      }

      print(model.user.toString());
      User user = model.user!;

      PreferencesHelper.setUserID(user.id!);
      PreferencesHelper.getUserID.then((value) => print('user id : $value'));

      PreferencesHelper.setUserToken(model.token);
      PreferencesHelper.getUserToken.then((value) => print('token : $value'));
      Provider.of<ProductProvider>(context, listen: false).setUser(user);

      PreferencesHelper.setUser(user);
      PreferencesHelper.setUserLoggedIn(true);
      PreferencesHelper.setUserFirstLogIn(false);
      isHasBranches = user.branches!.isNotEmpty;
      Navigator.pop(context);
      String name = user.companyName!;
      directToHomePage(name);
    });
  }

////---------------------------

  void directToHomePage(String name) {
    moveToNewStack(context, dashBoardRoute);

    SchedulerBinding.instance?.addPostFrameCallback((_) {
      Flushbar(
        // title: "Hey User",
        message: LocaleKeys.welcome_back.tr() + " $name",
        flushbarPosition: FlushbarPosition.BOTTOM,
        duration: Duration(seconds: 3),
        backgroundColor: CustomColors().primaryGreenColor.withOpacity(0.8),
      )..show(context);
    });
  }

  ////---------------------------

}
