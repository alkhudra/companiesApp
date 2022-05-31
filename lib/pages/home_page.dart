import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:khudrah_companies/Constant/api_const.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/designs/appbar_design.dart';
import 'package:khudrah_companies/designs/drawar_design.dart';
import 'package:khudrah_companies/designs/no_item_design.dart';
import 'package:khudrah_companies/designs/search_bar.dart';
import 'package:khudrah_companies/designs/text_field_design.dart';
import 'package:khudrah_companies/dialogs/message_dialog.dart';
import 'package:khudrah_companies/dialogs/two_btns_dialog.dart';
import 'package:khudrah_companies/helpers/image_helper.dart';
import 'package:khudrah_companies/helpers/pref/shared_pref_helper.dart';
import 'package:khudrah_companies/helpers/snack_message.dart';
import 'package:khudrah_companies/network/API/api_response.dart';
import 'package:khudrah_companies/network/API/api_response_type.dart';
import 'package:khudrah_companies/network/helper/exception_helper.dart';
import 'package:khudrah_companies/network/models/home/home_success_response_model.dart';
import 'package:khudrah_companies/network/models/product/product_model.dart';
import 'package:khudrah_companies/network/models/user_model.dart';
import 'package:khudrah_companies/network/helper/network_helper.dart';
import 'package:khudrah_companies/network/repository/home_repository.dart';
import 'package:khudrah_companies/pages/categories/all_category.dart';
import 'package:khudrah_companies/pages/products/product_list.dart';
import 'package:khudrah_companies/pages/search_page_list.dart';
import 'package:khudrah_companies/provider/branch_provider.dart';
import 'package:khudrah_companies/provider/genral_provider.dart';
import 'package:khudrah_companies/provider/product_provider.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'package:khudrah_companies/router/route_constants.dart';
import 'package:provider/provider.dart';
import 'branch/add_brunches_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:khudrah_companies/network/models/product/category_model.dart';
import 'cart_page.dart';
import 'categories/category_page.dart';
import 'package:widget_mask/widget_mask.dart';

class HomePage extends StatefulWidget {
  //final bool isHasBranch;
  const HomePage({Key? key /*, required this.isHasBranch*/}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //------------------------
  // GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  static String name = '', email = '';
  static String language = 'ar';

  //---------------------

  bool _isLoadedHome = false;
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return /*AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child:*/
        Scaffold(
      endDrawer: drawerDesignWithName(context, name, email),
      appBar: bnbAppBar(context, LocaleKeys.home.tr()),
      // key: _scaffoldState,
      body: FutureBuilder(
        future: getHomePage(), //provider.fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return homePageDesign();
          } else {
            if (Provider.of<ProductProvider>(context, listen: false)
                    .alreadyHasData ==
                false)
              return errorCase(snapshot);
            else
              return errorCaseInProviderCase(snapshot, homePageDesign());
          }
        },
      ),
    );
  }

  //---------------------
  Widget homePageDesign() {
    Size size = MediaQuery.of(context).size;
    double scWidth = size.width;
    double scHeight = size.height;

    // HomeSuccessResponseModel home = provider.homeModel;
/*    String categoryName = LocaleKeys.all_category.tr();
    List<CategoryItem>? categoryList = [
      CategoryItem(name: categoryName, arName: categoryName)
    ];
    for (CategoryItem categoryItem in provider.categoryList!) {
      categoryList.add(categoryItem);
    }*/
    /*name = home.user!.companyName!;
    email = home.user!.email!;*/

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
            child: SearchHelper().searchBar(context, searchController, false),
          ),
          SizedBox(
            height: 20,
          ),
          //Categories title
          Container(
            width: scWidth * 15,
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Text(
              LocaleKeys.categories.tr(),
              style: TextStyle(
                color: CustomColors().darkBlueColor,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          Consumer<ProductProvider>(builder: (context, provider, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Categories items
                Container(
                  margin: EdgeInsets.only(top: 25),
                  //   width: scWidth * 0.8,
                  height: scHeight * 0.16,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            // width: scWidth * 0.27,
                            width: scWidth * 0.23,
                            // height: scHeight * 0.11,
                            height: scHeight * 0.1,
                            margin: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 3),
                            child: GestureDetector(
                              child: ImageHelper.categoryImage(
                                  provider.categoryList[index].image),
                              onTap: () {
                                if (index != 0) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CategoryPage(
                                              categoriesItem:
                                                  provider.categoryList[index],
                                            )),
                                  );
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AllCategory()),
                                  );
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            setCategoryName(provider.categoryList[index])!,
                            style: TextStyle(
                                color: CustomColors().brownColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      );
                    },
                    itemCount:
                        provider.categoryListCount, //categoryList.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                //Newest deals title and button

                //Temp gesture detect, remove when done
                Container(
                  margin: EdgeInsets.only(left: 15, right: 15),
                  child: Text(
                    LocaleKeys.newest_deals.tr(),
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
                provider.productHomeListCount > 0
                    ? ProductList(
                        provider.homePageList,
                      )
                    : noItemDesign(
                        LocaleKeys.no_products.tr(), 'images/not_found.png'),
              ],
            );
          }),
          /*    SizedBox(
            height: 30,
          ),*/
        ],
      ),
    );
  }

  //------------------------
  static void setValues() async {
    User user = await PreferencesHelper.getUser;
    name = user.companyName!;
    email = user.email!;
    language = await PreferencesHelper.getSelectedLanguage;
  }

  //---------------------
  Future getHomePage() async {
    //----------start api ----------------
    final provider = Provider.of<ProductProvider>(context, listen: false);
    if (provider.alreadyHasData == false || _isLoadedHome == false) {
      //  if(provider.homePageList!.isEmpty) {
      print('@@@@@@@@@@ getting home items from db @@@@@@@@@@@@@@@');

      Map<String, dynamic> headerMap = await getHeaderMap();

      HomeRepository homeRepository = HomeRepository(headerMap);

      ApiResponse apiResponse = await homeRepository.getHomeInfo(context);
      if (apiResponse.apiStatus.code == ApiResponseType.OK.code) {
        HomeSuccessResponseModel model =
            HomeSuccessResponseModel.fromJson(apiResponse.result);

        PreferencesHelper.saveBranchesList(model.user!.branches!);
        Provider.of<BranchProvider>(context, listen: false)
            .setBranchList(model.user!.branches!);

        _isLoadedHome = true;

        provider.clearProvider();
        print('user id ' + model.user!.id!);
        provider.setHomeProductList(model.productsList!);
        provider.setHomeCategoryList(model.categoriesList!);
        provider.setAlreadyHasDataStatus(true);
        provider.setUser(model.user!);
        provider.setHomeModel(model);
        return model;
      } else {
        throw ExceptionHelper(apiResponse.message);
      }
    }
    return provider.getHomeModel;
  }

  //---------------------

  void showErrorDialog(String txt) {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) =>
            showMessageDialog(context, LocaleKeys.error.tr(), txt, noPage));
  }

  ////---------------------------

  @override
  void initState() {
    super.initState();

    setValues();
  }
//----------------------

  String? setCategoryName(CategoryItem categoryList) {
    return language == 'ar' ? categoryList.arName : categoryList.name;
  }
}
