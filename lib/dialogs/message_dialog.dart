
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/main.dart';
import 'package:khudrah_companies/pages/auth/login_page.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:khudrah_companies/router/route_constants.dart';

Widget showMessageDialog(BuildContext context, String title, String txt,String pageRout) {
  if (Platform.isIOS) {
    return CupertinoAlertDialog(
      title: Text(title), // To display the title it is optional
      content: Text(txt), // Message which will be pop up on the screen
      actions: [
        if(pageRout != noPage)
          directToLoginPageBtns(context,pageRout)
        else
        messageDialogBtns(context ),
      ],
    );
  } else {
    return AlertDialog(
      title: Text(title), // To display the title it is optional
      content: Text(txt), // Message which will be pop up on the screen
      actions: [
        if(pageRout != noPage)
          directToLoginPageBtns(context,pageRout)
        else
          messageDialogBtns(context ),
      ],
    );
  }
}

//------------------------------------
FlatButton messageDialogBtns(BuildContext context) {
  return FlatButton(
    textColor: CustomColors().primaryGreenColor,
    onPressed: () {
      Navigator.pop(context);
      },
    child: Text(
      LocaleKeys.ok.tr(),
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
  );
}
//------------------------------------


FlatButton directToLoginPageBtns(BuildContext context,String route) {

  return FlatButton(
    textColor: CustomColors().primaryGreenColor,
    onPressed: () {
      Navigator.pop(context);
      if(route == loginRoute){
        Navigator.push(context,
            MaterialPageRoute(builder: (context) {
              return LogInPage();
            }));
      }else {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) {
              return MyApp();
            }));
      }


    },
    child: Text(
      LocaleKeys.ok.tr(),
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
  );
}


void showErrorMessageDialog(BuildContext context ,String txt) {
  showDialog<String>(
      context: context,
      builder: (BuildContext context) =>
          showMessageDialog(context, LocaleKeys.error.tr(), txt, noPage));
}