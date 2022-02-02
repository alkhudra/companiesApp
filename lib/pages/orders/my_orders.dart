import 'package:flutter/material.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/designs/appbar_design.dart';
import 'package:khudrah_companies/designs/drawar_design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:lottie/lottie.dart';

class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({ Key? key }) : super(key: key);

  @override
  _MyOrdersPageState createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //add body
      body: Center(
        child: Container(
          child: Lottie.asset(
             'images/anim_fruit.json',
              width: 300,
              height: 300,
              fit: BoxFit.fill,
          ),
        ),
      ),
      // endDrawer: drawerDesign(context),
      appBar: bnbAppBar(context, LocaleKeys.my_orders.tr()),
      endDrawer: drawerDesign(context),
    );
  }
}