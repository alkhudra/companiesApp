

import 'package:flutter/material.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';

void showSuccessMessage(BuildContext context,String message){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message,style: TextStyle(
      color:  CustomColors().primaryWhiteColor,
    ),),
    backgroundColor: CustomColors().primaryGreenColor,
  ));
}