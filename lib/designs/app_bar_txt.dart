import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';

PreferredSizeWidget appBarText(String txt, bool backBtnEnabled, {actions}) {
  return AppBar(
    actions: actions,
    centerTitle: true,
    backgroundColor: CustomColors().backgroundColor,
    automaticallyImplyLeading: backBtnEnabled,
    iconTheme: IconThemeData(
      color: CustomColors().darkBlueColor,
    ),
    title: Text(
      txt.toUpperCase(),
      style: TextStyle(color: CustomColors().darkBlueColor),
    ),
  );
}
