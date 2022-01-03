import 'package:flutter/material.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';

class TextFieldDesign {

  static textFieldStyle({context, double? verMarg, double? horMarg, TextEditingController? controller, TextInputType? kbType, String? lbTxt, validat, enabled}) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: horMarg!, vertical: verMarg!),
      width: MediaQuery.of(context).size.width/1.15,
      height: MediaQuery.of(context).size.height/15,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(60),
        border: Border.all(color: CustomColors().primaryGreenColor,
            width: 1.5),
      ),
      child: Expanded(
        child: TextFormField(
         enabled: enabled,
          controller: controller,
          keyboardType: kbType,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validat,
          style: TextStyle(
              color: CustomColors().blackColor,
              fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            labelText: lbTxt,
            labelStyle: TextStyle(
                color: CustomColors().blackColor.withOpacity(0.7),
                fontSize: 16,
                fontWeight: FontWeight.w400
            ),

            contentPadding: EdgeInsets.only(left: 20,right: 20),

            focusColor: CustomColors().blackColor,
            border: InputBorder.none,
            counterText: "",
          ),
        ),
      ),
    );
  }

}
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
