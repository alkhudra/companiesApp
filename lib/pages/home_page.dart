import 'dart:developer';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/designs/appbar_design.dart';
import 'package:khudrah_companies/designs/category_item.dart';
import 'package:khudrah_companies/designs/drawar_design.dart';
import 'package:khudrah_companies/designs/greeting_text.dart';
import 'package:khudrah_companies/designs/product_card.dart';
import 'package:khudrah_companies/designs/search_bar.dart';
import 'package:khudrah_companies/designs/text_field_design.dart';
import 'package:khudrah_companies/dialogs/two_btns_dialog.dart';
import 'package:khudrah_companies/helpers/custom_btn.dart';
import 'package:khudrah_companies/network/models/branches/branch_model.dart';
import 'package:khudrah_companies/pages/branch/branch_list.dart';
import 'package:khudrah_companies/pages/categories/all_category.dart';
import 'package:khudrah_companies/pages/dashboard.dart';
import 'package:khudrah_companies/pages/trending_deals.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'dart:math' as math;

import 'branch/add_brunches_page.dart';
import 'package:easy_localization/easy_localization.dart';

import 'categories/fruit_category.dart';
import 'categories/veg_category.dart';

class HomePage extends StatefulWidget {
  //final bool isHasBranch;
  const HomePage({Key? key/*, required this.isHasBranch*/}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //------------------------
  // GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  int itemCounter = 0;
  double itemPrice = 9;
  String itemName = 'Avocado';

  void showAddBranchDialog() async {
    await Future.delayed(Duration(milliseconds: 50));
    List<Function()> actions = [
      () {
        addBranchesPage();
        //   Navigator.pop(context);
      },
      () {
        Navigator.pop(context);
      }
    ];
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => showTwoBtnDialog(
            context,
            LocaleKeys.add_branch.tr(),
            LocaleKeys.add_branch_note_dialog.tr(),
            LocaleKeys.add_branch_now.tr(),
            LocaleKeys.later.tr(),
            actions));
  }
  ////---------------------------

  void addBranchesPage() {
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddBranchesPage(addToList: (){},);
    }));
  }
  ////---------------------------

  @override
  void initState() {
    super.initState();
    ProductCard.counter = ProductCard.counter;

    //todo: show after calling api
  /*    if (widget.isHasBranch == false) {
      showAddBranchDialog();
    }*/
  }

  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    double scWidth = size.width;
    double scHeight = size.height;
    Widget fruitNav = FruitCategory();
    Widget vegNav = VegCategory();
    List<ListItem> _items = [
      ListItem(icon: 'images/fruits.png', navRoute: fruitNav),
      ListItem(icon: 'images/veg.png', navRoute: vegNav),
    ];
    

    //set appbar color, since homepage has no app bar
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        endDrawer: drawerDesign(context),
        appBar: homeAppBarDesign(context, LocaleKeys.home.tr()),
        // key: _scaffoldState,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 17,),
              //greeting user
              Container(
                child: greeting(context),
              ),
              SizedBox(height: 10,),
              //Search bar and button
              Container(
                child: searchBar(searchController),
              ),
              SizedBox(height: 20,),
              //Categories title
              Container(
                width: scWidth*15,
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Text(LocaleKeys.categories.tr(),
                  style: TextStyle(
                    color: CustomColors().darkBlueColor,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),),
              ),
              SizedBox(height: 10,),
              //Categories items
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //all category iconbutton
                    Container(
                      width: scWidth*0.27,
                      height: scHeight*0.16,
                      child: IconButton(icon: Image(image: AssetImage('images/fruitsnveg.png')), 
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                          builder: (context) => AllCategory()),
                          );
                        },
                      ),
                    ),
                    //fruit and veg categories iconbutton
                    Container(
                      width: scWidth*0.8,
                      height: scHeight*0.16,
                      child: ListView.builder(itemBuilder: (context, index) {
                            return Container(
                              // width: scWidth*0.23,
                              // height: scHeight*0.14,
                              //TODO: change to Network image
                              child: IconButton(icon: Image(image: AssetImage(_items[index].icon, )), 
                                onPressed: () {
                                  print(_items[index].navRoute);
                                  Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => _items[index].navRoute));
                                },
                                iconSize: 90,
                              ),
                            );
                      },
                      itemCount: _items.length,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              //Newest deals title and button
              Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                child: Text(LocaleKeys.newest_deals.tr(),
                  style: TextStyle(
                    color: CustomColors().darkBlueColor,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                  overflow: TextOverflow.ellipsis,),
              ),
              SizedBox(height: 10,),
              Container(
                child: ListView.builder(
                  //try keyboard dismissal
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  // scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ProductCard.productCardDesign(context, itemName, itemPrice, 
                    );
                  },
                  itemCount: 5,
                ),
              ),
              SizedBox(height: 30,),
            ],
          ),
        ),
      ),
    );
  }

  Widget searchBar(seController) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SizedBox(width: 10,),
          // Container(
          //   child: IconButton(
          //     icon: Icon(Icons.menu_rounded,),
          //     color: CustomColors().brownColor,
          //     iconSize: 33,
          //     onPressed: () {
          //       _scaffoldState.currentState!.openDrawer();
          //     },
          //   ),
          // ),
          SizedBox(width: 5,),
          Container(
            margin: EdgeInsets.only(left: 5, right: 5),
            width: MediaQuery.of(context).size.width/1.3,
            child: TextFieldDesign.textFieldStyle(
              context: context,
              verMarg: 2,
              horMarg: 0,
              controller: seController,
              kbType: TextInputType.text,
              lbTxt: LocaleKeys.search_term.tr(),
              obscTxt: false,
            ),
          ),
          SizedBox(width: 5,),
          GestureDetector(
            child: Container(
              padding: EdgeInsets.all(8.0),
              width: MediaQuery.of(context).size.width*0.08,
              height: MediaQuery.of(context).size.height*0.04,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/logo.png'),
                ),
              ),
            ),
            onTap: () {},
          ),
          SizedBox(width: 5,),

        ],
      ),
    );
  }
}

class ListItem {
  String icon;
  Widget navRoute;
  ListItem({
    required this.icon,
    required this.navRoute,
  });
}

                  // increaseCount: () {
                  //   setState(() {
                  //     ProductCard.counter >= 0 ? ProductCard.counter+=ProductCard.counter: ProductCard.counter;
                  //     print(ProductCard.counter);
                  //   });
                  // },
                  // decreaseCount: () {
                  //   ProductCard.counter >= 0 ? ProductCard.counter-=ProductCard.counter: ProductCard.counter;
                  //   print(ProductCard.counter);
                  // },
