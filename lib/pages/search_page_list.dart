import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khudrah_companies/Constant/conts.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/designs/appbar_design.dart';
import 'package:khudrah_companies/designs/drawar_design.dart';
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
import 'package:easy_localization/easy_localization.dart';
import 'package:khudrah_companies/network/helper/exception_helper.dart';
import 'package:provider/provider.dart';

class SearchListPage extends StatefulWidget {
  final String keyWords;
  const SearchListPage({Key? key,required this.keyWords}) : super(key: key);

  @override
  _SearchListPageState createState() => _SearchListPageState();
}

class _SearchListPageState extends State<SearchListPage> {
  final TextEditingController searchController = TextEditingController();

  int pageSize = listItemsCount;

  final ScrollController _controller = ScrollController();
  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      getSearchResult(widget.keyWords);
    }
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(_scrollListener);
  }
  @override
  Widget build(BuildContext context) {
    String keyWord  = widget.keyWords;
    return Scaffold(
      appBar: appBarDesign(context, LocaleKeys.search_title.tr()),
      // key: _scaffoldState,
      body: FutureBuilder(
        future: getSearchResult(keyWord),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return searchPageDesign( keyWord);
          } else
            return errorCase(snapshot);
        },
      ),
    );
  }


  //---------------------

  Widget searchPageDesign(String keyWord) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          //Search bar and button
          Container(
            child: SearchHelper().searchBar(context, searchController,true),
          ),
          SizedBox(
            height: 20,
          ),

          SizedBox(
            height: 10,
          ),
          //Newest deals title and button
          Container(
            margin: EdgeInsets.only(left: 15, right: 15),
            child: Text(
              LocaleKeys.search_result.tr() +'  "$keyWord"',
              style: TextStyle(
                color: CustomColors().darkBlueColor,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            height: 10,
          ),

      Consumer<ProductProvider>(builder: (context, provider, child) {
        return provider.productListCount > 0
            ? ProductList(provider.productsList,enablePaging: true,controller: _controller,)
            : noItemDesign(
            LocaleKeys.no_result.tr(), 'images/not_found.png');
      }),



        ],
      ),
    );
  }
  //---------------------

  Future getSearchResult(String searchWord) async {
    //----------start api ----------------
    final provider = Provider.of<ProductProvider>(context, listen: true);

    if (provider.getLoadMoreDataStatus == true) {
    Map<String, dynamic> headerMap = await getHeaderMap();

    ProductRepository productRepository = ProductRepository(headerMap);

    ApiResponse apiResponse = await productRepository.getSearchProducts(
        searchWord, pageSize, provider.pageNumber);
    if (apiResponse.apiStatus.code == ApiResponseType.OK.code) {
      ProductListResponseModel? responseModel =
          ProductListResponseModel.fromJson(apiResponse.result);

      provider.addItemsToProductList(responseModel.products);

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
  }else
      return provider.productsList;}
  //---------------------

}
