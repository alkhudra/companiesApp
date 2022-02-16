import 'package:flutter/material.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/designs/appbar_design.dart';
import 'package:khudrah_companies/designs/drawar_design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:khudrah_companies/designs/order_tile_design.dart';
import 'package:khudrah_companies/pages/orders/order_status.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'package:lottie/lottie.dart';

class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({ Key? key }) : super(key: key);

  @override
  _MyOrdersPageState createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> with SingleTickerProviderStateMixin{

  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    double scWidth = size.width;
    double scHeight = size.height;

    return Scaffold(
      //add body
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Container(
              height: 40,
              width: 320,
              decoration: BoxDecoration(
                // color: CustomColors().primaryWhiteColor,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: CustomColors().primaryGreenColor)
              ),
              child: TabBar(
                controller: _tabController,
                // give the indicator a decoration (color and border radius)
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: CustomColors().primaryGreenColor,
                ),
                labelColor: CustomColors().primaryWhiteColor,
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Almarai',
                  fontSize: 16
                ),
                unselectedLabelColor: CustomColors().darkBlueColor,
                tabs: [
                  // first tab [you can add an icon using the icon property]
                  Tab(
                    text: LocaleKeys.current_orders.tr(),
                  ),

                  // second tab [you can add an icon using the icon property]
                  Tab(
                    text: LocaleKeys.complete_orders.tr(),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10,),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // first tab bar view widget 
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20,),
                  child: ListView.builder(
                      itemBuilder: ((context, index) {
                        return orderTileDesign(context, scWidth, scHeight);
                      }),
                      itemCount: 10,
                    ),
                ),


                // second tab bar view widget
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: ListView.builder(
                    itemBuilder: ((context, index) {
                      return orderTileDesign(context, scWidth, scHeight);
                    }),
                    itemCount: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      // endDrawer: drawerDesign(context),
      appBar: bnbAppBar(context, LocaleKeys.my_orders.tr()),
      endDrawer: drawerDesign(context),
    );
  }
}
