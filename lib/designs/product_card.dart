import 'package:flutter/material.dart';
import 'package:khudrah_companies/Constant/api_const.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/network/models/product/product_model.dart';
import 'package:khudrah_companies/pages/products/product_details.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'package:easy_localization/easy_localization.dart';
class ProductCard{

  static int counter = 0;
  
  static productCardDesign(context, String language, ProductsModel productModel, {increaseCount, decreaseCount}) {
  // bool isFav = false;
    double? price = (productModel.hasSpecialPrice == true ? productModel.specialPrice :
    productModel.originalPrice)?.toDouble();


    String? name = language == 'ar'? productModel.arName : productModel.name;
    String imageUrl = ApiConst.images_url + productModel.image!;
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
                        child: IconButton(
                          icon: Icon(
                            Icons.favorite,
                            color: CustomColors().likeColor,
                            size: 25,
                          ),
                          onPressed: () {
                            // isFav != isFav;
                          },
                        ),
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
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => ProductDetails(productModel: productModel,)));
      });
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
