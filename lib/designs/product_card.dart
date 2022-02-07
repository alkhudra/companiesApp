import 'package:flutter/material.dart';
import 'package:khudrah_companies/Constant/api_const.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/dialogs/progress_dialog.dart';
import 'package:khudrah_companies/helpers/snack_message.dart';
import 'package:khudrah_companies/network/API/api_response.dart';
import 'package:khudrah_companies/network/API/api_response_type.dart';
import 'package:khudrah_companies/network/helper/network_helper.dart';
import 'package:khudrah_companies/network/models/message_response_model.dart';
import 'package:khudrah_companies/network/models/product/product_model.dart';
import 'package:khudrah_companies/network/repository/product_repository.dart';
import 'package:khudrah_companies/pages/products/product_details.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:khudrah_companies/network/helper/exception_helper.dart';

class ProductCard {
  static int counter = 0;
  static bool isAddToFavBtnEnabled = true;

  static productCardDesign(context, String language, ProductsModel productModel,Function() favPressed,
      {increaseCount, decreaseCount}) {
    // bool isFav = false;
    double? price = (productModel.hasSpecialPrice == true
            ? productModel.specialPrice
            : productModel.originalPrice)
        ?.toDouble();

    bool? isFavourite = productModel.isFavourite;
    String? productId = productModel.productId;

    String? name = language == 'ar' ? productModel.arName : productModel.name;
    String imageUrl = productModel.image != null ?ApiConst.images_url + productModel.image! :
    'images/green_fruit.png';
    return GestureDetector(
        child: ListTile(
          title: Column(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //left side of card
                    Container(
                      margin: EdgeInsets.only(bottom: 5),
                      width: MediaQuery.of(context).size.width * 0.17,
                      height: MediaQuery.of(context).size.height * 0.17,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage('$imageUrl'),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    //center of card
                    Column(
                      children: [
                        Container(
                          child: Text(
                            '$name',
                            style: TextStyle(
                                color: CustomColors().brownColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 22),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.23,
                          height: MediaQuery.of(context).size.height * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: CustomColors().primaryGreenColor,
                          ),
                          child: TextButton.icon(
                            onPressed: () {},
                            icon: Icon(
                              Icons.shopping_cart,
                              color: CustomColors().primaryWhiteColor,
                              size: 21,
                            ),
                            label: Text(
                              LocaleKeys.add_btn.tr(),
                              style: TextStyle(
                                color: CustomColors().primaryWhiteColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      padding: EdgeInsets.only(right: 5, left: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            child: InkWell(

                                onTap:isAddToFavBtnEnabled == true ? favPressed : null,
                                child: isFavourite! == true
                                    ? Icon(
                                        Icons.favorite,
                                        color: CustomColors().redColor,
                                      )
                                    : Icon(
                                        Icons.favorite,
                                        color: CustomColors().grayColor,
                                      )),
                          ),
                          //Counter
                          Container(
                            width: 80,
                            height: 30,
                            decoration: BoxDecoration(
                              color: CustomColors().grayColor,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: increaseCount,
                                  // () {
                                  //   // counter >= 0 ? counter -= counter : counter;
                                  // },
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
                                  onTap: decreaseCount,
                                  // () {
                                  //   counter >= 0 ? counter += counter : counter;
                                  // },
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
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            padding: EdgeInsets.all(2),
                            child: Text(
                              '$price SAR / Kg',
                              style: TextStyle(
                                  color: CustomColors().primaryGreenColor,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 2,
                color: CustomColors().grayColor,
              )
            ],
          ),
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductDetails(
                        productModel: productModel,
                        language: language,
                      )));
        });
  }

  static void addToFav(
      BuildContext context, bool? isFavourite, String productId) async {
    isAddToFavBtnEnabled = false;
    String message = await dBProcess(context, isFavourite, productId);
    showSuccessMessage(context, message);
  }

  static Future<String> dBProcess(
      BuildContext context, bool? isFavourite, String productId) async {
    showLoaderDialog(context);
    //----------start api ----------------

    Map<String, dynamic> headerMap = await getHeaderMap();

    ProductRepository productRepository = ProductRepository(headerMap);
    ApiResponse apiResponse;
    if (isFavourite == false) {
      apiResponse = await productRepository.addProductToFav(productId);
    } else {
      apiResponse = await productRepository.deleteProductFromFav(productId);
    }
    if (apiResponse.apiStatus.code == ApiResponseType.OK.code) {
      MessageResponseModel model =
          MessageResponseModel.fromJson(apiResponse.result);
      Navigator.pop(context);
      isAddToFavBtnEnabled = true;
      return model.message!;
    } else {
      Navigator.pop(context);
      isAddToFavBtnEnabled = true;
      throw ExceptionHelper(apiResponse.message);
    }
  }
}
// Widget productCardDesign(context, proName, proPrice, {increaseCount, decreaseCount}) {
//   int counter = 0;
//   // bool isFav = false;

//   return ListTile(
//     title: Column(
//       children: [
//         GestureDetector(
//             child: Container(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   //left side of card
//                   Container(
//                     margin: EdgeInsets.only(bottom: 5),
//                     width: MediaQuery.of(context).size.width * 0.17,
//                     height: MediaQuery.of(context).size.height * 0.17,
//                     decoration: BoxDecoration(
//                       image: DecorationImage(
//                         image: AssetImage('images/orange_shape.png'),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   //center of card
//                   Column(
//                     children: [
//                       Container(
//                         child: Text(
//                           '$proName',
//                           style: TextStyle(
//                               color: CustomColors().brownColor,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 22),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                       ),
//                       Container(
//                         width: MediaQuery.of(context).size.width * 0.23,
//                         height: MediaQuery.of(context).size.height * 0.05,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(50),
//                           color: CustomColors().primaryGreenColor,
//                         ),
//                         child: TextButton.icon(
//                           onPressed: () {},
//                           icon: Icon(
//                             Icons.shopping_cart,
//                             color: CustomColors().primaryWhiteColor,
//                             size: 21,
//                           ),
//                           label: Text(
//                             LocaleKeys.add_btn,
//                             style: TextStyle(
//                               color: CustomColors().primaryWhiteColor,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     width: 5,
//                   ),
//                   Container(
//                     width: MediaQuery.of(context).size.width * 0.3,
//                     padding: EdgeInsets.only(right: 5, left: 5),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: [
//                         Container(
//                           child: IconButton(
//                             icon: Icon(
//                               Icons.favorite,
//                               color: CustomColors().likeColor,
//                               size: 25,
//                             ),
//                             onPressed: () {
//                               // isFav != isFav;
//                             },
//                           ),
//                         ),
//                         Container(
//                           width: 80,
//                           height: 30,
//                           decoration: BoxDecoration(
//                             color: CustomColors().grayColor,
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               GestureDetector(
//                                 onTap: increaseCount,
//                                 // () {
//                                 //   // counter >= 0 ? counter -= counter : counter;
//                                 // },
//                                 child: Container(
//                                   padding: EdgeInsets.all(4),
//                                   child: Text(
//                                     '-',
//                                     style: TextStyle(
//                                       color: CustomColors().darkBlueColor,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 10,
//                               ),
//                               Container(
//                                 child: Text(
//                                   '$counter',
//                                   style: TextStyle(
//                                     color: CustomColors().blackColor,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 10,
//                               ),
//                               GestureDetector(
//                                 onTap: decreaseCount,
//                                 // () {
//                                 //   counter >= 0 ? counter += counter : counter;
//                                 // },
//                                 child: Container(
//                                   padding: EdgeInsets.all(4),
//                                   child: Text(
//                                     '+',
//                                     style: TextStyle(
//                                       color: CustomColors().darkBlueColor,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(
//                           height: 15,
//                         ),
//                         Container(
//                           padding: EdgeInsets.all(2),
//                           child: Text(
//                             '$proPrice SAR / Kg',
//                             style: TextStyle(
//                                 color: CustomColors().primaryGreenColor,
//                                 fontWeight: FontWeight.w400),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             onTap: () {
//               Navigator.push(context, MaterialPageRoute(
//                 builder: (context) => OrderDetails()));
//             },
//           ),
//       ],
//     ),
//   );
// }

// class CountItem extends StatefulWidget {
//   const CountItem({ Key? key }) : super(key: key);

//   @override
//   _CountItemState createState() => _CountItemState();
// }

// class _CountItemState extends State<CountItem> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(

//     );
//   }
// }
