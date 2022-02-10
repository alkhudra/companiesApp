import 'package:flutter/material.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/designs/appbar_design.dart';
import 'package:khudrah_companies/designs/drawar_design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:khudrah_companies/designs/order_tile_design.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              height: 40,
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
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // first tab bar view widget 
                  GestureDetector(
                    child: orderTileDesign(context, scWidth, scHeight),
                    onTap: () {
                      // navigate to order status page
                    },
                  ),

                  // second tab bar view widget
                  Center(
                    child: Text(
                      'Buy Now',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // endDrawer: drawerDesign(context),
      appBar: bnbAppBar(context, LocaleKeys.my_orders.tr()),
      endDrawer: drawerDesign(context),
    );
  }
}


// Center(
//         child: Container(
//           child: Lottie.asset(
//              'images/anim_fruit.json',
//               width: 300,
//               height: 300,
//               fit: BoxFit.fill,
//           ),
//         ),
//       ),