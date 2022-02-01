import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khudrah_companies/Constant/conts.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/designs/appbar_design.dart';
import 'package:khudrah_companies/designs/drawar_design.dart';
import 'package:khudrah_companies/designs/product_card.dart';
import 'package:khudrah_companies/designs/search_bar.dart';
import 'package:khudrah_companies/helpers/pref/shared_pref_helper.dart';
import 'package:khudrah_companies/network/API/api_response.dart';
import 'package:khudrah_companies/network/API/api_response_type.dart';
import 'package:khudrah_companies/network/helper/network_helper.dart';
import 'package:khudrah_companies/network/models/product/get_product_by_id_response_model.dart';
import 'package:khudrah_companies/network/repository/product_repository.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'package:easy_localization/easy_localization.dart';

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

  @override
  Widget build(BuildContext context) {
    String keyWord  = widget.keyWords;
    return Scaffold(
      appBar: appBarDesign(context, LocaleKeys.search_title.tr()),
      // key: _scaffoldState,
      body: FutureBuilder<ProductListResponseModel?>(
        future: getSearchResult(keyWord),
        builder: (context, snapshot) {
          print(snapshot.toString());
          if (snapshot.hasData) {
            print(snapshot.hasData);
            print(snapshot.data);
            return searchPageDesign(snapshot.data , keyWord);
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

  Widget errorCase(AsyncSnapshot<ProductListResponseModel?> snapshot) {
    if (snapshot.hasError) {
      return Text('${snapshot.error}');
    } else

      // By default, show a loading spinner.
      return Center(child: CircularProgressIndicator());
  }
  //---------------------

  Widget searchPageDesign(ProductListResponseModel? model,String keyWord) {
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
            child:  model!.products.length != 0 ? ListView.builder(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ProductCard.productCardDesign(
                  context,
                  language,
                  model.products[index],
                );
              },
              itemCount: model.products.length,
            ):Container(
              margin: EdgeInsets.only(top: 30),
              child: Center(
                  child: Text(LocaleKeys.no_result.tr(),style: TextStyle(
                fontSize: 20,
                color: CustomColors().primaryGreenColor
              ),)),
            ) ,
          ),
          SizedBox(
            height: 30,
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

      return responseModel;
    } else
      throw Exception(apiResponse.message);
  }
}
