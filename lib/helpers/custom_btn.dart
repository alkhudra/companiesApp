import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khudrah_companies/designs/ButtonsDesign.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';

Widget greenBtn(String txt,EdgeInsetsGeometry edgeInsetsGeometry, Function() onPressed) {
  return Container(
      height: ButtonsDesign.buttonsHeight,
      margin: edgeInsetsGeometry,

      child: MaterialButton(
        onPressed: onPressed,
        shape: StadiumBorder(),
        child: ButtonsDesign.buttonsText(txt, CustomColors().primaryWhiteColor),
        color: CustomColors().primaryGreenColor,
      ));
}


Widget greenBtnWithIcon(String txt,IconData icon,EdgeInsetsGeometry edgeInsetsGeometry, Function() onPressed) {
  return Container(
      height: ButtonsDesign.buttonsHeight,
      margin: edgeInsetsGeometry,
      decoration: BoxDecoration(

      ),
      child: MaterialButton(

        onPressed: onPressed,
        shape: StadiumBorder(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
         Icon(icon ,color: CustomColors().primaryWhiteColor,),
            SizedBox(width: 15),
            ButtonsDesign.buttonsText(txt, CustomColors().primaryWhiteColor),
          ],
        ),
        color: CustomColors().primaryGreenColor,
      ));
}

