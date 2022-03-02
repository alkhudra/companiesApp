import 'package:flutter/material.dart';


class ButtonsDesign {
  static const double buttonsHeight = 50;

  static TextStyle buttonsTextStyle(Color color, double tSize) {
    return TextStyle(
      fontSize: tSize,
      fontWeight: FontWeight.bold,
      color: color,
    );
  }

  static Center buttonsText(String txt , Color color, double txtSize) {
    return Center(
        child:
            Text(txt.toUpperCase(), style: ButtonsDesign.buttonsTextStyle(color, txtSize), maxLines: 1));
  }
}