import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/designs/drawar_design.dart';
import 'package:khudrah_companies/designs/greeting_text.dart';
import 'package:khudrah_companies/designs/product_card.dart';
import 'package:khudrah_companies/designs/search_bar.dart';
import 'package:khudrah_companies/designs/text_field_design.dart';
import 'package:khudrah_companies/dialogs/two_btns_dialog.dart';
import 'package:khudrah_companies/helpers/custom_btn.dart';
import 'package:khudrah_companies/network/models/branches/branch_model.dart';
import 'package:khudrah_companies/pages/branch/branch_list.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'dart:math' as math;

import 'branch/add_brunches_page.dart';
import 'package:easy_localization/easy_localization.dart';

class HomePage extends StatefulWidget {
  final bool isHasBranch;
  const HomePage({Key? key, required this.isHasBranch}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //------------------------
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

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
      return AddBranchesPage(branchModel: null,);
    }));
  }
  ////---------------------------

  @override
  void initState() {
    super.initState();

    //todo: show after calling api
    if (widget.isHasBranch == false) {
      showAddBranchDialog();
    }
  }

  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    double scWidth = size.width;
    double scHeight = size.height;

    return SafeArea(
      child: Scaffold(
        key: _scaffoldState,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //greeting user
              Container(
                child: greeting(context),
              ),
              SizedBox(height: 10,),
              Container(
                child: searchBar(searchController),
              ),
              SizedBox(height: 20,),

              Container(
                width: scWidth*15,
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Text(LocaleKeys.categories.tr(),
                  style: TextStyle(
                    color: CustomColors().darkBlueColor,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),),
              ),
              SizedBox(height: 10,),
              Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 15, right: 15),
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/fruitsnveg.png'),
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Container(
                      margin: EdgeInsets.only(left: 15, right: 15),
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/fruits.png'),
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Container(
                      margin: EdgeInsets.only(left: 15, right: 15),
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/veg.png'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Row(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: scWidth*0.4,
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: Text(LocaleKeys.trending_deals.tr(),
                      style: TextStyle(
                        color: CustomColors().darkBlueColor,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),),
                  ),
                  SizedBox(width: scWidth*0.35,),
                  Container(
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(math.pi),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back_ios,
                          color: CustomColors().primaryGreenColor,),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              productCard(context, 0, 'Avocado', 22),
              Divider(
                thickness: 5,
                color: CustomColors().grayColor,
              ),
              productCard(context, 0, 'Melons', 6.95),
              Divider(
                thickness: 5,
                color: CustomColors().grayColor,
              ),
              productCard(context, 0, 'Carrots',8.56),
              Divider(
                thickness: 5,
                color: CustomColors().grayColor,
              ),
            ],
          ),
        ),
        drawer: drawerDesign(context),

      ),
    );
  }

  Widget searchBar(seController) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SizedBox(width: 10,),

          Container(
            child: IconButton(
              icon: Icon(Icons.menu_rounded,),
              color: CustomColors().brownColor,
              iconSize: 28,
              onPressed: () {
                _scaffoldState.currentState!.openDrawer();
              },
            ),
          ),

          // SizedBox(width: 5,),
          Container(
            margin: EdgeInsets.only(left: 5, right: 5),
            width: MediaQuery.of(context).size.width/1.4,
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
        ],
      ),
    );
  }
}
