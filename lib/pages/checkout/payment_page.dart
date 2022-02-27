import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/designs/appbar_design.dart';
import 'package:easy_localization/easy_localization.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool condition = true;
  @override
  Widget build(BuildContext context) {
    int appSize = condition == true ? 3 : 2;
    List<Widget> tabsList = condition == true
        ? [
            Tab(text: 'cash'),
            Tab(text: 'cash'),
            Tab(text: 'cash'),

          ]
        : [
            Tab(text: 'cash'),
            Tab(text: 'cash'),
          ];

    List<Widget> tabsView = condition == true
        ? [
            Icon(Icons.directions_car),
            Icon(Icons.directions_transit),
            Icon(Icons.directions_bike),

          ]
        : [
            Icon(Icons.directions_car),
            Icon(Icons.directions_transit),
          ];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: DefaultTabController(
        length: appSize,
        child: Scaffold(
          appBar:appBarDesignWithTabs(context, 'title',tabsList),
          body: TabBarView(
            children: tabsView,
          ),
        ),
      ),
    );
  }
}
