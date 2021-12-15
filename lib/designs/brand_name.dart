import 'package:flutter/material.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';


Widget brandName(logoW, logoH, fontS) {
  return Column(
    children: [
      //company logo
      Container(
        width: logoW,
        height: logoH,
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/logo.png')
            )
        ),
      ),
      SizedBox(height: 20,),
      //company name
      RichText(
        text: TextSpan(
            style: TextStyle(
              fontSize: fontS,
              fontWeight: FontWeight.bold,
              color: CustomColors().primaryGreenColor,
            ),
            children: <TextSpan> [
              TextSpan(text: "Alkhudra United"),
            ]
        ),
      ),
    ],
  );
}

Widget brandNameMiddle(){
  return Container(
    margin: EdgeInsets.only(top: 50),
    alignment: Alignment.topCenter,
    child: brandName(115.0, 115.0, 20.0),
  );
}