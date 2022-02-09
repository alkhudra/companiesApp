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
    margin: EdgeInsets.only(bottom: 20),
    width: MediaQuery.of(context).size.width * 0.8,
    height: MediaQuery.of(context).size.height * 0.05,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      color: CustomColors().grayColor,
    ),
    child: TextButton(
        onPressed: onPressed,
        child: Text(
          LocaleKeys.load_more.tr(),
          style: TextStyle(
              color: CustomColors().darkBlueColor, fontWeight: FontWeight.w600),
        )),
  );
}

Widget unAvailableBtn(String txt, EdgeInsetsGeometry edgeInsetsGeometry) {
  return Container(
    height: ButtonsDesign.buttonsHeight,
    margin: edgeInsetsGeometry,
    decoration: BoxDecoration(
      color: CustomColors().brownColor,
      borderRadius: BorderRadius.circular(30),
    ),
    child: ButtonsDesign.buttonsText(txt, CustomColors().primaryWhiteColor),
  );
}
