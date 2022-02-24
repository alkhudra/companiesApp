import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khudrah_companies/Constant/api_const.dart';
import 'package:khudrah_companies/Constant/conts.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/designs/appbar_design.dart';
import 'package:khudrah_companies/designs/drawar_design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:khudrah_companies/designs/no_item_design.dart';
import 'package:khudrah_companies/designs/product_card.dart';
import 'package:khudrah_companies/dialogs/progress_dialog.dart';
import 'package:khudrah_companies/helpers/cart_helper.dart';
import 'package:khudrah_companies/helpers/custom_btn.dart';
import 'package:khudrah_companies/helpers/pref/shared_pref_helper.dart';
import 'package:khudrah_companies/helpers/snack_message.dart';
import 'package:khudrah_companies/network/API/api_response.dart';
import 'package:khudrah_companies/network/API/api_response_type.dart';
import 'package:khudrah_companies/network/helper/exception_helper.dart';
import 'package:khudrah_companies/network/helper/network_helper.dart';
import 'package:khudrah_companies/network/models/message_response_model.dart';
import 'package:khudrah_companies/network/models/product/get_products_list_response_model.dart';
import 'package:khudrah_companies/network/models/product/product_model.dart';
import 'package:khudrah_companies/network/repository/product_repository.dart';
import 'package:khudrah_companies/pages/products/product_details.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  double price = 6.0;
  int counter = 0;
  int pageSize = listItemsCount;
  int pageNumber = 1;
  bool isTrashBtnEnabled = true,
      isQtyTrashBtnEnabled = true,
      isAddToCartBtnEnabled = true,
      isIncreaseBtnEnabled = true,
      isDecreaseBtnEnabled = true;
  static List<ProductsModel> list = [];
  bool isThereMoreItems = false;
  static String language = 'ar';

  void setValues() async {
    language = await PreferencesHelper.getSelectedLanguage;
  }

  @override
  void initState() {
    super.initState();
    setValues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors().backgroundColor,
      body: FutureBuilder<ProductListResponseModel?>(
        future: getInfoFromDB(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return listDesign(snapshot.data!);
          } else
            return errorCase(snapshot);
        },
      ),
      appBar: bnbAppBar(context, LocaleKeys.favorites.tr()),
      endDrawer: drawerDesign(context),
    );
  }

  loadMoreInfo() async {
    setState(() {
      pageNumber++;
    });
  }

  //-----------------------

  Future<ProductListResponseModel?> getInfoFromDB() async {
    //----------start api ----------------

    Map<String, dynamic> headerMap = await getHeaderMap();

    ProductRepository productRepository = ProductRepository(headerMap);

    ApiResponse apiResponse =
        await productRepository.getFavoriteProducts(pageSize, pageNumber);
    if (apiResponse.apiStatus.code == ApiResponseType.OK.code) {
      ProductListResponseModel? responseModel =
          ProductListResponseModel.fromJson(apiResponse.result);
      if (pageNumber == 1)
        list = responseModel.products;
      else
        list.addAll(responseModel.products);

      if (responseModel.products.length > 0) {
        if (responseModel.products.length < listItemsCount)
          isThereMoreItems = false;
        else
          isThereMoreItems = true;
      } else {
        isThereMoreItems = false;
        pageNumber = 1;
      }
      print('list is $list');
      return responseModel;
    } else
      throw ExceptionHelper(apiResponse.message);
  }

  //-----------------------

  Widget listDesign(ProductListResponseModel? snapshot) {
    return list.length > 0
        ? Column(
            children: [
              GridView.builder(
                itemBuilder: (context, index) {
                  String productId = list[index].productId!;
                  return ProductCard.favoritesCard(
                      context, language, list[index], () {
                    deleteFromFav(context, productId).then((value) {
                      if (value == true) {
                        setState(() {
                          list.remove(list[index]);
                        });
                      }
                    });
                  }, onIncreaseBtnClicked: () {
                    setState(() {
                      ProductCard.addQtyToCart(context, productId);
                    });
                  }, onDecreaseBtnClicked: () {
                    setState(() {
                      ProductCard.deleteQtyFromCart(context, productId);
                    });
                  }, onDeleteBtnClicked: () {
                    setState(() {
                      ProductCard.deleteFromCart(context, productId);
                    });
                  }, onAddBtnClicked: () {
                    setState(() {
                      ProductCard.addToCart(context, productId);
                    });
                  });
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 14 / 17.4),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: list.length,
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 12),
              ),
              if (isThereMoreItems == true) loadMoreBtn(context, loadMoreInfo),
            ],
          )
        : noItemDesign(LocaleKeys.no_fav_product.tr(), 'images/not_found.png');
  }

//-----------------------

  static Future<bool> deleteFromFav(
      BuildContext context, String productId) async {
    // showLoaderDialog(context);
    //----------start api ----------------

    Map<String, dynamic> headerMap = await getHeaderMap();

    ProductRepository productRepository = ProductRepository(headerMap);
    ApiResponse apiResponse;

    apiResponse = await productRepository.deleteProductFromFav(productId);

    if (apiResponse.apiStatus.code == ApiResponseType.OK.code) {
      MessageResponseModel model =
          MessageResponseModel.fromJson(apiResponse.result);
      showSuccessMessage(context, model.message!);
      return true;
    } else {
      throw ExceptionHelper(apiResponse.message);
    }
  }
}
