import 'package:flutter/cupertino.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';

Widget noItemDesign(String txt, String imageUrl) {
  return Column(
    children: [
      Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        width: 250,
        height: 200,
        child: Center(child: Image.asset(imageUrl)),
      ),
      // SizedBox(height: 10,),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Center(
            child: Text(
          txt,
          style: TextStyle(
              fontSize: 20,
              height: 1.5,
              color: CustomColors().primaryGreenColor),
        )),
      ),
    ],
  );
}
