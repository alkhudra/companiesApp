import 'package:flutter/material.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/helpers/custom_btn.dart';
import 'package:khudrah_companies/helpers/image_helper.dart';
import 'package:khudrah_companies/network/models/product/product_model.dart';
import 'package:khudrah_companies/pages/products/product_details.dart';
import 'package:khudrah_companies/pages/products/product_widget/add_to_cart_widget.dart';
import 'package:khudrah_companies/pages/products/product_widget/add_to_fav_widget.dart';
import 'package:khudrah_companies/provider/product_provider.dart';
import 'package:khudrah_companies/provider/genral_provider.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

class ProductTile extends StatelessWidget {
  final ProductsModel productModel;
  ProductTile({
    required this.productModel,
  });

  @override
  Widget build(BuildContext context) {
    String? price = (productModel.hasSpecialPrice == true
            ? productModel.netSpecialPrice
            : productModel.netPrice)
        ?.toStringAsFixed(2);
    Size size = MediaQuery.of(context).size;
    double scWidth = size.width;
    double scHeight = size.height;

    //   price = price.toStringAsFixed(1);
    String language = Provider.of<GeneralProvider>(context, listen: true)
        .userSelectedLanguage;

    String? name = language == 'ar' ? productModel.arName : productModel.name;
    String? unit = language == 'ar'
        ? productModel.arItemUnitDesc
        : productModel.enItemUnitDesc;

    //--------------------------
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
                      width: scWidth * 0.17,
                      height: scHeight * 0.17,
                      child: ImageHelper.productImage(productModel.image),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    //center of card
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 10, top: 15),
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
                          // width: 80,
                          padding: EdgeInsets.all(2),
                          child: Text(
                            ("$price " + LocaleKeys.sar.tr() + ' / ' + unit!),
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            style: TextStyle(
                                color: CustomColors().primaryGreenColor,
                                fontWeight: FontWeight.w400),
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
                          AddToFavWidget(productModel: productModel),
                          //Counter

                          SizedBox(
                            height: 15,
                          ),
                          AddToCartWidget(productModel: productModel),
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
                      )));
        });
  }
}
