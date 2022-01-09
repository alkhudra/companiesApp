//-------------------------

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/designs/ButtonsDesign.dart';
import 'package:khudrah_companies/designs/card_design.dart';
import 'package:khudrah_companies/designs/text_field_design.dart';
import 'package:khudrah_companies/helpers/forget_pass_helper.dart';
import 'package:khudrah_companies/helpers/info_correcter_helper.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'package:easy_localization/easy_localization.dart';

Widget showEnterEmailDialog(BuildContext context,bool isForgetPassBtnEnabled) {
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
                  if(isForgetPassBtnEnabled)
                    forgetPasswordProcess(context,controller.text,isForgetPassBtnEnabled);
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