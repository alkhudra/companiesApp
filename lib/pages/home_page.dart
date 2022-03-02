import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:khudrah_companies/Constant/api_const.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/designs/appbar_design.dart';
import 'package:khudrah_companies/designs/drawar_design.dart';
import 'package:khudrah_companies/designs/product_card.dart';
import 'package:khudrah_companies/designs/search_bar.dart';
import 'package:khudrah_companies/designs/text_field_design.dart';
import 'package:khudrah_companies/dialogs/message_dialog.dart';
import 'package:khudrah_companies/dialogs/two_btns_dialog.dart';
import 'package:khudrah_companies/helpers/pref/shared_pref_helper.dart';
import 'package:khudrah_companies/helpers/snack_message.dart';
import 'package:khudrah_companies/network/API/api_response.dart';
import 'package:khudrah_companies/network/API/api_response_type.dart';
import 'package:khudrah_companies/network/helper/exception_helper.dart';
import 'package:khudrah_companies/network/home_page_helper.dart';
import 'package:khudrah_companies/network/models/home/home_success_response_model.dart';
import 'package:khudrah_companies/network/models/product/product_model.dart';
import 'package:khudrah_companies/network/models/user_model.dart';
import 'package:khudrah_companies/network/helper/network_helper.dart';
import 'package:khudrah_companies/network/repository/home_repository.dart';
import 'package:khudrah_companies/pages/categories/all_category.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'package:khudrah_companies/router/route_constants.dart';
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

  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    //   final provider=Provider.of<HomePageProvider>(context);

    return /*AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child:*/
        Scaffold(
      endDrawer: drawerDesignWithName(context, name, email),
      appBar: bnbAppBar(context, LocaleKeys.home.tr()),
      // key: _scaffoldState,
      body: FutureBuilder<HomeSuccessResponseModel?>(
        future: getHomePage(), //provider.fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return homePageDesign(snapshot.data);
          } else
            return errorCase(snapshot);
        },
      ),
    );
  }

  //---------------------
  Widget homePageDesign(HomeSuccessResponseModel? home) {
    Size size = MediaQuery.of(context).size;
    double scWidth = size.width;
    double scHeight = size.height;

    String categoryName = LocaleKeys.all_category.tr();
    List<CategoryItem>? categoryList = [
      CategoryItem(name: categoryName, arName: categoryName)
    ];
    for (CategoryItem categoryItem in home!.categoriesList!) {
      categoryList.add(categoryItem);
    }
    name = home.user!.companyName!;
    email = home.user!.email!;
    PreferencesHelper.saveBranchesList(home.user!.branches!);

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
          // SizedBox(
          //   height: 10,
          // ),
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
                      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                      child: GestureDetector(
                        child: ProductCard.categoryImage(
                            categoryList[index].image),
                        onTap: () {
                          if (index != 0) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CategoryPage(
                                        categoriesItem: categoryList[index],
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
                      setCategoryName(categoryList[index])!,
                      style: TextStyle(
                          color: CustomColors().brownColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                );
              },
              itemCount: categoryList.length,
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
          Container(
            child: ListView.builder(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                ProductsModel model = home.productsList![index];
                String productId = model.productId!;
                return getProductCard(context, model, productId);
              },
              itemCount: home.productsList!.length,
            ),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  //------------------------
  static void setValues() async {
/*    User user = await PreferencesHelper.getUser;
    name = user.companyName!;
    email = user.email!;*/
    language = await PreferencesHelper.getSelectedLanguage;
  }

  //---------------------
  Future<HomeSuccessResponseModel?> getHomePage() async {
    //----------start api ----------------

    Map<String, dynamic> headerMap = await getHeaderMap();

    HomeRepository homeRepository = HomeRepository(headerMap);

    ApiResponse apiResponse = await homeRepository.getHomeInfo();
    if (apiResponse.apiStatus.code == ApiResponseType.OK.code)
      return HomeSuccessResponseModel.fromJson(apiResponse.result);
    else
      throw ExceptionHelper(apiResponse.message);
  }
  //---------------------

  void showErrorDialog(String txt) {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) =>
            showMessageDialog(context, LocaleKeys.error.tr(), txt, noPage));
  }

  void showAddBranchDialog() async {
    await Future.delayed(Duration(milliseconds: 50));
    List<Function()> actions = [
      () {
        addBranchesPage();
        //   Navigator.pop(context);
      },
      () {
        Navigator.pop(context);
      }
    ];
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => showTwoBtnDialog(
            context,
            LocaleKeys.add_branch.tr(),
            LocaleKeys.add_branch_note_dialog.tr(),
            LocaleKeys.add_branch_now.tr(),
            LocaleKeys.later.tr(),
            actions));
  }
  ////---------------------------

  void addBranchesPage() {
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddBranchesPage(
        cities: [],
        language: language,
      );
    }));
  }
  ////---------------------------

  @override
  void initState() {
    super.initState();

    setValues();
    //todo: show after calling api
    /*    if (widget.isHasBranch == false) {
      showAddBranchDialog();
    }*/
  }
//----------------------

  String? setCategoryName(CategoryItem categoryList) {
    return language == 'ar' ? categoryList.arName : categoryList.name;
  }

//----------------------
  getProductCard(BuildContext context, ProductsModel model, String productId) {
    return ProductCard.productCardDesign(context, language, model, () {
      bool? isFavourite = model.isFavourite;
      ProductCard.addToFav(context, isFavourite, productId);
      setState(() {
        isFavourite = !isFavourite!;
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
  }
}
