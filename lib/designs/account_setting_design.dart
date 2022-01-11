import 'package:flutter/material.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'dart:math' as math;

Widget accountRowDesign(settingTxt,{nav}) {
  return GestureDetector(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Text(settingTxt,
          style: TextStyle(
            color: CustomColors().primaryGreenColor,
            fontWeight: FontWeight.w600,
            fontSize: 18
          ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(math.pi),
            child: Icon(Icons.arrow_back_ios, 
            color: CustomColors().primaryGreenColor,),
          ),
        ),
      ],
    ),
    onTap: nav,
  );
}