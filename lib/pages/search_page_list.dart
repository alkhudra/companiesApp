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
/*
  final String keyWords;
  const SearchListPage({Key? key, required this.keyWords}) : super(key: key);
*/

  @override
  _SearchListPageState createState() => _SearchListPageState();
}

class _SearchListPageState extends State<SearchListPage> {
  final TextEditingController searchController = TextEditingController();

  int pageSize = listItemsCount;
  bool _isStartSearch = false;
  List<ProductsModel> list = [];
  int pageNumber = 1;
  String keyWord = '';

  bool _isMoreItems = true;
  final ScrollController _controller = ScrollController();
  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      getSearchResult(searchController.text);
    }
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    //String keyWord = widget.keyWords;
    return Scaffold(
      appBar: appBarDesign(context, LocaleKeys.search_title.tr()),
      // key: _scaffoldState,
      body: searchPageDesign(),
      /*    body: FutureBuilder(
        future: getSearchResult(keyWord),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return searchPageDesign(keyWord);
          } else
            return errorCase(snapshot);
        },
      ),*/
    );
  }

  //---------------------

  Widget searchPageDesign(/*String keyWord*/) {
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
            child: SearchHelper().searchBar(context, searchController, true,
                onclickAction: () {
              if (searchController.text != '') {
                getSearchResult(searchController.text);
                FocusScope.of(context).unfocus();
              }
              //  searchController.clear();
            }),
          ),
          SizedBox(
            height: 20,
          ),

          SizedBox(
            height: 10,
          ),
          //Newest deals title and button
          if (_isStartSearch == true)
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 15, right: 15),
                  child: Text(
                    LocaleKeys.search_result.tr() + ' \' ' + keyWord + ' \' ',
                    style: TextStyle(
                      color: CustomColors().darkBlueColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                list.length > 0
                    ? ProductList(
                        list,
                        enablePaging: true,
                        controller: _controller,
                      )
                    : noItemDesign(
                        LocaleKeys.no_result.tr(), 'images/not_found.png')
              ],
            )
          //   }),
        ],
      ),
    );
  }
  //---------------------

  void getSearchResult(String searchWord) async {
    //----------start api ----------------

    showLoaderDialog(context);
    Map<String, dynamic> headerMap = await getHeaderMap();
    ProductRepository productRepository = ProductRepository(headerMap);

    ApiResponse apiResponse = await productRepository.getSearchProducts(
        searchWord, pageSize, pageNumber);

    if (apiResponse.apiStatus.code == ApiResponseType.OK.code) {
      ProductListResponseModel? responseModel =
          ProductListResponseModel.fromJson(apiResponse.result);

      print('search word is ' + searchWord);
      print('result is ' + responseModel.products.toString());
      if (responseModel.products.length > 0) {
        if (responseModel.products.length < listItemsCount) {
          _isMoreItems = false;
          pageNumber = 1;
        } else {
          _isMoreItems = true;
          pageNumber += 1;
        }
      } else {
        _isMoreItems = false;
        pageNumber = 1;
      }

      if (pageNumber == 1)
        list = responseModel.products;
      else
        list.addAll(responseModel.products);

      Navigator.pop(context);
      setState(() {
        keyWord = searchController.text != null ? searchController.text : '';

        _isStartSearch = true;
      });
      Provider.of<ProductProvider>(context, listen: false)
          .addItemsToProductList(responseModel.products);

    } else
      throw ExceptionHelper(apiResponse.message);
  }
  //---------------------

}
