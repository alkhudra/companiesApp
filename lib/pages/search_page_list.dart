import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khudrah_companies/Constant/conts.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/designs/appbar_design.dart';
import 'package:khudrah_companies/designs/drawar_design.dart';
import 'package:khudrah_companies/designs/no_item_design.dart';
import 'package:khudrah_companies/designs/product_card.dart';
import 'package:khudrah_companies/designs/search_bar.dart';
import 'package:khudrah_companies/dialogs/progress_dialog.dart';
import 'package:khudrah_companies/helpers/custom_btn.dart';
import 'package:khudrah_companies/helpers/pref/shared_pref_helper.dart';
import 'package:khudrah_companies/network/API/api_response.dart';
import 'package:khudrah_companies/network/API/api_response_type.dart';
import 'package:khudrah_companies/network/helper/network_helper.dart';
import 'package:khudrah_companies/network/models/product/get_product_by_id_response_model.dart';
import 'package:khudrah_companies/network/models/product/product_model.dart';
import 'package:khudrah_companies/network/repository/product_repository.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:khudrah_companies/network/helper/exception_helper.dart';

class SearchListPage extends StatefulWidget {
  final String keyWords;
  const SearchListPage({Key? key,required this.keyWords}) : super(key: key);

  @override
  _SearchListPageState createState() => _SearchListPageState();
}

class _SearchListPageState extends State<SearchListPage> {
  final TextEditingController searchController = TextEditingController();

  int pageSize = listItemsCount;
  int pageNumber = 1;
  static String language = 'ar';
  List<ProductsModel> list = [];
  bool isThereMoreItems = true;
  @override
  Widget build(BuildContext context) {
    String keyWord  = widget.keyWords;
    return Scaffold(
      appBar: appBarDesign(context, LocaleKeys.search_title.tr()),
      // key: _scaffoldState,
      body: FutureBuilder<ProductListResponseModel?>(
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

  @override
  void initState() {
    super.initState();
    ProductCard.counter = ProductCard.counter;

    setValues();
  }

  //---------------------

  static void setValues() async {
    language = await PreferencesHelper.getSelectedLanguage;
  }
  //---------------------

/*  Widget errorCase(AsyncSnapshot<ProductListResponseModel?> snapshot) {
    if (snapshot.hasError) {
      return Text('${snapshot.error}');
    } else

      // By default, show a loading spinner.
      return loadingProgress();
  }*/
  //---------------------

  Widget searchPageDesign(String keyWord) {
    Size size = MediaQuery.of(context).size;
    double scWidth = size.width;
    double scHeight = size.height;

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

          Container(
            child:  list.length != 0 ? Container(
              child: Column(
                children: [
                  ListView.builder(
                    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ProductCard.productCardDesign(
                        context,
                        language,
                        list[index],
                          (){}
                      );
                    },
                    itemCount:list.length,
                  ),
                  if (isThereMoreItems == true) loadMoreBtn(context, loadMoreInfo),

                ],

              ),

            ):
             noItemDesign(LocaleKeys.no_result.tr(),'images/not_found.png'),
          ),

        ],
      ),
    );
  }
  //---------------------

  Future<ProductListResponseModel?> getSearchResult(String searchWord) async {
    //----------start api ----------------

    Map<String, dynamic> headerMap = await getHeaderMap();

    ProductRepository productRepository = ProductRepository(headerMap);

    ApiResponse apiResponse = await productRepository.getSearchProducts(
        searchWord, pageSize, pageNumber);
    if (apiResponse.apiStatus.code == ApiResponseType.OK.code) {
      ProductListResponseModel? responseModel =
          ProductListResponseModel.fromJson(apiResponse.result);
      if (pageNumber == 1) list = responseModel.products;
      else  list.addAll(responseModel.products);

      if (responseModel.products.length > 0) {
        if (responseModel.products.length < listItemsCount)
          isThereMoreItems = false;
        else
        isThereMoreItems = true;

      }else{
        isThereMoreItems = false;
        pageNumber = 1;
      }
      print('list is $list');
      return responseModel;
    } else
      throw ExceptionHelper(apiResponse.message);
  }
  //---------------------

  loadMoreInfo() async {
    setState(() {
      pageNumber++;
    });

  }
}
