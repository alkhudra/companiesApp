import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/helpers/image_helper.dart';
import 'package:khudrah_companies/network/models/product/product_model.dart';
import 'package:khudrah_companies/pages/products/product_details.dart';
import 'package:khudrah_companies/pages/products/product_widget/add_to_cart_widget.dart';
import 'package:khudrah_companies/pages/products/product_widget/add_to_fav_widget.dart';
import 'package:khudrah_companies/provider/product_provider.dart';
import 'package:khudrah_companies/provider/genral_provider.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../helpers/number_helper.dart';

class FavoriteTile extends StatelessWidget {
  final ProductsModel productModel;
  FavoriteTile({
    required this.productModel,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double scWidth = size.width;
    double scHeight = size.height;
    String language = Provider.of<GeneralProvider>(context, listen: false)
        .userSelectedLanguage;

    num? price = (productModel.hasSpecialPrice == true
            ? productModel.netSpecialPrice
            : productModel.netPrice)
        ?.toDouble();

    String? unit = language == 'ar'
        ? productModel.arItemUnitDesc
        : productModel.enItemUnitDesc;

    String? name = language == 'ar' ? productModel.arName : productModel.name;

    return GridTile(
      child: Container(
        decoration: BoxDecoration(
            color: CustomColors().primaryWhiteColor,
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                  color: CustomColors().darkGrayColor.withOpacity(0.4),
                  offset: Offset(2.0, 2.0),
                  blurRadius: 3.0,
                  spreadRadius: .8)
            ]),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProductDetails(
                          productModel: productModel,
                        )));
          },
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  //Delete icon
                  Container(
                    margin: EdgeInsets.only(top: 10, left: 15, right: 15),
                    child: IconButton(
                      onPressed: () {
                        AddToFavWidget.favoriteDBProcess(
                                context, true, productModel.productId!)
                            .then((value) {
                          if (value) {
                            Provider.of<ProductProvider>(context, listen: false)
                                .removeFavItemFromFavList(productModel);
                          }
                        });
                      },
                      icon: Icon(
                        FontAwesomeIcons.trash,
                        color: CustomColors().redColor,
                        size: 20,
                      ),
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                    ),
                  ),
                ],
              ),
              //name and other details
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: scWidth * 0.18,
                    height: scHeight * 0.1,
                    child: ImageHelper.productImage(productModel.image),
                  ),
                  //name
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(vertical: 7),
                    child: Text(
                      '$name'.length > 20
                          ? '${name?.substring(0, 20)} ...'
                          : '$name',
                      style: TextStyle(
                        color: CustomColors().brownColor,
                        fontSize: 18.5,
                      ),
                    ),
                  ),
                  Container(
                    width: scWidth * 0.3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //price
                        Text(
                          (getTextWithCurrency(price!) + ' / ' + unit!),
                          style: TextStyle(
                              color: CustomColors().primaryGreenColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(height: scHeight*0.01,),
                  //Counter and cart icon row
                  AddToCartWidget(
                    productModel: productModel,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
