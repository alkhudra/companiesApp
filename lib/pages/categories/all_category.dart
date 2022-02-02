import 'package:flutter/material.dart';
import 'package:khudrah_companies/Constant/conts.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';

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

class AllCategory extends StatefulWidget {
  const AllCategory({Key? key}) : super(key: key);

  @override
  _AllCategoryState createState() => _AllCategoryState();
}

class _AllCategoryState extends State<AllCategory> {
  TextEditingController srController = TextEditingController();
  int pageSize = listItemsCount;
  int pageNumber = 1;
  static String language = 'ar';

  List<ProductsModel> list = [];
  bool isThereMoreItems = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: CustomColors().primaryGreenColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: true,
            // collapsedHeight: 200,
            title: Text(
              LocaleKeys.all_category.tr(),
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
            ),
            flexibleSpace: Stack(
              children: [
                Positioned.fill(
                  left: 180,
                  child: Image.asset('images/grapevector.png'),
                ),
              ],
            ),
            expandedHeight: 160,
            elevation: 0.0,
            backgroundColor: CustomColors().primaryGreenColor,
            iconTheme: IconThemeData(color: CustomColors().primaryWhiteColor),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              color: CustomColors().primaryWhiteColor,
              onPressed: () => Navigator.pop(context),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              width: double.infinity,
              // height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: CustomColors().primaryWhiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 18,
                  ),
                  SearchHelper().searchBar(context, srController, false),
                  // SizedBox(
                  //   height: 5,
                  // ),
                  FutureBuilder<ProductListResponseModel?>(
                    future: getInfoFromDB(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        ProductListResponseModel? m=    snapshot.data;
                        print("data is $m");
                        return getListDesign();
                      } else
                        return errorCase(snapshot);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // endDrawer: drawerDesign(context),
    );
  }

  //------------

  Widget getListDesign() {

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return ProductCard.productCardDesign(
                context,
                language,
                list[index],
              );
            },
            itemCount: list.length,
          ),
        ),
        if (isThereMoreItems == true) loadMoreBtn(context, loadMoreInfo),
      ],
    );
  }


  Future<ProductListResponseModel?> getInfoFromDB() async {
    //----------start api ----------------

    Map<String, dynamic> headerMap = await getHeaderMap();

    ProductRepository productRepository = ProductRepository(headerMap);

    ApiResponse apiResponse =
        await productRepository.getProducts(pageSize, pageNumber);
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
      throw Exception(apiResponse.message);
  }

//---------------------
  static void setValues() async {
    language = await PreferencesHelper.getSelectedLanguage;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setValues();
  }
//---------------------

  loadMoreInfo() async {
    setState(() {
      pageNumber++;
    });

  }
}
