import 'package:flutter/material.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';

InputDecoration textFieldDecorationWithIcon(String hint, IconData icon) {
  return InputDecoration(
    contentPadding: EdgeInsets.all(20),
    focusColor: CustomColors().primaryGreenColor,
    hintText: hint,
    hintStyle: TextStyle(color: CustomColors().grayColor),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50.0),
      borderSide:
          BorderSide(color: CustomColors().primaryGreenColor, width: 1.0),
    ),
    prefixIcon: Icon(
      icon,
      color: CustomColors().grayColor,
    ),
  );
}

//-----------------------------------------

InputDecoration textFieldDecoration(String hint) {
  return InputDecoration(
    contentPadding: EdgeInsets.all(20),
    focusColor: CustomColors().primaryGreenColor,
    hintText: hint,
    hintStyle: TextStyle(color: CustomColors().grayColor),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50.0),
      borderSide:
          BorderSide(color: CustomColors().primaryGreenColor, width: 1.0),
    ),
  );
}
