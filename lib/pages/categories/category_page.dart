import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/designs/drawar_design.dart';
import 'package:khudrah_companies/designs/product_card.dart';
import 'package:khudrah_companies/designs/search_bar.dart';
import 'package:khudrah_companies/helpers/custom_btn.dart';
import 'package:khudrah_companies/helpers/pref/shared_pref_helper.dart';
import 'package:khudrah_companies/network/API/api_response.dart';
import 'package:khudrah_companies/network/API/api_response_type.dart';
import 'package:khudrah_companies/network/helper/network_helper.dart';
import 'package:khudrah_companies/network/models/home/home_success_response_model.dart';
import 'package:khudrah_companies/network/models/product/get_product_by_id_response_model.dart';
import 'package:khudrah_companies/network/models/product/product_model.dart';
import 'package:khudrah_companies/network/repository/product_repository.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'package:khudrah_companies/network/models/product/category_model.dart';
class CategoryPage extends StatefulWidget {
  final CategoryItem categoriesItem;
  const CategoryPage({Key? key, required this.categoriesItem})
      : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  TextEditingController srController = TextEditingController();
  int pageSize = 3;
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
      backgroundColor: CustomColors().primaryGreenColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: true,
            // collapsedHeight: 200,
            title: Text(
              setCategoryName(item)!,
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
            child:Container(
              // margin: EdgeInsets.only(top: 100),
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
                  searchBar(context, srController),
                  SizedBox(
                    height: 10,
                  ),
                  FutureBuilder<ProductListResponseModel?>(
                    future: getInfoFromDB(item.id!),
                    builder: (context, snapshot) {
                      print(snapshot.toString());
                      if (snapshot.hasData) {
                        print(snapshot.hasData);
                        print(snapshot.data);
                        //     list.addAll(snapshot.data!.products);

                        return getListDesign(snapshot.data);
                      } else
                        return errorCase(snapshot);
                    },
                  ),

                ],
              ),
            ) ,
          ),
        ],
      ),
    );
  }

  //------------

  Widget getListDesign(ProductListResponseModel? snapshot) {
/*    if (snapshot!.products.length > 0) {
      setState(() {
        list.addAll(snapshot.products);
        isThereMoreItems = true;
        pageNumber++;
      });
    } else {
      setState(() {
        isThereMoreItems = false;
        pageNumber = 1;
      });
    }*/
    list.addAll(snapshot!.products);

    return  Column(
      children: [
        Container(
          child: ListView.builder(
            keyboardDismissBehavior:
            ScrollViewKeyboardDismissBehavior.onDrag,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return ProductCard.productCardDesign(
                context,
                language ,
                list[index],
              );
            },
            itemCount: list.length,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        if (isThereMoreItems)
                Container(
          width: MediaQuery.of(context).size.width*0.8,
          height: MediaQuery.of(context).size.height*0.06,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: CustomColors().grayColor,
          ),
          child: TextButton(
            onPressed: () {
              //todo:paging
            }, 
            child: Text(LocaleKeys.load_more.tr(), 
            style: TextStyle(
              color: CustomColors().darkBlueColor,
              fontWeight: FontWeight.w600
            ),)
          ),
        ),
        SizedBox(
          height: 20,
        ),
          // greenBtn('load more', EdgeInsets.all(10), () {


          //   //todo:paging
          // })
      ],
    )
    ;
  }
//--------

  Widget errorCase(AsyncSnapshot<ProductListResponseModel?> snapshot) {
    if (snapshot.hasError) {
      return Text('${snapshot.error}');
    } else

      // By default, show a loading spinner.
      return Center(child: Container(
          margin: EdgeInsets.only(top:30),
          child: CircularProgressIndicator()));
  }

  Future<ProductListResponseModel?> getInfoFromDB(String categoryId) async {
    //----------start api ----------------

    Map<String, dynamic> headerMap = await getHeaderMap();

    ProductRepository productRepository = ProductRepository(headerMap);

    ApiResponse apiResponse = await productRepository.getProductByCategory(
        categoryId, pageSize, pageNumber);
    if (apiResponse.apiStatus.code == ApiResponseType.OK.code) {
      ProductListResponseModel? responseModel =
          ProductListResponseModel.fromJson(apiResponse.result);

      return responseModel;
    } else
      throw Exception(apiResponse.message);
  }

  String? setCategoryName(CategoryItem categoryList) {
    return language == 'ar' ? categoryList.arName : categoryList.name;
  }
}
