import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/designs/drawar_design.dart';
import 'package:khudrah_companies/helpers/custom_btn.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'package:easy_localization/easy_localization.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({ Key? key }) : super(key: key);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {

  double price = 6;
  double total = 18;
  int counter = 0;

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    double scWidth = size.width;
    double scHeight = size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: CustomColors().primaryGreenColor,
      body: CustomScrollView(
          slivers: [
            SliverAppBar(
              centerTitle: true,
              collapsedHeight: 200,
              flexibleSpace: Stack(
                children: [
                  Positioned.fill(
                    left: 180,
                    child: Image.asset('images/grapevector.png'),
                  ),
                  //Product image
                  // Positioned.fill(
                  //   child: Image.network('https://images.pexels.com/photos/161559/background-bitter-breakfast-bright-161559.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500',
                  //   fit: BoxFit.cover,),
                  //   ),
                ],
              ),
              expandedHeight: 180,
              elevation: 0.0,
              backgroundColor: CustomColors().primaryGreenColor,
              iconTheme: IconThemeData(color: CustomColors().primaryWhiteColor),
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios), 
                color: CustomColors().primaryWhiteColor,
                onPressed: () => Navigator.pop(context),
              ),
              actions: [
                IconButton(icon: Icon(Icons.favorite, 
                  color: CustomColors().likeColor.withOpacity(0.9),),
                  onPressed: () {
                    //TODO: add/remove to favorites
                  },),
                IconButton(icon: Icon(Icons.share_outlined, 
                  color: CustomColors().primaryWhiteColor,),
                  onPressed: () {
                    //TODO: implement share options
                  },
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Container(
                // margin: EdgeInsets.only(top: 100),
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                // shadow top of container
                boxShadow: [
                  BoxShadow(
                      color: CustomColors().blackColor.withOpacity(0.3),
                      offset: Offset(-2, -6.0),
                      blurRadius: 6.0,
                      spreadRadius: -2.0),
                ],
                  color: CustomColors().primaryWhiteColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20,),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: Text(LocaleKeys.fruit_category.tr(),
                      style: TextStyle(
                        color: CustomColors().darkGrayColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: Text('Fresh Orange',
                      style: TextStyle(
                        color: CustomColors().blackColor.withOpacity(0.9),
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                      ),),
                    ),
                    SizedBox(height: 5,),
                    //row for price and counter
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                          child: Text('$price SAR / Kg',
                          style: TextStyle(
                            color: CustomColors().primaryGreenColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          width: scWidth*0.25,
                          height: scHeight*0.04,
                          decoration: BoxDecoration(
                            color: CustomColors().grayColor,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  counter >= 0 ? counter += counter : counter;
                                },
                                child: Container(
                                  padding: EdgeInsets.all(4),
                                  child: Text(
                                    '-',
                                    style: TextStyle(
                                      color: CustomColors().darkBlueColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                child: Text(
                                  '$counter',
                                  style: TextStyle(
                                    color: CustomColors().blackColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  counter >= 0 ? counter -= counter : counter;
                                },
                                child: Container(
                                  padding: EdgeInsets.all(4),
                                  child: Text(
                                    '+',
                                    style: TextStyle(
                                      color: CustomColors().darkBlueColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 25,),
                    //Description
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(LocaleKeys.pro_description.tr(), style: TextStyle(
                            color: CustomColors().darkGrayColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w500
                          ),),
                          //TODO: replace with tab bar
                          Divider(
                            thickness: 1.5,
                            color: CustomColors().primaryGreenColor,
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Text('Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                      overflow: TextOverflow.clip,),
                    )
                    
                  ],
                ),
              ),
            ),
          ],
        ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: scHeight*0.09,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: Text('$total SAR', style: TextStyle(
                  color: CustomColors().primaryGreenColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),),
              ),
              Container(
                child: greenBtn('ADD TO CART', 
                EdgeInsets.symmetric(horizontal: 5), 
                () {}),
              )
            ],
          ),
        ),
      ),
      endDrawer: drawerDesign(context),
    );
  }
}