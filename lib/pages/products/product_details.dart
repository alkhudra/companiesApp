import 'package:flutter/material.dart';
import 'package:khudrah_companies/Constant/api_const.dart';
import 'package:khudrah_companies/Constant/conts.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/designs/product_card.dart';
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
          return pageDesign(context, snapshot.data!);
        } else {
          return errorCase(snapshot);
        }
      },
    );
  }

  Widget pageDesign(BuildContext context, ProductsModel model) {
    String language = widget.language;
    Size size = MediaQuery.of(context).size;
    double scWidth = size.width;
    double scHeight = size.height;

    price = (model.hasSpecialPrice == true
            ? model.specialPrice
            : model.originalPrice)
        ?.toDouble();
    String? description = language == 'ar'
        ? model.arDescription
        : model.description;
    String? productId = model.productId;
    String? category = language == 'ar'
        ? model.arCategoryName
        : model.categoryName;

    String? name = language == 'ar'
        ? model.arName
        : model.name;
    String imageUrl = ApiConst.images_url + model.image!;
    bool? isFavourite = model.isFavourite;

    Color favIconColor = isFavourite == true
        ? CustomColors().redColor
        : CustomColors().primaryWhiteColor;
    //counter = 0;
    bool isAvailable = model.isAvailabe!;
    bool isDeleted = model.isDeleted!;
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
              InkWell(
                  onTap: () {
                    if (isAddToFavBtnEnabled) {
                      ProductCard.addToFav(context, isFavourite, productId!);
                      setState(() {
                        isFavourite = !isFavourite!;
                        isFavourite == true
                            ? favIconColor = CustomColors().redColor
                            : favIconColor = CustomColors().primaryWhiteColor;
                      });
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.favorite,
                      color: favIconColor,
                    ),
                  )
                  // isFavourite == true ? Icon(Icons.favorite, color: CustomColors().redColor)
                  // : Icon(Icons.favorite, color: CustomColors().primaryWhiteColor,),
                  ),
              /*       IconButton(
                icon: Icon(
                  Icons.share_outlined,
                  color: CustomColors().primaryWhiteColor,
                ),
                onPressed: () {
                },
              ),*/
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
                  SizedBox(
                    height: 20,
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
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Text(
                      '$name',
                      style: TextStyle(
                        color: CustomColors().blackColor.withOpacity(0.9),
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  //row for price and counter
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                        child: Text(
                          ("$price " + LocaleKeys.sar_per_kg.tr()),
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
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      '$description',
                      overflow: TextOverflow.clip,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: scHeight * 0.09,
          child: Row(
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
                isDeleted: isDeleted,
                isAvailable: isAvailable,
                counter: counter,
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
                    setState(() {
                      counter++;
                    });
                    addQtyToCart(productId!);
                  }
                },
              )
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
        await cartDBProcess(context, productId, counter, deleteFromCartConst);
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
        await cartDBProcess(context, productId, counter, addToCartConst);
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
        await cartDBProcess(context, productId, counter, addQtyToCartConst);
    showSuccessMessage(context, message);

    setState(() {
      isIncreaseBtnEnabled = true;
      total = price! * counter;
    });
  }

  //---------------------
  void deleteQtyFromCart(String productId) async {
    print('counter $counter');
    isDecreaseBtnEnabled = false;
    String message =
        await cartDBProcess(context, productId, counter, deleteFromCartConst);
    showSuccessMessage(context, message);

    setState(() {
      isDecreaseBtnEnabled = true;
      total = total - price!;
    });
  }

  //---------------------

}
