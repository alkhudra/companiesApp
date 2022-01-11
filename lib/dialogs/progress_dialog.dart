import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';

showLoaderDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      if (Platform.isIOS)
        return iosProgress();
      else
        return androidProgress();
    },
  );
}

AlertDialog androidProgress() {
  return AlertDialog(
    content:alertContent(),
  );
}

CupertinoAlertDialog iosProgress() {
  return CupertinoAlertDialog(
    content:alertContent(),
  );
}


Widget alertContent(){
 return Column(
   mainAxisSize: MainAxisSize.min,
    children: [
      CircularProgressIndicator(color: CustomColors().primaryGreenColor,),
      SizedBox(
        height: 5,
      ),
      Container(child: Text(LocaleKeys.wait.tr())),
    ],
  );
}
