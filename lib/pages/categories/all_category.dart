import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khudrah_companies/Constant/conts.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:khudrah_companies/designs/appbar_design.dart';

import 'package:khudrah_companies/designs/product_card.dart';
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
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'package:khudrah_companies/network/helper/exception_helper.dart';

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
  bool isThereMoreItems = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: 18,
            ),
            SearchHelper().searchBar(context, srController, false),
            SizedBox(
              height: 5,
            ),
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
      appBar: appBarWithActions(context,
        LocaleKeys.all_category.tr(), () {Navigator.pop(context);}),
      // endDrawer: drawerDesign(context),
    );
  }

  //------------

  Widget getListDesign() {

    return Expanded(
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            // physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder:(context, index) {
              ProductsModel model =list[index];
              String productId=model.productId!;
              return getProductCard(context,model,productId);
            },
            itemCount: list.length,
          ),
          if (isThereMoreItems == true)
            loadMoreBtn(context, loadMoreInfo),
        ],
      ),
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
      throw ExceptionHelper(apiResponse.message);
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

  //-------------------


  getProductCard(BuildContext context ,ProductsModel model ,String productId  ) {

    return ProductCard.productCardDesign(
        context, language, model, () {
      bool? isFavourite = model.isFavourite;
      ProductCard.addToFav(context, isFavourite,
          productId);
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



