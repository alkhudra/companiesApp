
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

Widget greeting(context ,String name) {
  return Container(
    width: MediaQuery.of(context).size.width*0.9,
    height: 25,
    margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.05),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          child: Text(LocaleKeys.welcome_back.tr(), 
            style: TextStyle(color: CustomColors().darkGrayColor,
            fontSize: 14),
          ),
        ),

        Container(
          margin: EdgeInsets.only(left: 2,right: 2),
           padding: EdgeInsets.only(left: 3, right: 3),
          child: Text(name,
            style: TextStyle(color: CustomColors().darkBlueColor,
            fontSize: 17.5,
            fontWeight: FontWeight.w700),
          ),
        ),
      ],
    ),
  );
}