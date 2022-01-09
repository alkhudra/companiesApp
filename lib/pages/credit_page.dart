import 'package:flutter/material.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/designs/appbar_design.dart';
import 'package:khudrah_companies/designs/drawar_design.dart';
import 'package:easy_localization/easy_localization.dart';

class CreditPage extends StatefulWidget {
  const CreditPage({ Key? key }) : super(key: key);

  @override
  _CreditPageState createState() => _CreditPageState();
}

class _CreditPageState extends State<CreditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //add body
      endDrawer: drawerDesign(context),
      appBar: appBarDesign(context, LocaleKeys.credit.tr()),
    );
  }
}