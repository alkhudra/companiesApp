import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/pages/Notifications_page.dart';
import 'package:khudrah_companies/pages/cart_page.dart';
import 'package:khudrah_companies/pages/favorites_page.dart';
import 'package:khudrah_companies/pages/home_page.dart';
import 'package:khudrah_companies/pages/orders/my_orders.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';

class DashboardPage extends StatefulWidget {
  final bool isHasBranch;
  const DashboardPage({ Key? key, required this.isHasBranch}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  int currentTab = 0;
  // late bool branchStatus = widget.isHasBranch;

  late bool branchStatus;
  final PageStorageBucket bucket = PageStorageBucket();
  final List<Widget> screens = [
    HomePage(isHasBranch: true),
    FavoritesPage(),
    CartPage(),
    MyOrdersPage(),
    NotificationsPage()
  ];
  Widget currentScreen = HomePage(isHasBranch: false);

  @override
  void initState() {
    // TODO: implement initState
    branchStatus = widget.isHasBranch;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton: FloatingActionButton(
        //replace with logo icon
        child: ImageIcon(
          AssetImage('images/logo.png'),
          size: 35,
        ),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 6,
        child: Container(
          height: 55,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Left tab bar icons
                  MaterialButton(
                    minWidth: 30,
                    onPressed: () {
                      setState(() {
                        //ishasbranch could be set to false later
                        currentScreen = HomePage(isHasBranch: widget.isHasBranch);
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home_rounded,
                          color: currentTab == 0 
                          ? CustomColors().primaryGreenColor 
                          : CustomColors().grayColor,
                        ),
                        Text(
                          LocaleKeys.home.tr(),
                          style: TextStyle(
                            fontSize: 14,
                            color: currentTab == 0 
                            ? CustomColors().primaryGreenColor 
                            : CustomColors().grayColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 30,
                    onPressed: () {
                      setState(() {
                        currentScreen = NotificationsPage();
                        currentTab = 4;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.notifications_rounded,
                          color: currentTab == 4 
                          ? CustomColors().primaryGreenColor 
                          : CustomColors().grayColor,
                        ),
                        Text(
                          LocaleKeys.notifications.tr(),
                          style: TextStyle(
                            fontSize: 14,
                            color: currentTab == 4 
                            ? CustomColors().primaryGreenColor 
                            : CustomColors().grayColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              //Right tab bar icons
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Left tab bar icons
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = MyOrdersPage();
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_basket_rounded,
                          color: currentTab == 3 
                          ? CustomColors().primaryGreenColor 
                          : CustomColors().grayColor,
                        ),
                        Text(
                          LocaleKeys.my_orders.tr(),
                          style: TextStyle(
                            fontSize: 14,
                            color: currentTab == 3 
                            ? CustomColors().primaryGreenColor 
                            : CustomColors().grayColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = FavoritesPage();
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.favorite,
                          color: currentTab == 1 
                          ? CustomColors().primaryGreenColor 
                          : CustomColors().grayColor,
                        ),
                        Text(
                          LocaleKeys.favorites.tr(),
                          style: TextStyle(
                            fontSize: 14,
                            color: currentTab == 1 
                            ? CustomColors().primaryGreenColor 
                            : CustomColors().grayColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}