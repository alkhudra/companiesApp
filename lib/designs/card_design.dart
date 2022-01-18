import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khudrah_companies/designs/brand_name.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';

class CardDesign {
  static const double cardsHeight = 350;
  static const double cardsWidth = 400;

  static BoxDecoration largeCardDesign() {
    return BoxDecoration(
      boxShadow: [
        BoxShadow(
            color: CustomColors().cardShadowBackgroundColor,
            offset: Offset(0.2, 6.0),
            blurRadius: 6.0,
            spreadRadius: -2.0),
      ],
      borderRadius: BorderRadius.circular(50),
      color: CustomColors().cardBackgroundColor1,
      border: Border.all(color: CustomColors().cardBackgroundColor1),
    );
  }

  static Container brandCardDesign(scWidth, scHeight) {
    return Container(
      child: Stack(
        children: [
          Container(
            width: scWidth,
            height: scHeight,
            margin: EdgeInsets.only(top: 120),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: CustomColors().cardShadowBackgroundColor,
                    offset: Offset(0.2, 6.0),
                    blurRadius: 6.0,
                    spreadRadius: -2.0),
              ],
              borderRadius: BorderRadius.circular(50),
              color: CustomColors().cardBackgroundColor1,
              // color: CustomColors().brownColor,
              border: Border.all(color: CustomColors().cardBackgroundColor1),
            ),
            // child: brandNameMiddle(),
          ),
          Container(
            alignment: Alignment.topCenter,
            child: brandNameMiddle(),
          ),
        ],
      ),
    );
  }
}