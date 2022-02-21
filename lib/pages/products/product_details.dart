import 'package:flutter/material.dart';
import 'package:khudrah_companies/Constant/api_const.dart';
import 'package:khudrah_companies/Constant/conts.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/designs/no_item_design.dart';
import 'package:khudrah_companies/designs/product_card.dart';
import 'package:khudrah_companies/dialogs/message_dialog.dart';
import 'package:khudrah_companies/helpers/cart_helper.dart';
import 'package:khudrah_companies/helpers/snack_message.dart';
import 'package:khudrah_companies/network/API/api_response.dart';
import 'package:khudrah_companies/network/API/api_response_type.dart';
import 'package:khudrah_companies/network/helper/network_helper.dart';
import 'package:khudrah_companies/network/models/product/product_model.dart';
import 'package:khudrah_companies/network/repository/product_repository.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:khudrah_companies/network/helper/exception_helper.dart';
import 'package:khudrah_companies/router/route_constants.dart';

class ProductDetails extends StatefulWidget {
  final ProductsModel productModel;
  final String language;
  const ProductDetails(
      {Key? key, required this.productModel, required this.language})
      : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  late Color likeColor;
  late int counter = 0;
  bool isAddToFavBtnEnabled = true;
  bool isAddToCartBtnEnabled = true;
  bool isTrashBtnEnabled = true,
      isIncreaseBtnEnabled = true,
      isDecreaseBtnEnabled = true;

  static num total = 0;
  static num? price = 0;
  @override
  Widget build(BuildContext context) {
    String productId = widget.productModel.productId!;
    //----------------------------
    return FutureBuilder<ProductsModel?>(
      future: getPageData(productId),
      builder: (context, snapshot) {
        print(snapshot.toString());
        if (snapshot.hasData) {
          print(snapshot.hasData);
          print(snapshot.data);
          return pageDesign(context, snapshot, snapshot.data!);
        } else {
          return customErrorCase(snapshot);
        }
      },
    );
  }

  Widget customErrorCase(AsyncSnapshot<ProductsModel?> hasData) {
    ProductsModel model = widget.productModel;
    return pageDesign(context, hasData, model);
  }

  //----------------------------
  Widget pageDesign(BuildContext context, AsyncSnapshot<ProductsModel?> hasData,
      ProductsModel model) {
    String language = widget.language;
    Size size = MediaQuery.of(context).size;
    double scWidth = size.width;
    double scHeight = size.height;

    price = (model.hasSpecialPrice == true
            ? model.specialPrice
            : model.originalPrice)
        ?.toDouble();
    String? description =
        language == 'ar' ? model.arDescription : model.description;
    String? productId = model.productId;
    String? category =
        language == 'ar' ? model.arCategoryName : model.categoryName;
    String? unit = language == 'ar' ? model.arItemUnitDesc : model.enItemUnitDesc;

    String? name = language == 'ar' ? model.arName : model.name;
    bool? isFavourite = model.isFavourite;
    num? stockQty = model.quantity;
    Color favIconColor = isFavourite == true
        ? CustomColors().redColor
        : CustomColors().grayColor;
    //counter = 0;
    bool isAvailable = model.isAvailabe!;
    bool isDeleted = model.isDeleted!;
    //TODO: set to product image available or not: true for available, false for default green bg
    bool imgAvl = true;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: CustomColors().primaryWhiteColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: true,
            collapsedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              //product image, default green or product network image
              background: GestureDetector(
                child: imgAvl ? Image.network('https://images.pexels.com/photos/161559/background-bitter-breakfast-bright-161559.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500',
                fit: BoxFit.cover,) : Padding(
                  padding: const EdgeInsets.only(left: 140),
                  child: Image.asset('images/grapevector.png'),
                ),
                onTap: () {
                  //on click function
                },
              ) ,
              ),
              //
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(20),
                child: Container(
                  width: scWidth,
                  decoration: BoxDecoration(
                    color: CustomColors().primaryWhiteColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(70),
                      topRight: Radius.circular(70),
                    ),

                  boxShadow: [
                    BoxShadow(
                        color: CustomColors().blackColor.withOpacity(0.3),
                        offset: Offset(-4, -6.0),
                        blurRadius: 6.0,
                        spreadRadius: -6.0),
                  ],
                  ),
                  child: Center(child: Text('')),
                ),
              ),
            expandedHeight: 180,
            elevation: 0.0,
            backgroundColor: CustomColors().primaryGreenColor,
            iconTheme: IconThemeData(color: CustomColors().primaryWhiteColor),
            leading: IconButton(
                constraints: BoxConstraints(),
                padding: EdgeInsets.all(0.0),
                icon: Icon(Icons.cancel),
                color: CustomColors().darkGrayColor.withOpacity(0.4),
                iconSize: 32,
                onPressed: () => Navigator.pop(context),
              ),
          ),
          SliverToBoxAdapter(
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                // shadow top of container
                // boxShadow: [
                //   BoxShadow(
                //       color: CustomColors().blackColor.withOpacity(0.3),
                //       offset: Offset(-2, -6.0),
                //       blurRadius: 6.0,
                //       spreadRadius: -2.0),
                // ],
                color: CustomColors().primaryWhiteColor,
                // borderRadius: BorderRadius.only(
                //   topLeft: Radius.circular(40),
                //   topRight: Radius.circular(40),
                // ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Container(
                  //   margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  //   child: Text(
                  //     '$category',
                  //     style: TextStyle(
                  //       color: CustomColors().darkGrayColor,
                  //       fontWeight: FontWeight.bold,
                  //       fontSize: 17,
                  //     ),
                  //   ),
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        child: Text(
                          '$name',
                          style: TextStyle(
                            color: CustomColors().blackColor.withOpacity(0.9),
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                          ),
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          if (hasData.hasError == false) {
                            if (isAddToFavBtnEnabled) {
                              ProductCard.addToFav(
                                  context, isFavourite, productId!);
                              setState(() {
                                isFavourite = model.isFavourite;
                                isFavourite == true
                                    ? favIconColor = CustomColors().redColor
                                    : favIconColor = CustomColors().grayColor;
                              });
                            }
                          }
                        },
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.favorite,
                          color: favIconColor,
                        ),
                      ),
                    ],
                  ),
                   SizedBox(
                    height: 5,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Text(
                      '$category',
                      style: TextStyle(
                        color: CustomColors().darkGrayColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //row for price and counter
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                        child: Text(
                          ("$price " + LocaleKeys.sar.tr() +' / '+ unit!),
                          style: TextStyle(
                            color: CustomColors().primaryGreenColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      //  if (isProductAlreadyInCart) qtyContainer(),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  //Description
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocaleKeys.pro_description.tr(),
                          style: TextStyle(
                              color: CustomColors().darkGrayColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                        //TODO: replace with tab bar
                        Divider(
                          thickness: 1.5,
                          color: CustomColors().primaryGreenColor,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        '$description',
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          color: CustomColors().primaryWhiteColor,
          height: scHeight * 0.09,
          child: hasData.hasError == true
              ? errorText('${hasData.error}')
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: Text(
                        total > 0
                            ? ("$total " + LocaleKeys.sar.tr())
                            : ("$price " + LocaleKeys.sar.tr()),
                        style: TextStyle(
                          color: CustomColors().primaryGreenColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    addToCartBtnContainer(
                      context,
                      userQty: model.userProductQuantity,
                      productsModel: model,
                      onBtnClicked: () {
                        if (isAddToCartBtnEnabled) {
                          setState(() {
                            counter++;
                          });
                          addToCart(productId!);
                        }
                      },
                      onDecreaseBtnClicked: () {
                        setState(() {
                          if (isDecreaseBtnEnabled) {
                            setState(() {
                              counter > 1 ? counter-- : counter = 1;
                            });
                            deleteQtyFromCart(productId!);
                          }
                        });
                      },
                      onDeleteBtnClicked: () {
                        if (isTrashBtnEnabled) {
                          setState(() {
                            counter = 0;
                          });
                          deleteFromCart(productId!);
                        }
                      },
                      onIncreaseBtnClicked: () {
                        if (isIncreaseBtnEnabled) {
                          if (counter < stockQty!) {
                            setState(() {
                              counter++;
                            });
                            addQtyToCart(productId!);
                          } else
                            showSuccessMessage(
                                context, LocaleKeys.no_stock.tr());
                        }
                      },
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  ///-------------------------------
  ///-------------------------------
  ///---------DB process------------
  ///-------------------------------
  ///-------------------------------

  Future<ProductsModel> getPageData(String productId) async {
    Map<String, dynamic> headerMap = await getHeaderMap();

    ProductRepository productRepository = ProductRepository(headerMap);

    ApiResponse apiResponse = await productRepository.getProductById(productId);

    if (apiResponse.apiStatus.code == ApiResponseType.OK.code) {
      ProductsModel? responseModel = ProductsModel.fromJson(apiResponse.result);

      return responseModel;
    } else {
      throw ExceptionHelper(apiResponse.message);
    }
  }

  //----------------
  void deleteFromCart(String productId) async {
    print('counter $counter');
    isTrashBtnEnabled = false;
    String message =
        await cartDBProcess(context, productId, deleteFromCartConst);
    showSuccessMessage(context, message);
    setState(() {
      isTrashBtnEnabled = true;
      total = price!;
    });

    // Navigator.pop(context);
  }
  //----------------

  void addToCart(String productId) async {
    print('counter $counter');
    isAddToCartBtnEnabled = false;
    String message =
        await cartDBProcess(context, productId, addToCartConst);
    showSuccessMessage(context, message);
    setState(() {
      isAddToCartBtnEnabled = true;
      total = price!;
    });
    // Navigator.pop(context);
  }

  //---------------------
  void addQtyToCart(String productId) async {
    print('counter $counter , total $total');
    isIncreaseBtnEnabled = false;
    String message =
        await cartDBProcess(context, productId, addQtyToCartConst);
   // showSuccessMessage(context, message);
    print(message);

    setState(() {
      isIncreaseBtnEnabled = true;
      total = price! * counter;
    });
  }

  //---------------------
  void deleteQtyFromCart(String productId) async {
    print('counter $counter');
    isDecreaseBtnEnabled = false;
    String message = await cartDBProcess(
        context, productId, deleteQtyFromCartConst);
  //  showSuccessMessage(context, message);

    print(message);
    setState(() {
      isDecreaseBtnEnabled = true;
      total = total - price!;
    });
  }

  //---------------------

}
