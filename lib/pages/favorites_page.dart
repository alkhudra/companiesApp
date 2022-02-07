import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khudrah_companies/Constant/api_const.dart';
import 'package:khudrah_companies/Constant/conts.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/designs/appbar_design.dart';
import 'package:khudrah_companies/designs/drawar_design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:khudrah_companies/designs/no_item_design.dart';
import 'package:khudrah_companies/dialogs/progress_dialog.dart';
import 'package:khudrah_companies/helpers/custom_btn.dart';
import 'package:khudrah_companies/helpers/pref/shared_pref_helper.dart';
import 'package:khudrah_companies/helpers/snack_message.dart';
import 'package:khudrah_companies/network/API/api_response.dart';
import 'package:khudrah_companies/network/API/api_response_type.dart';
import 'package:khudrah_companies/network/helper/exception_helper.dart';
import 'package:khudrah_companies/network/helper/network_helper.dart';
import 'package:khudrah_companies/network/models/message_response_model.dart';
import 'package:khudrah_companies/network/models/product/get_product_by_id_response_model.dart';
import 'package:khudrah_companies/network/models/product/product_model.dart';
import 'package:khudrah_companies/network/repository/product_repository.dart';
import 'package:khudrah_companies/pages/products/product_details.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  double price = 6.0;
  int counter = 0;
  int pageSize = listItemsCount;
  int pageNumber = 1;

  static List<ProductsModel> list = [];
  bool isThereMoreItems = true;
  static String language = 'ar';
  bool isTrashBtnEnabled = true;
  void setValues() async {
    language = await PreferencesHelper.getSelectedLanguage;
  }

  @override
  void initState() {
    super.initState();
    setValues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors().backgroundColor,
      body: FutureBuilder<ProductListResponseModel?>(
        future: getInfoFromDB(),
        builder: (context, snapshot) {
          print(snapshot.toString());
          if (snapshot.hasData) {
            print(snapshot.hasData);
            print(snapshot.data);
            //     list.addAll(snapshot.data!.products);

            return listDesign(snapshot.data);
          } else
            return errorCase(snapshot);
        },
      ),
      appBar: bnbAppBar(context, LocaleKeys.favorites.tr()),
      endDrawer: drawerDesign(context),
    );
  }

  loadMoreInfo() async {
    setState(() {
      pageNumber++;
    });
  }
  //-----------------------

  Future<ProductListResponseModel?> getInfoFromDB() async {
    //----------start api ----------------

    Map<String, dynamic> headerMap = await getHeaderMap();

    ProductRepository productRepository = ProductRepository(headerMap);

    ApiResponse apiResponse =
        await productRepository.getFavoriteProducts(pageSize, pageNumber);
    if (apiResponse.apiStatus.code == ApiResponseType.OK.code) {
      ProductListResponseModel? responseModel =
          ProductListResponseModel.fromJson(apiResponse.result);
      if (pageNumber == 1)
        list = responseModel.products;
      else
        list.addAll(responseModel.products);

      if (responseModel.products.length > 0) {
        if (responseModel.products.length < listItemsCount)
          isThereMoreItems = false;
        else
          isThereMoreItems = true;
      } else {
        isThereMoreItems = false;
        pageNumber = 1;
      }
      print('list is $list');
      return responseModel;
    } else
      throw ExceptionHelper(apiResponse.message);
  }

  //-----------------------

  Widget listDesign(ProductListResponseModel? snapshot) {
    return list.length > 0
        ? Column(
            children: [
              GridView.builder(
                itemBuilder: (context, index) {
                  return favoritesCard(index);
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 14 / 17.4),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: list.length,
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 12),
              ),
              if (isThereMoreItems == true) loadMoreBtn(context, loadMoreInfo),
            ],
          )
        : noItemDesign(LocaleKeys.no_fav_product.tr(), 'images/not_found.png');
  }

  //-----------------------

  Widget favoritesCard(int index) {
    Size size = MediaQuery.of(context).size;
    double scWidth = size.width;
    double scHeight = size.height;
    ProductsModel productModel = list[index];
    double? price = (productModel.hasSpecialPrice == true
            ? productModel.specialPrice
            : productModel.originalPrice)
        ?.toDouble();

    String? productId = productModel.productId;

    String? name = language == 'ar' ? productModel.arName : productModel.name;
    String imageUrl = productModel.image != null
        ? ApiConst.images_url + productModel.image!
        : 'images/green_fruit.png';
    return GridTile(
      child: Container(
        decoration: BoxDecoration(
            color: CustomColors().primaryWhiteColor,
            // image: DecorationImage(
            //   image: AssetImage('images/green_fruit.png'),
            // ),
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                  color: CustomColors().darkGrayColor.withOpacity(0.4),
                  offset: Offset(2.0, 2.0),
                  blurRadius: 3.0,
                  spreadRadius: .8)
            ]),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProductDetails(
                          productModel: productModel,
                          language: language,
                        )));
          },
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  //Delete icon
                  Container(
                    margin: EdgeInsets.only(top: 10, left: 15, right: 15),
                    child: IconButton(
                      onPressed: () {
                        if (isTrashBtnEnabled) {
                          deleteItemFromFav(productModel);
                        }
                      },
                      icon: Icon(
                        FontAwesomeIcons.trash,
                        color: CustomColors().redColor,
                        size: 20,
                      ),
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                    ),
                  ),
                ],
              ),
              //name and other details
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: scWidth*0.18,
                    height: scHeight*0.1,
                    //todo:image edit
                    child: Image.network(imageUrl),
                  ),
                  //name
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(vertical: 7),
                    child: Text(
                      name!,
                      style: TextStyle(
                        color: CustomColors().brownColor,
                        fontSize: 18.5,
                      ),
                    ),
                  ),
                  Container(
                    width: scWidth * 0.3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //price
                        Container(
                          child: Text(
                            '$price  ' + LocaleKeys.sar_per_kg.tr(),
                            style: TextStyle(
                                color: CustomColors().primaryGreenColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(height: scHeight*0.01,),
                  //Counter and cart icon row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //Counter
                      Container(
                        width: 80,
                        height: 26,
                        margin: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: CustomColors().grayColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                // counter >= 0 ? counter -= counter : counter;
                              },
                              child: Container(
                                padding: EdgeInsets.all(4),
                                child: Text(
                                  '-',
                                  style: TextStyle(
                                    color: CustomColors().darkBlueColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              child: Text(
                                '$counter',
                                style: TextStyle(
                                  color: CustomColors().blackColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                // counter >= 0 ? counter += counter : counter;
                              },
                              child: Container(
                                padding: EdgeInsets.all(4),
                                child: Text(
                                  '+',
                                  style: TextStyle(
                                    color: CustomColors().darkBlueColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //Cart icon
                      Container(
                        // padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            FontAwesomeIcons.cartPlus,
                            color: CustomColors().primaryGreenColor,
                            size: 20,
                          ),
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void deleteItemFromFav(ProductsModel product) async {
    showLoaderDialog(context);
    //----------start api ----------------

    Map<String, dynamic> headerMap = await getHeaderMap();

    ProductRepository productRepository = ProductRepository(headerMap);
    ApiResponse apiResponse;

    apiResponse =
        await productRepository.deleteProductFromFav(product.productId!);

    if (apiResponse.apiStatus.code == ApiResponseType.OK.code) {
      MessageResponseModel model =
          MessageResponseModel.fromJson(apiResponse.result);
      Navigator.pop(context);
      isTrashBtnEnabled = true;

      setState(() {
        list.remove(product);
      });
      showSuccessMessage(context, model.message!);
    } else {
      Navigator.pop(context);
      isTrashBtnEnabled = true;
      throw ExceptionHelper(apiResponse.message);
    }
  }
}
