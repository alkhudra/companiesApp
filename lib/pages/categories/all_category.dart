import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khudrah_companies/Constant/conts.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:khudrah_companies/designs/appbar_design.dart';
import 'package:khudrah_companies/designs/no_item_design.dart';

import 'package:khudrah_companies/designs/search_bar.dart';
import 'package:khudrah_companies/dialogs/progress_dialog.dart';
import 'package:khudrah_companies/helpers/custom_btn.dart';

import 'package:khudrah_companies/helpers/pref/shared_pref_helper.dart';
import 'package:khudrah_companies/network/API/api_response.dart';
import 'package:khudrah_companies/network/API/api_response_type.dart';
import 'package:khudrah_companies/network/helper/network_helper.dart';
import 'package:khudrah_companies/network/models/product/get_products_list_response_model.dart';
import 'package:khudrah_companies/network/models/product/product_model.dart';
import 'package:khudrah_companies/network/repository/product_repository.dart';
import 'package:khudrah_companies/pages/products/product_list.dart';
import 'package:khudrah_companies/provider/product_provider.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'package:khudrah_companies/network/helper/exception_helper.dart';
import 'package:provider/provider.dart';

import '../search_page_list.dart';

class AllCategory extends StatefulWidget {
  const AllCategory({Key? key}) : super(key: key);

  @override
  _AllCategoryState createState() => _AllCategoryState();
}

class _AllCategoryState extends State<AllCategory> {
  TextEditingController srController = TextEditingController();
  int pageSize = listItemsCount;
  bool _isFirstCall = true;
  final ScrollController _controller = ScrollController();

  void _scrollListener() {
    print('/////////// @@@@@@@@@@@@@@@@@@@ run listenner');
    if (_controller.position.pixels >= _controller.position.maxScrollExtent) {
      getInfoFromDB();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return Column(
              children: [
                SizedBox(
                  height: 18,
                ),
                SearchHelper().searchBar(context, srController, false),
                SizedBox(
                  height: 5,
                ),
                FutureBuilder(
                  future: getInfoFromDB(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return getListDesign();
                    } else
                      return errorCase(snapshot);
                  },
                ),
              ],
            );
          }),
      appBar: appBarDesign(context, LocaleKeys.all_category.tr()),
      // endDrawer: drawerDesign(context),
    );
  }

  //------------

  Widget getListDesign() {
    return Consumer<ProductProvider>(builder: (context, provider, child) {
      return provider.productListCount > 0
          ? ProductList(
              provider.productsList,
              enablePaging: true,
              controller: _controller,
            )
          : noItemDesign(
              LocaleKeys.no_items_category.tr(), 'images/not_found.png');
    });
  }

  Future getInfoFromDB() async {
    //----------start api ----------------
    final provider = Provider.of<ProductProvider>(context, listen: false);
    if (_isFirstCall) {
      provider.resetPageNumber();
      provider.resetProductList();
      _isFirstCall = false;
    }
    if (provider.getLoadMoreDataStatus == true) {
      Map<String, dynamic> headerMap = await getHeaderMap();

      ProductRepository productRepository = ProductRepository(headerMap);

      ApiResponse apiResponse =
          await productRepository.getProducts(pageSize, provider.pageNumber);
      if (apiResponse.apiStatus.code == ApiResponseType.OK.code) {
        ProductListResponseModel? responseModel =
            ProductListResponseModel.fromJson(apiResponse.result);

        //provider.resetFavProductList();
        provider.addItemsToProductList(responseModel.products);
        provider.plusPageNumber();

        if (responseModel.products.length > 0) {
          if (responseModel.products.length < listItemsCount)
            provider.saveLoadMoreDataStatus(false);
          else
            provider.saveLoadMoreDataStatus(true);
        } else {
          provider.saveLoadMoreDataStatus(false);
          provider.resetPageNumber();
        }

        return responseModel.products;
      } else
        throw ExceptionHelper(apiResponse.message);
    } else
      return provider.productsList;
  }

  //-------------------

}
