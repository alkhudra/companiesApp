import 'package:flutter/material.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';

class ButtonsDesign {
  static ButtonStyle roundedButtons() {
    return ButtonStyle(

        backgroundColor:
            MaterialStateProperty.all<Color>(CustomColors().primaryGreenColor),
        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: CustomColors().primaryGreenColor))));
  }


  static TextStyle buttonsTextStyle(){
    return TextStyle(
    fontSize: 16,
      fontWeight: FontWeight.bold,
      color: CustomColors().primaryWhiteColor,
    );
  }

  static TextButton buttonsTextAction(String txt , VoidCallback action){
    return TextButton(
        child: Text(
            txt.toUpperCase(),
            style: ButtonsDesign.buttonsTextStyle()
        ),
        style: ButtonsDesign.roundedButtons(),

        onPressed: () =>  {

          action

        }

    );
  }


}
