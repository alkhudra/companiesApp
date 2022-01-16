import 'package:flutter/material.dart';

Widget categoryItem(context, {img, nav}) {

  Size size = MediaQuery.of(context).size;
  double scWidth = size.width;
  double scHeight = size.height;

  return Container(
    width: scWidth*0.16,
    height: scHeight*0.13,
    child: IconButton(
      icon: img,
      onPressed: nav
    ),
  );
  // return Container(
  //   width: scWidth*0.16,
  //   height: scHeight*0.13,
  //   decoration: BoxDecoration(
  //     image: DecorationImage(
  //       image: AssetImage(img),
  //     ),
  //   ),
  // );
}