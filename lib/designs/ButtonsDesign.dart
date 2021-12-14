import 'package:flutter/material.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';

class ButtonsDesign {
  static const double buttonsHeight = 50;

  static TextStyle buttonsTextStyle() {
    return TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: CustomColors().primaryWhiteColor,
    );
  }

  static Center buttonsText(String txt) {
    return Center(
        child:
            Text(txt.toUpperCase(), style: ButtonsDesign.buttonsTextStyle()));
  }
}
