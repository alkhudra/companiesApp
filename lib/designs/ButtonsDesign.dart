import 'package:flutter/material.dart';


class ButtonsDesign {
  static const double buttonsHeight = 50;

  static TextStyle buttonsTextStyle(Color color) {
    return TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold,
      color: color,
    );
  }

  static Center buttonsText(String txt , Color color) {
    return Center(
        child:
            Text(txt.toUpperCase(), style: ButtonsDesign.buttonsTextStyle(color)));
  }
}