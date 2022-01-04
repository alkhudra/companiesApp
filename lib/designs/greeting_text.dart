
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

Widget greeting(context) {
  return Container(
    width: MediaQuery.of(context).size.width*0.9,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10,),
        Container(
          child: Text(LocaleKeys.welcome_back.tr(), 
            style: TextStyle(color: CustomColors().darkGrayColor,
            fontSize: 14),
          ),
        ),
        SizedBox(height: 5,),
        Container(
          padding: EdgeInsets.only(left: 5, right: 5),
          child: Text('Username', 
            style: TextStyle(color: CustomColors().darkBlueColor,
            fontSize: 18,
            fontWeight: FontWeight.w800),
          ),
        ),
      ],
    ),
  );
}