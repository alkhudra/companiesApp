import 'package:flutter/material.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'package:easy_localization/easy_localization.dart';

Widget loadMoreBut(context) {
  Size size = MediaQuery.of(context).size;
  double scWidth = size.width;
  double scHeight = size.height;
  
  return Container(
    width: scWidth*0.9,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      color: CustomColors().cardShadowBackgroundColor,
    ),
    child: TextButton(
      onPressed: () {
        //add progress loader while loading more results
      },
      child: Text(LocaleKeys.load_more.tr(), 
      style: TextStyle(
        color: CustomColors().darkBlueColor,
        fontSize: 16,
        fontWeight: FontWeight.w700
      ),)),
    );
}