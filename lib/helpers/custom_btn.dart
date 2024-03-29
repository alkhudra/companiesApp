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
        child: ButtonsDesign.buttonsText(
            txt, CustomColors().primaryWhiteColor, 15),
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
        child: ButtonsDesign.buttonsText(
            txt, CustomColors().primaryWhiteColor, 15),
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
            ButtonsDesign.buttonsText(
                txt, CustomColors().primaryWhiteColor, 15),
          ],
        ),
        color: CustomColors().primaryGreenColor,
      ));
}

Widget loadMoreBtn(
    BuildContext context, onPressed, double topMarg, double botMarg) {
  return Container(
    margin: EdgeInsets.only(top: topMarg, bottom: botMarg),
    alignment: Alignment.bottomCenter,
    child: SizedBox(
      height: 45,
      width: 180,
      child: FloatingActionButton(
        heroTag: 'LoadMore',
        child: Text(
          LocaleKeys.load_more.tr(),
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        onPressed: onPressed,
        backgroundColor: CustomColors().grayColor,
        foregroundColor: CustomColors().darkBlueColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        elevation: 0.0,
      ),
    ),
  );
}

Widget unAvailableBtn() {
  return Container(
    height: 40,
    width: 100,
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
    decoration: BoxDecoration(
      color: CustomColors().darkGrayColor,
      borderRadius: BorderRadius.circular(30),
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ButtonsDesign.buttonsText(LocaleKeys.not_available_product.tr(),
          CustomColors().primaryWhiteColor, 11.6),
    ),
  );
}

Widget cartBtn(Function() onPressed) {
  return Container(
      height: 40,
      width: 80,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(),
      child: MaterialButton(
        onPressed: onPressed,
        shape: StadiumBorder(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart,
              color: CustomColors().primaryWhiteColor,
              size: 26,
            ),
          ],
        ),
        color: CustomColors().primaryGreenColor,
      ));
}

payButtonDesign(context, color, text, iconData) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.27,
    height: MediaQuery.of(context).size.height * 0.094,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: color)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          iconData,
          color: color,
          size: 25,
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          child: Text(
            text,
            style: TextStyle(color: color, fontSize: 13),
          ),
        )
      ],
    ),
  );
}
