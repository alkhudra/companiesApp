import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khudrah_companies/Constant/api_const.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/designs/drawar_design.dart';
import 'package:khudrah_companies/helpers/custom_btn.dart';
import 'package:khudrah_companies/helpers/pref/shared_pref_helper.dart';
import 'package:khudrah_companies/network/models/home/home_success_response_model.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'package:easy_localization/easy_localization.dart';

class ProductDetails extends StatefulWidget {
  final ProductsModel productModel;
  const ProductDetails({ Key? key ,required this.productModel}) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  String language ='ar';

  double total = 18;
  int counter = 0;
   void setValues() async {

    language = await PreferencesHelper.getSelectedLanguage;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setValues();
  }
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    double scWidth = size.width;
    double scHeight = size.height;

    double? price = (widget.productModel.hasSpecialPrice == true ? widget.productModel.specialPrice :
    widget.productModel.originalPrice)?.toDouble();
    String? description = language == 'ar'? widget.productModel.arDescription : widget.productModel.description;
    //todo: category name
    String? category ='category name';

    String? name = language == 'ar'? widget.productModel.arName : widget.productModel.name;
    String imageUrl = ApiConst.images_url + widget.productModel.image!;
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
                  //todo: set with product image
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
                      child: Text('$category',
                      style: TextStyle(
                        color: CustomColors().darkGrayColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: Text('$name',
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
                      child: Text('$description',
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