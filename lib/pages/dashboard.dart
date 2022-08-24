import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/pages/notifications_page.dart';
import 'package:khudrah_companies/pages/cart/cart_page.dart';
import 'package:khudrah_companies/pages/favorite/favorites_page.dart';
import 'package:khudrah_companies/pages/home_page.dart';
import 'package:khudrah_companies/pages/orders/order_list.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';

class DashboardPage extends StatefulWidget {

  const DashboardPage(
      {Key? key,})
      : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late bool branchStatus;
  final PageStorageBucket bucket = PageStorageBucket();
  final List<Widget> screens = [
    HomePage(),
    FavoritesPage(),
    CartPage(),
    OrderList(),
    NotificationsPage()
  ];

  @override
  void initState() {
    super.initState();
    print('welcome in dashboard ');
  }

   Widget currentScreen = HomePage();
   int currentTab = 0 ;

  @override
  Widget build(BuildContext context) {
    //print('current screen  $currentScreen');

    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'HomeFAB',
        child: ImageIcon(
          AssetImage('images/logo.png'),
          size: 35,
        ),
        onPressed: () {
          setState(() {
            currentScreen = CartPage();
            currentTab = 2;
          });
          print('current screen  $currentScreen');
        },
        elevation: 0.0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 4,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 55,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Left tab bar icons
                  MaterialButton(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    minWidth: 10,
                    onPressed: () {
                      setState(() {
                        //ishasbranch could be set to false later
                        currentScreen = HomePage();
                        currentTab = 0;
                      });
                      print('current screen  $currentScreen');
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
                            fontSize: 13,
                            color: currentTab == 0
                                ? CustomColors().primaryGreenColor
                                : CustomColors().grayColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    minWidth: 20,
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
                            fontSize: 13,
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
              Container(
                alignment: Alignment.bottomCenter,
                child: Text(
                  LocaleKeys.cart.tr(),
                  style: TextStyle(
                    color: currentTab == 2
                        ? CustomColors().primaryGreenColor
                        : CustomColors().grayColor,
                  ),
                ),
              ),
              SizedBox(
                width: 6,
              ),
              //Right tab bar icons
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Left tab bar icons
                  MaterialButton(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    minWidth: 20,
                    onPressed: () {
                      setState(() {
                        currentScreen = OrderList();
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
                            fontSize: 13,
                            color: currentTab == 3
                                ? CustomColors().primaryGreenColor
                                : CustomColors().grayColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    minWidth: 20,
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
                            fontSize: 13,
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
