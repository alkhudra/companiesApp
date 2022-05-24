import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/designs/ButtonsDesign.dart';
import 'package:khudrah_companies/designs/card_design.dart';
import 'package:khudrah_companies/designs/text_field_design.dart';
import 'package:khudrah_companies/pages/branch/add_brunches_page.dart';
import 'package:khudrah_companies/pages/auth/login_page.dart';
import 'package:khudrah_companies/pages/auth/sign_up_page.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


void startTimer(int _counter, StreamController<int> _events) {
  Timer.periodic(Duration(seconds: 1), (timer) {
    //setState(() {
    (_counter > 0) ? _counter-- : timer.cancel();
    //});
    print(_counter);
    _events.add(_counter);
  });
}



//-----
void resetPassword(
    BuildContext context,
    String code,
    TextEditingController controller,
    StreamController<ErrorAnimationType> errorController) {
  if (code == controller.text) {
    Navigator.pop(context);

    showDialog(
        builder: (BuildContext context) => showResetPasswordDialog(context),
        context: context);
  } else
    errorController.add(ErrorAnimationType.shake);
}
////---------------------------

Widget showResetPasswordDialog(BuildContext context) {
  final TextEditingController passController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

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
            margin: EdgeInsets.only(left: 20, right: 20),
            child: TextFormField(
              controller: passController,
              keyboardType: TextInputType.visiblePassword,
              style: TextStyle(
                  color: CustomColors().blackColor,
                  fontWeight: FontWeight.bold),
              decoration: textFieldDecorationWithIcon(
                  LocaleKeys.password.tr(), Icons.lock_outline),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (passController.text.isEmpty) {
                  return LocaleKeys.pass_required.tr();
                }
                if (confirmPassController.text == '') {
                  return LocaleKeys.confirm_pass_required.tr();
                }
                if (passController.text != confirmPassController.text) {
                  return LocaleKeys.not_match_pass.tr();
                }
              },
              controller: confirmPassController,
              keyboardType: TextInputType.visiblePassword,
              style: TextStyle(
                  color: CustomColors().blackColor,
                  fontWeight: FontWeight.bold),
              decoration: textFieldDecorationWithIcon(
                  LocaleKeys.confirm_pass.tr(), Icons.lock_outline),
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
                  if (passController.text != '' &&
                      confirmPassController.text != '') {
                    if (passController.text != confirmPassController.text) {
                    }
                  }
                },
                shape: StadiumBorder(),
                child: ButtonsDesign.buttonsText(LocaleKeys.reset_password.tr(),
                    CustomColors().primaryWhiteColor, 15),
                color: CustomColors().primaryGreenColor,
              ))
        ],
      ),
    ),
  );
}
