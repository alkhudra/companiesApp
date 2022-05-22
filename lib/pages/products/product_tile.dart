import 'package:flutter/material.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/helpers/custom_btn.dart';
import 'package:khudrah_companies/helpers/image_helper.dart';
import 'package:khudrah_companies/network/models/product/product_model.dart';
import 'package:khudrah_companies/pages/products/product_details.dart';
import 'package:khudrah_companies/provider/genral_provider.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
class ProductTile extends StatelessWidget {

  bool isAddToFavBtnEnabled = true,
      isTrashBtnEnabled = true,
      isAddToCartBtnEnabled = true,
      isIncreaseBtnEnabled = true,
      isDecreaseBtnEnabled = true;

  final Function() addToCart;
  final Function() addQtyToCart;
  final Function() deleteFromCart;
  final Function() reduceQtyFromCart;
 final Function() favPressed;
  final ProductsModel productModel;
  ProductTile({

    required this.productModel,
    required  this.favPressed,
    required  this.addToCart,
    required  this.deleteFromCart,
    required  this.addQtyToCart,
    required  this.reduceQtyFromCart}
  );

  @override
  Widget build(BuildContext context) {

    String? price = (productModel.hasSpecialPrice == true
        ? productModel.netSpecialPrice
        : productModel.netPrice)?.toStringAsFixed(2);
    Size size = MediaQuery.of(context).size;
    double scWidth = size.width;
    double scHeight = size.height;

    //   price = price.toStringAsFixed(1);
    bool? isFavourite = productModel.isFavourite;
    String language =  Provider.of<GeneralProvider>(context,listen: false).userSelectedLanguage;

    String? name = language == 'ar' ? productModel.arName : productModel.name;
    num? stockQty = productModel.quantity!;
    int? userQty = productModel.userProductQuantity;
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
                      width: MediaQuery.of(context).size.width * 0.17,
                      height: MediaQuery.of(context).size.height * 0.17,
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
                          child: Expanded(
                            child: Text(
                              ("$price " + LocaleKeys.sar.tr() + ' / ' + unit!),
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: TextStyle(
                                  color: CustomColors().primaryGreenColor,
                                  fontWeight: FontWeight.w400),
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
                                onTap: isAddToFavBtnEnabled == true
                                    ? favPressed
                                    : null,
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

                          SizedBox(
                            height: 15,
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 10),
                              child:
                              productModel.isDeleted == false && productModel.isAvailabe == true
                              //show add to cart options
                                  ? productModel.isAddedToCart == false &&  productModel.userProductQuantity ==  0
                              //show cart button
                                  ? cartBtn(
                                  Icons.shopping_cart,
                                  // LocaleKeys.add_cart.tr(),
                                  EdgeInsets.symmetric(horizontal: 5),
                                  addToCart)
                              //show counter
                                  :Container(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: scWidth * 0.25,
                                height: scHeight * 0.04,
                                decoration: BoxDecoration(
                                  color: CustomColors().grayColor,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    userQty == 1
                                        ? GestureDetector(
                                      onTap: deleteFromCart,
                                      child: Container(
                                        padding: EdgeInsets.all(4),
                                        child: Icon(
                                          Icons.delete_outline_outlined,
                                          color: CustomColors().primaryGreenColor,
                                        ),
                                      ),
                                    )
                                        : GestureDetector(
                                      onTap: reduceQtyFromCart,
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
                                        '$userQty',
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
                                      onTap: addQtyToCart,
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
                              )
                              //show product unavailable
                                  : unAvailableBtn(
                                  LocaleKeys.not_available_product.tr(),
                                  EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                                  MediaQuery.of(context).size.height * 0.04,
                                  11.6)
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

                  )));
        });
  }
}