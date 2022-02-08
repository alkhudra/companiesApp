import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khudrah_companies/Constant/api_const.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:khudrah_companies/network/models/cart/success_cart_response_model.dart';
import 'package:khudrah_companies/network/models/product/product_model.dart';
import 'package:khudrah_companies/pages/products/product_details.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';


Widget cartDetailsItem(String title ,String value){

 return Container(
    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
    child: RichText(
      text: TextSpan(
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: 'Almarai',
            color: CustomColors().primaryGreenColor,
          ),
          children: <TextSpan>[
            TextSpan(
                text: title + ': ',
                style: TextStyle(
                    color: CustomColors().darkBlueColor)),
            TextSpan(
                text: value,
                style: TextStyle(
                  color: CustomColors().primaryGreenColor,
                  fontFamily: 'Almarai',
                )),
          ]),
    ),
  );
}

Widget cartTotalDesign(num total){
  return Container(
    margin: EdgeInsets.symmetric(vertical: 5),
    child: RichText(
      text: TextSpan(
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w600,
            fontFamily: 'Almarai',
            color: CustomColors().primaryGreenColor,
          ),
          children: <TextSpan>[
            TextSpan(
                text: LocaleKeys.total.tr() + ': ',
                style: TextStyle(
                  color: CustomColors().primaryGreenColor,
                )),
            TextSpan(
                text: getTextWithCurrency(total),
                style: TextStyle(
                  color: CustomColors().primaryGreenColor,
                )),
          ]),
    ),
  );
}

Widget cartTile(BuildContext context , String language , List<CartProductsList?> list, int index) {
  ProductsModel model = list[index]!.productDto!;
  Size size = MediaQuery.of(context).size;
  double scWidth = size.width;
  double scHeight = size.height;

  num price = model.hasSpecialPrice == true
      ? model.specialPrice!
      : model.originalPrice!;
  String? name = language == 'ar' ? model.arName : model.name;
  String? category =
  language == 'ar' ? model.arCategoryName : model.categoryName;
  String image = model.image != null
      ? ApiConst.images_url + model.image!
      : 'images/green_fruit.png';

  num userQty = list[index]!.userProductQuantity!;
  num productTotal = list[index]!.totalProductPrice!;

  return ListTile(
    title: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 5,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProductDetails(
                      productModel: model,
                      language: language,
                    )));
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              // border: Border.all(
              //   color: CustomColors().primaryGreenColor,
              // ),
              boxShadow: [
                BoxShadow(
                  color: CustomColors().blackColor.withOpacity(0.4),
                  offset: Offset(2, 2),
                  blurRadius: 5,
                  spreadRadius: 0.2,
                )
              ],
              color: CustomColors().primaryWhiteColor,
            ),
            child: Stack(children: [
              //green product icon
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    child: Image(
                      image: NetworkImage(image),
                    ),
                  ),
                  //category, name and price
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SizedBox(height: 20,),
                      //category and name

                      //category
                      /*     Container(
                              child: Text(
                                '$category',
                                style: TextStyle(
                                  color: CustomColors().darkGrayColor,
                                ),
                              ),
                              margin: EdgeInsets.all(5),
                            ),*/
                      //product name
                      Container(
                        child: Text(
                          '$name',
                          style: TextStyle(
                            color: CustomColors().brownColor,
                          ),
                        ),
                      ),

                      // price
                      Row(
                        children: [
                          Container(
                            child: Text(
                              getTextWithCurrency(price),
                              style: TextStyle(
                                  color: CustomColors().primaryGreenColor,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          Container(
                            child: Text(
                              ' × $userQty  ' ,
                              style: TextStyle(
                                  color: CustomColors().primaryGreenColor,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          Container(
                            child: Text(
                              getTextWithCurrency(productTotal),
                              style: TextStyle(
                                  color: CustomColors().primaryGreenColor,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  //counter
                  /*     Container(
                      width: scWidth * 0.071,
                      height: scHeight * 0.13,
                      decoration: BoxDecoration(
                        color: CustomColors().grayColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
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
                            onTap: () {
                              //Decrease count method
                            },
                          ),
                          Container(
                            child: Text(
                              '$userQty',
                              // '$counter',
                              style: TextStyle(
                                color: CustomColors().darkBlueColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          GestureDetector(
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
                            onTap: () {
                              //increase count method
                            },
                          ),
                        ],
                      ),
                    ),*/
                  SizedBox(
                    width: 10,
                  ),
                  //Delete icon
                  GestureDetector(
                    onTap: (){
                    //  deleteFromCart(context, model.productId);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 2,
                      child: IconButton(

                        icon: Icon(
                          Icons.delete,
                          color: CustomColors().redColor,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(), onPressed: () {  },
                      ),
                    ),
                  ),
                  // Container(
                  //   child: Stack(
                  //     children: [
                  //       VerticalDivider(
                  //         thickness: 30,
                  //         color: CustomColors().primaryGreenColor,
                  //       ),
                  //       Container(
                  //         alignment: Alignment.center,
                  //         width: 2,
                  //         child: IconButton(
                  //           onPressed: () {},
                  //           icon: Icon(Icons.arrow_back_ios,
                  //             color: CustomColors().darkGrayColor,),
                  //           padding: EdgeInsets.zero,
                  //           constraints: BoxConstraints(),
                  //         ),
                  //       ),
                  //       // GestureDetector(
                  //       //   child: Container(
                  //       //     child: Center(child: Icon(Icons.arrow_back_ios_new_rounded)),
                  //       //   ),
                  //       //   onTap: () {},
                  //       // ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ]),
          ),
        ),
      ],
    ),
  );
}


String currency= LocaleKeys.sar.tr();

String getTextWithCurrency(num value){
  return ' $value '+currency;
}

String getTextWithPercentage(num value){
  return ' $value %';
}