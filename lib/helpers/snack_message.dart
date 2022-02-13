import 'package:flutter/material.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'package:easy_localization/easy_localization.dart';
void showSuccessMessage(BuildContext context,String message){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration:Duration( seconds: 3),
    content: Text(message,style: TextStyle(
      color:  CustomColors().primaryWhiteColor,
    ),),
    backgroundColor: CustomColors().primaryGreenColor,
    behavior: SnackBarBehavior.floating,
  ));
}

void showWarningMessage(BuildContext context ,String message){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration:Duration( days: 300),
    content: Text(message,style: TextStyle(
      color:  CustomColors().primaryWhiteColor,
    ),),
    backgroundColor: CustomColors().primaryGreenColor,
    action: SnackBarAction(
      label: LocaleKeys.undo.tr(), onPressed:(){
      Scaffold.of(context).hideCurrentSnackBar();
    }
    ,
    ),
    behavior: SnackBarBehavior.floating,

  ));
}