import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/designs/drawar_design.dart';
import 'package:khudrah_companies/designs/product_card.dart';
import 'package:khudrah_companies/designs/search_bar.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';

class VegCategory extends StatefulWidget {
  const VegCategory({ Key? key }) : super(key: key);

  @override
  _VegCategoryState createState() => _VegCategoryState();
}

class _VegCategoryState extends State<VegCategory> {

  TextEditingController srController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: CustomColors().primaryGreenColor,
      body: CustomScrollView(
          slivers: [
            SliverAppBar(
              centerTitle: true,
              // collapsedHeight: 200,
              title: Text(LocaleKeys.veg_category.tr(), style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 22
              ),),
              flexibleSpace: Stack(
                children: [
                  Positioned.fill(
                    left: 180,
                    child: Image.asset('images/grapevector.png'),
                  ),
                ],
              ),
              expandedHeight: 160,
              elevation: 0.0,
              backgroundColor: CustomColors().primaryGreenColor,
              iconTheme: IconThemeData(color: CustomColors().primaryWhiteColor),
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios), 
                color: CustomColors().primaryWhiteColor,
                onPressed: () => Navigator.pop(context),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                // margin: EdgeInsets.only(top: 100),
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: CustomColors().primaryWhiteColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 18,),
                    searchBar(context, srController),
                    SizedBox(height: 10,),
                    productCard(context, 0, 'Cucumbers', 7.95),
                    productCard(context, 5, 'Papaya', 16.87),
                    productCard(context, 0, 'Strawberry', 22.98),
                    productCard(context, 0, 'Pomegranate', 11.05),
                  ],
                ),
              ),
            ),
          ],
        ),
        endDrawer: drawerDesign(context),
    );
  }
}