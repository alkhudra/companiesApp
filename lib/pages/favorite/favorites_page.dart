import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khudrah_companies/Constant/api_const.dart';
import 'package:khudrah_companies/Constant/conts.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/designs/appbar_design.dart';
import 'package:khudrah_companies/designs/drawar_design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:khudrah_companies/designs/no_item_design.dart';

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
import 'package:khudrah_companies/network/models/user_model.dart';
import 'package:khudrah_companies/network/repository/product_repository.dart';
import 'package:khudrah_companies/pages/favorite/fav_tile.dart';
import 'package:khudrah_companies/pages/products/product_details.dart';
import 'package:khudrah_companies/provider/product_provider.dart';
import 'package:khudrah_companies/provider/notification_provider.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  double price = 6.0;
  static String name = '', email = '';
  int counter = 0;
  int pageSize = listItemsCount;
  int pageNumber = 1;
  bool isTrashBtnEnabled = true,
      isQtyTrashBtnEnabled = true,
      isAddToCartBtnEnabled = true,
      isIncreaseBtnEnabled = true,
      isDecreaseBtnEnabled = true;
  bool isThereMoreItems = false;
  final ScrollController _controller = ScrollController();

  void setValues() async {
    User user = await PreferencesHelper.getUser;
    name = user.companyName!;
    email = user.email!;
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      callData();
    }
  }

  @override
  void initState() {
    super.initState();
    setValues();
    _controller.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors().backgroundColor,
      body: FutureBuilder(
        future: callData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return listDesign();
          } else
            return errorCase(snapshot);
        },
      ),
      appBar: bnbAppBar(context, LocaleKeys.favorites.tr()),
      endDrawer: drawerDesignWithName(context, name, email),
    );
  }

  //-----------------------

  Future callData() async {
    final provider = Provider.of<ProductProvider>(context, listen: false);

    if (provider.favList.isEmpty || provider.getLoadMoreDataStatus == true) {
      //----------start api ----------------

      Map<String, dynamic> headerMap = await getHeaderMap();

      ProductRepository productRepository = ProductRepository(headerMap);

      ApiResponse apiResponse = await productRepository.getFavoriteProducts(
          pageSize, provider.pageNumber);
      if (apiResponse.apiStatus.code == ApiResponseType.OK.code) {
        ProductListResponseModel? responseModel =
            ProductListResponseModel.fromJson(apiResponse.result);
        provider.addItemsToFavList(responseModel.products);

        if (responseModel.products.length > 0) {
          if (responseModel.products.length < listItemsCount)
            provider.saveLoadMoreDataStatus(false);
          else
            provider.saveLoadMoreDataStatus(true);
        } else {
          provider.saveLoadMoreDataStatus(false);
          provider.resetPageNumber();
        }

        print('loading more items btn in first call $isThereMoreItems');
        return responseModel.products;
      } else
        throw ExceptionHelper(apiResponse.message);
    } else
      return provider.favList;
  }



  //-----------------------

  Widget listDesign() {
    return Consumer<ProductProvider>(
      builder: (context, provider, child) {
        return provider.favListCount > 0
            ? GridView.builder(
                controller: _controller,
                itemBuilder: (context, index) {
                  if (provider.getLoadMoreDataStatus == true) {
                    if (index == provider.favList.length - 1) {
                      return Center(child: CircularProgressIndicator());
                    }
                  }
                  return FavoriteTile(productModel: provider.favList[index]);
                },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              childAspectRatio: 14 / 17.4),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: provider.favListCount,
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 12),
              )
            : noItemDesign(
                LocaleKeys.no_fav_product.tr(), 'images/not_found.png');
      },
    );
  }


}
