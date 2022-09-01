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

import '../../helpers/number_helper.dart';

class ProductTile extends StatelessWidget {
  final ProductsModel productModel;
  ProductTile({
    required this.productModel,
  });

  @override
  Widget build(BuildContext context) {
    num? price = (productModel.hasSpecialPrice == true
            ? productModel.netSpecialPrice
            : productModel.netPrice)
        ?.toDouble();

    String language = Provider.of<GeneralProvider>(context, listen: true)
        .userSelectedLanguage;

    String? name = language == 'ar' ? productModel.arName : productModel.name;
    String? unit = language == 'ar'
        ? productModel.arItemUnitDesc
        : productModel.enItemUnitDesc;

    //--------------------------
    return ListTile(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetails(
                      productModel: productModel,
                    )));
      },
      leading: ImageHelper.productImage(productModel.image),
      trailing: AddToCartWidget(productModel: productModel),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '$name'.length > 20 ? '${name?.substring(0, 20)} ...' : '$name',
              style: TextStyle(
                color: CustomColors().brownColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          //center of card
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              (getTextWithCurrency(price!) + ' / ' + unit!),
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: TextStyle(
                  color: CustomColors().primaryGreenColor,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}
