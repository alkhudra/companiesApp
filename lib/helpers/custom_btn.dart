import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/designs/ButtonsDesign.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'package:easy_localization/easy_localization.dart';

Widget greenBtn(
    String txt, EdgeInsetsGeometry edgeInsetsGeometry, Function() onPressed) {
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

Widget redBtn(
    String txt, EdgeInsetsGeometry edgeInsetsGeometry, Function() onPressed) {
  return Container(
      height: ButtonsDesign.buttonsHeight,
      margin: edgeInsetsGeometry,
      child: MaterialButton(
        onPressed: onPressed,
        shape: StadiumBorder(),
        child: ButtonsDesign.buttonsText(txt, CustomColors().primaryWhiteColor),
        color: CustomColors().redColor,
      ));
}

Widget greenBtnWithIcon(String txt, IconData icon,
    EdgeInsetsGeometry edgeInsetsGeometry, Function() onPressed) {
  return Container(
      height: ButtonsDesign.buttonsHeight,
      margin: edgeInsetsGeometry,
      decoration: BoxDecoration(),
      child: MaterialButton(
        onPressed: onPressed,
        shape: StadiumBorder(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: CustomColors().primaryWhiteColor,
            ),
            SizedBox(width: 15),
            ButtonsDesign.buttonsText(txt, CustomColors().primaryWhiteColor),
          ],
        ),
        color: CustomColors().primaryGreenColor,
      ));
}

Widget loadMoreBtn(BuildContext context, Function() onPressed) {
  return Container(
    margin: EdgeInsets.only(top:20),
    alignment: Alignment.bottomCenter,
    child: SizedBox(
      height: 45,
      width: 180,
      child: FloatingActionButton(
        child: Text(LocaleKeys.load_more.tr(), style: TextStyle(
            fontWeight: FontWeight.w600
        ),),
        onPressed: () {
         onPressed();
        },
        backgroundColor: CustomColors().grayColor,
        foregroundColor: CustomColors().darkBlueColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40)
        ),
        elevation: 0.0,
      ),
    ),
  );
}

Widget unAvailableBtn(String txt, EdgeInsetsGeometry edgeInsetsGeometry, double scHeight) {
  return Container(
    // height: ButtonsDesign.buttonsHeight,
    height: scHeight,
    margin: edgeInsetsGeometry,
    decoration: BoxDecoration(
      color: CustomColors().brownColor.withOpacity(0.8),
      borderRadius: BorderRadius.circular(35),
    ),
    child: ButtonsDesign.buttonsText(txt, CustomColors().primaryWhiteColor),
  );
}

Widget cartBtn(IconData icon,
    EdgeInsetsGeometry edgeInsetsGeometry, Function() onPressed) {
  return Container(
      height: 40,
      margin: edgeInsetsGeometry,
      decoration: BoxDecoration(),
      child: MaterialButton(
        onPressed: onPressed,
        shape: StadiumBorder(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: CustomColors().primaryWhiteColor,
              size: 26,
            ),
          ],
        ),
        color: CustomColors().primaryGreenColor,
      ));
}