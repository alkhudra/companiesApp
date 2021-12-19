import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'package:easy_localization/easy_localization.dart';

Widget showMessageDialog(BuildContext context, String title, String txt) {
  if (Platform.isIOS) {
    return CupertinoAlertDialog(
      // backgroundColor: CustomColors().cardBackgroundColor1,
      title: Text(title), // To display the title it is optional
      content: Text(txt), // Message which will be pop up on the screen
      actions: [
        dialogBtn(context),
      ],
    );
  } else {
    return AlertDialog(
      // backgroundColor: CustomColors().cardBackgroundColor1,
      title: Text(title), // To display the title it is optional
      content: Text(txt), // Message which will be pop up on the screen
// Action widget which will provide the user to acknowledge the choice
      actions: [
        dialogBtn(context),
      ],
    );
  }
}

FlatButton dialogBtn(BuildContext context) {
  return FlatButton(
    textColor: CustomColors().primaryGreenColor,
    onPressed: () {
      Navigator.pop(context, LocaleKeys.cancel.tr());
    },
    child: Text(
      LocaleKeys.okay.tr(),
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
  );
}

////--------------------------
Container showPasswordDialog() {
  return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 100),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: CustomColors().cardShadowBackgroundColor,
              offset: Offset(0.2, 6.0),
              blurRadius: 6.0,
              spreadRadius: -2.0),
        ],
        borderRadius: BorderRadius.circular(50),
        color: CustomColors().cardBackgroundColor1,
        border: Border.all(color: CustomColors().cardBackgroundColor),
      ),
      child: (Center()));
}
