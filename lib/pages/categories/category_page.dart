import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:khudrah_companies/Constant/conts.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/designs/appbar_design.dart';
import 'package:khudrah_companies/designs/drawar_design.dart';
import 'package:khudrah_companies/designs/no_item_design.dart';
import 'package:khudrah_companies/designs/product_card.dart';
import 'package:khudrah_companies/designs/search_bar.dart';
import 'package:khudrah_companies/helpers/custom_btn.dart';
import 'package:khudrah_companies/helpers/pref/shared_pref_helper.dart';
import 'package:khudrah_companies/network/API/api_response.dart';
import 'package:khudrah_companies/network/API/api_response_type.dart';
import 'package:khudrah_companies/network/helper/network_helper.dart';
import 'package:khudrah_companies/network/models/home/home_success_response_model.dart';
import 'package:khudrah_companies/network/models/product/get_products_list_response_model.dart';
import 'package:khudrah_companies/network/models/product/product_model.dart';
import 'package:khudrah_companies/network/repository/product_repository.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'package:khudrah_companies/network/models/product/category_model.dart';
import 'package:khudrah_companies/network/helper/exception_helper.dart';

class CategoryPage extends StatefulWidget {
  final CategoryItem categoriesItem;
  const CategoryPage({Key? key, required this.categoriesItem})
      : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  TextEditingController srController = TextEditingController();
  int pageSize = listItemsCount;
  int pageNumber = 1;
  static String language = 'ar';

  List<ProductsModel> list = [];
  bool isThereMoreItems = true;
  static void setValues() async {
    language = await PreferencesHelper.getSelectedLanguage;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setValues();
  }

  @override
  Widget build(BuildContext context) {
    final CategoryItem item = widget.categoriesItem;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        child: Expanded(
          child: Column(
            children: [
              SizedBox(
                height: 18,
              ),
                SearchHelper().searchBar(context, srController,false),
              SizedBox(
                height: 10,
              ),
              FutureBuilder<ProductListResponseModel?>(
                future: getInfoFromDB(item.id!),
                builder: (context, snapshot) {
                  print(snapshot.toString());
                  if (snapshot.hasData) {
                    return getListDesign(snapshot.data);
                  } else
                    return errorCase(snapshot);
                },
              ),
            ],
          ),
        ),
      ),
      //load more button
      floatingActionButton: SizedBox(
        height: 45,
        width: 180,
        child: FloatingActionButton(
          child: Text(LocaleKeys.load_more.tr(), style: TextStyle(
            fontWeight: FontWeight.w600
          ),),
          onPressed: () {
            // loadMoreInfo();
            if (isThereMoreItems == true)
              loadMoreInfo(); 
          },
          backgroundColor: CustomColors().grayColor,
          foregroundColor: CustomColors().darkBlueColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40)
          ),
          elevation: 0.0,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: appBarWithActions(context,
        setCategoryName(item)!, () {Navigator.pop(context);}),
    );
  }

  //------------

  Widget getListDesign(ProductListResponseModel? snapshot) {

    return list.length >0 ? Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        // physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemBuilder:(context, index) {
          ProductsModel model = list[index];
          String productId=model.productId!;
          return getProductCard(context,model,productId);
        },
        itemCount: list.length,
      ),
    ): noItemDesign(LocaleKeys.no_items_category.tr(), 'images/not_found.png');

  }


//--------

  Future<ProductListResponseModel?> getInfoFromDB(String categoryId) async {
    //----------start api ----------------

    Map<String, dynamic> headerMap = await getHeaderMap();

    ProductRepository productRepository = ProductRepository(headerMap);

    ApiResponse apiResponse = await productRepository.getProductByCategory(
        categoryId, pageSize, pageNumber);
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
//--------

  loadMoreInfo() async {
    setState(() {
      pageNumber++;
    });

  }
  //--------

  String? setCategoryName(CategoryItem categoryList) {
    return language == 'ar' ? categoryList.arName : categoryList.name;
  }

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
