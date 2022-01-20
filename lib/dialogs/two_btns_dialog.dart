import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:khudrah_companies/resources/custom_colors.dart';

Widget showTwoBtnDialog(BuildContext context, String title, String txt,
    String btnTxt1, String btnTxt2, List<Function()> actions) {
  if (Platform.isIOS) {
    return CupertinoAlertDialog(
      title: Text(title), // To display the title it is optional
      content: Text(
        txt,
        textAlign: TextAlign.justify,
      ), // Message which will be pop up on the screen
      actions: twoBtnDialogBtns(context, btnTxt1, btnTxt2, actions),
    );
  } else {
    return AlertDialog(
      title: Text(title), // To display the title it is optional
      content: Text(
        txt,
        textAlign: TextAlign.justify,
      ), // Message which will be pop up on the screen
      actions: twoBtnDialogBtns(context, btnTxt1, btnTxt2, actions),
    );
  }
}
//------------------------------------

List<Widget> twoBtnDialogBtns(
    BuildContext context, String txt1, String txt2, List<Function()> actions) {
  return [
    flatBtn(context, txt1, CustomColors().redColor, actions.first),
    flatBtn(context, txt2, CustomColors().primaryGreenColor, actions.last),
  ];
}
//------------------------------------

Widget flatBtn(
    BuildContext context, String txt, Color color, Function() actions) {
  return FlatButton(
    textColor: color,
    onPressed: actions,
    child: Text(
      txt,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 10,
      ),
    ),
  );
}
