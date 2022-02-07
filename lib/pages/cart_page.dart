import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:khudrah_companies/Constant/api_const.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/designs/appbar_design.dart';
import 'package:khudrah_companies/designs/drawar_design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:khudrah_companies/helpers/custom_btn.dart';
import 'package:khudrah_companies/helpers/pref/shared_pref_helper.dart';
import 'package:khudrah_companies/network/API/api_response.dart';
import 'package:khudrah_companies/network/API/api_response_type.dart';
import 'package:khudrah_companies/network/helper/exception_helper.dart';
import 'package:khudrah_companies/network/helper/network_helper.dart';
import 'package:khudrah_companies/network/models/cart/success_cart_response_model.dart';
import 'package:khudrah_companies/network/models/product/product_model.dart';
import 'package:khudrah_companies/network/repository/cart_repository.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'package:lottie/lottie.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
static String language  ='ar';

@override
  void initState() {
    super.initState();
    setValue();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //add body
      body: FutureBuilder<SuccessCartResponseModel?>(
        future: getListData(),
        builder: (context, snapshot) {
          print(snapshot.toString());
          if (snapshot.hasData) {
            print(snapshot.hasData);
            print(snapshot.data);
            return listDesign(context, snapshot.data!);
          } else {
            return errorCase(snapshot);
          }
        },
      ),
      appBar: bnbAppBar(context, LocaleKeys.cart.tr()),
      // bottomNavigationBar: BottomAppBar(
      //   child: Container(
      //     //Change height to be adaptable
      //     height: MediaQuery.of(context).size.height*0.14,
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.start,
      //       children: [
      //         SizedBox(height: 4,),
      //         Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceAround,
      //           children: [
      //             //subtotal
      //             Container(
      //               margin: EdgeInsets.symmetric(vertical: 5),
      //               child: RichText(
      //                 text: TextSpan(
      //                   style: TextStyle(
      //                     fontSize: 15,
      //                     fontWeight: FontWeight.w500,
      //                     fontFamily: 'Almarai',
      //                     color: CustomColors().primaryGreenColor,
      //                   ),
      //                   children: <TextSpan> [
      //                     TextSpan(text: LocaleKeys.subtotal.tr() + ': ',
      //                     style: TextStyle(
      //                       color: CustomColors().darkBlueColor
      //                     )),
      //                     TextSpan(text: ' $subtotal SAR',
      //                     style: TextStyle(
      //                       color: CustomColors().primaryGreenColor,
      //                       fontFamily: 'Almarai',
      //                     )),
      //                   ]
      //                 ),
      //               ),
      //             ),
      //             //vat
      //             Container(
      //               margin: EdgeInsets.symmetric(vertical: 5),
      //               child: RichText(
      //                 text: TextSpan(
      //                   style: TextStyle(
      //                     fontSize: 15,
      //                     fontWeight: FontWeight.w500,
      //                     fontFamily: 'Almarai',
      //                     color: CustomColors().primaryGreenColor,
      //                   ),
      //                   children: <TextSpan> [
      //                     TextSpan(text: LocaleKeys.vat.tr() + ': ',
      //                     style: TextStyle(
      //                       color: CustomColors().darkBlueColor,
      //                       fontFamily: 'Almarai',
      //                     )),
      //                     TextSpan(text: ' $vat SAR',
      //                     style: TextStyle(
      //                       color: CustomColors().primaryGreenColor,
      //                     )),
      //                   ]
      //                 ),
      //               ),
      //             ),
      //           ],
      //         ),
      //         SizedBox(height: 5,),
      //         // Divider(
      //         //   thickness: 1,
      //         // ),
      //         Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //           children: [
      //             //total
      //             Container(
      //               margin: EdgeInsets.symmetric(vertical: 5),
      //               child: RichText(
      //                 text: TextSpan(
      //                   style: TextStyle(
      //                     fontSize: 19,
      //                     fontWeight: FontWeight.w600,
      //                     fontFamily: 'Almarai',
      //                     color: CustomColors().primaryGreenColor,
      //                   ),
      //                   children: <TextSpan> [
      //                     TextSpan(text: LocaleKeys.total.tr() + ': ',
      //                     style: TextStyle(
      //                       color: CustomColors().primaryGreenColor,
      //                     )),
      //                     TextSpan(text: ' $total SAR',
      //                     style: TextStyle(
      //                       color: CustomColors().primaryGreenColor,
      //                     )),
      //                   ]
      //                 ),
      //               ),
      //             ),
      //             //checkout button
      //             Container(
      //               child: greenBtn(LocaleKeys.checkout.tr(), EdgeInsets.symmetric(vertical: 4), () {}),
      //             ),
      //           ],
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }

  //-----------------------

  Future<SuccessCartResponseModel> getListData() async {
    Map<String, dynamic> headerMap = await getHeaderMap();

    CartRepository cartRepository = CartRepository(headerMap);

    ApiResponse apiResponse = await cartRepository.getCart();

    if (apiResponse.apiStatus.code == ApiResponseType.OK.code) {
      SuccessCartResponseModel? responseModel =
          SuccessCartResponseModel.fromJson(apiResponse.result);

      return responseModel;
    } else {
      throw ExceptionHelper(apiResponse.message);
    }
  }
  //-----------------------

  Widget listDesign(BuildContext context, SuccessCartResponseModel? model) {
    int price = model!.userCart!.totalCartPrice!;
    double subtotal =3;
    double vat =5;
    num total = model.userCart!.hasDiscount! == true ?  model.userCart!.priceAfterDiscount! :
    model.userCart!.totalCartPrice!;
    double price_vat = 27.2;
    double discount = 20;
    return SlidingUpPanel(
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Slidable(
              endActionPane: ActionPane(
                key: const ValueKey(0),
                motion: const BehindMotion(),
                dismissible: DismissiblePane(onDismissed: () {}),
                children: [
                  SlidableAction(
                    onPressed: deleteFromCart(),
                    backgroundColor: CustomColors().redColor,
                    // foregroundColor: CustomColors().primaryWhiteColor,
                    icon: Icons.delete,
                    label: LocaleKeys.delete_from_cart.tr(),
                  )
                ],
              ),
              child: cartTile(model!.userCart!.cartProductsList! ,index));
        },
        itemCount: model!.userCart!.cartProductsList!.length,
      ),
      minHeight: 60,
      maxHeight: 270,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(40),
        topRight: Radius.circular(40),
      ),
      panel: Container(
        //Change height to be adaptable
        height: MediaQuery.of(context).size.height * 0.16,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    LocaleKeys.order_details.tr(),
                    style: TextStyle(
                        color: CustomColors().brownColor.withOpacity(0.7),
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            // SizedBox(height: 40,),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //subtotal
                Container(
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
                              text: LocaleKeys.subtotal.tr() + ': ',
                              style: TextStyle(
                                  color: CustomColors().darkBlueColor)),
                          TextSpan(
                              text: ' $subtotal SAR',
                              style: TextStyle(
                                color: CustomColors().primaryGreenColor,
                                fontFamily: 'Almarai',
                              )),
                        ]),
                  ),
                ),
                //vat
                Container(
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
                              text: LocaleKeys.vat.tr() + ': ',
                              style: TextStyle(
                                color: CustomColors().darkBlueColor,
                                fontFamily: 'Almarai',
                              )),
                          TextSpan(
                              text: ' $vat SAR',
                              style: TextStyle(
                                color: CustomColors().primaryGreenColor,
                              )),
                        ]),
                  ),
                ),
                //Total with VAT only
                Container(
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
                              text: 'Total with VAT' + ': ',
                              style: TextStyle(
                                color: CustomColors().darkBlueColor,
                                fontFamily: 'Almarai',
                              )),
                          TextSpan(
                              text: ' $price_vat SAR',
                              style: TextStyle(
                                color: CustomColors().primaryGreenColor,
                              )),
                        ]),
                  ),
                ),
                //Total with VAt and discount
                Container(
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
                              text: 'Discount Percentage' + ': ',
                              style: TextStyle(
                                color: CustomColors().darkBlueColor,
                                fontFamily: 'Almarai',
                              )),
                          TextSpan(
                              text: ' $discount %',
                              style: TextStyle(
                                color: CustomColors().primaryGreenColor,
                              )),
                        ]),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              thickness: 1,
              indent: 25,
              endIndent: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //total
                Container(
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
                              text: ' $total SAR',
                              style: TextStyle(
                                color: CustomColors().primaryGreenColor,
                              )),
                        ]),
                  ),
                ),
                //checkout button
                Container(
                  child: greenBtn(LocaleKeys.checkout.tr(),
                      EdgeInsets.symmetric(vertical: 4), () {}),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  //--------
  Widget cartTile(List<CartProductsList?> list, int index)  {
    ProductsModel model  =  list[index]!.productDto!;
    Size size = MediaQuery.of(context).size;
    double scWidth = size.width;
    double scHeight = size.height;

    num price = model.hasSpecialPrice == true ?
    model.specialPrice! : model.originalPrice!;
    String? name = language == 'ar' ? model.arName : model.name;
    String? category = language == 'ar' ? model.arCategoryName : model.categoryName;
    String image = model.image != null ?ApiConst.images_url + model.image! :
    'images/green_fruit.png';

    num userQty =  list[index]!.userProductQuantity!;

    return ListTile(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 5,
          ),
          Container(
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //category
                          Container(
                            child: Text(
                              '$category',
                              style: TextStyle(
                                color: CustomColors().darkGrayColor,
                              ),
                            ),
                            margin: EdgeInsets.all(5),
                          ),
                          //product name
                          Container(
                            child: Text(
                              '$name',
                              style: TextStyle(
                                color: CustomColors().brownColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      // price
                      Container(
                        child: Text(
                          '$price  ' + LocaleKeys.sar_per_kg.tr(),
                          style: TextStyle(
                              color: CustomColors().primaryGreenColor,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                  //counter
                  Container(
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
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  //Delete icon
                  Container(
                    alignment: Alignment.center,
                    width: 2,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: CustomColors().darkGrayColor,
                      ),
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
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
        ],
      ),
    );
  }

  //TODO: Define delete method
  deleteFromCart() {}

  void setValue()async {

  language = await PreferencesHelper.getSelectedLanguage;
  }
}
