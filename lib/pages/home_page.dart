
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:khudrah_companies/Constant/api_const.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/designs/appbar_design.dart';
import 'package:khudrah_companies/designs/drawar_design.dart';
import 'package:khudrah_companies/designs/product_card.dart';
import 'package:khudrah_companies/designs/text_field_design.dart';
import 'package:khudrah_companies/dialogs/message_dialog.dart';
import 'package:khudrah_companies/dialogs/two_btns_dialog.dart';
import 'package:khudrah_companies/helpers/pref/shared_pref_helper.dart';
import 'package:khudrah_companies/network/API/api_response.dart';
import 'package:khudrah_companies/network/API/api_response_type.dart';
import 'package:khudrah_companies/network/models/home/home_success_response_model.dart';
import 'package:khudrah_companies/network/models/user_model.dart';
import 'package:khudrah_companies/network/helper/network_helper.dart';
import 'package:khudrah_companies/network/repository/home_repository.dart';
import 'package:khudrah_companies/pages/categories/all_category.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'package:khudrah_companies/router/route_constants.dart';
import 'branch/add_brunches_page.dart';
import 'package:easy_localization/easy_localization.dart';

import 'categories/category_page.dart';


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
  static String language ='ar';

  //---------------------

  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {

     return AnnotatedRegion<SystemUiOverlayStyle>(
       value: SystemUiOverlayStyle(
         statusBarColor: Colors.transparent,
       ),
       child: Scaffold(
         endDrawer: drawerDesignWithName(context, name, email),
         appBar: homeAppBarDesign(context, LocaleKeys.home.tr()),
         // key: _scaffoldState,
         body:  FutureBuilder<HomeSuccessResponseModel?>(
         future: getHomePage(),
         builder: (context, snapshot) {
           print(snapshot.toString());
           if (snapshot.hasData) {
             print(snapshot.hasData);
             print(snapshot.data);
             return homePageDesign(snapshot.data);
           } else return errorCase(snapshot);
         },
       ),
       ),
     );

  }

  Widget errorCase(AsyncSnapshot<HomeSuccessResponseModel?> snapshot) {
    if (snapshot.hasError) {
      return Text('${snapshot.error}');
    }else

    // By default, show a loading spinner.
    return  Center(child: CircularProgressIndicator());
  }
  //---------------------

  Widget searchBar(seController) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 5,
          ),
          Container(
            margin: EdgeInsets.only(left: 5, right: 5),
            width: MediaQuery.of(context).size.width / 1.3,
            child: TextFieldDesign.textFieldStyle(
              context: context,
              verMarg: 2,
              horMarg: 0,
              controller: seController,
              kbType: TextInputType.text,
              lbTxt: LocaleKeys.search_term.tr(),
              obscTxt: false,
            ),
          ),
          SizedBox(
            width: 5,
          ),
          GestureDetector(
            child: Container(
              padding: EdgeInsets.all(8.0),
              width: MediaQuery.of(context).size.width * 0.08,
              height: MediaQuery.of(context).size.height * 0.04,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/logo.png'),
                ),
              ),
            ),
            onTap: () {},
          ),
          SizedBox(
            width: 5,
          ),
        ],
      ),
    );
  }
  //---------------------
  Widget homePageDesign(HomeSuccessResponseModel? home) {


    Size size = MediaQuery.of(context).size;
    double scWidth = size.width;
    double scHeight = size.height;

    List<CategoryItem>? categoryList = home!.categoriesList;
    name = home.user!.companyName!;
    email = home.user!.email!;
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
            child: searchBar(searchController),
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
          SizedBox(
            height: 10,
          ),
          //Categories items
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //all category iconbutton
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40)
                      ),
                      child: Container(
                        width: scWidth * 0.27,
                        height: scHeight * 0.11,
                        child: IconButton(
                          icon: Image(image: AssetImage('images/fruitsnveg.png')),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AllCategory()),
                            );
                          },
                        ),
                      ),
                    ),
                    // Container(
                    //   width: scWidth * 0.27,
                    //   height: scHeight * 0.11,
                    //   //TODO: Circle Avatar size
                    //   child: GestureDetector(
                    //     onTap: (){
                    //         Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //             builder: (context) => AllCategory()),
                    //         );
                    //     } ,
                    //     // child: ClipOval(
                    //     //   child: SizedBox.fromSize(
                    //     //     size: Size.fromRadius(48),
                    //     //     child: Image.asset('images/fruitsnveg.png', fit: BoxFit.contain,),
                    //     //   ),
                    //     // ),
                    //   )
                    // ),
                    SizedBox(height: 5,),
                    Text('الكل'
                      ,style: TextStyle(
                          color: CustomColors().brownColor,fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
                Container(
                  width: scWidth * 0.8,
                  height: scHeight * 0.16,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            width: scWidth * 0.27,
                            height: scHeight * 0.11,
                            child: IconButton(
                              icon: Image(image: NetworkImage(ApiConst.images_url + categoryList![index].image!)),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CategoryPage(categoriesItem:categoryList[index] ,)),
                                );
                              },
                            ),
                           // child: Image.network(ApiConst.images_url + categoryList![index].image!)
                           /*   icon: Image(
                                  image: AssetImage(

                                  )),
                              onPressed: () {

                              },
                              iconSize: 90,
                            ),
                          ),*/),
                      Text(setCategoryName(categoryList[index])!
                        ,style: TextStyle(
                        color: CustomColors().brownColor,fontWeight: FontWeight.bold
                      ),)
                      ,
                        ],
                      );
                    },
                    itemCount: categoryList?.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          //Newest deals title and button
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
              keyboardDismissBehavior:
              ScrollViewKeyboardDismissBehavior.onDrag,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ProductCard.productCardDesign(
                  context,
                  language,
                  home.productsList![index],
                );
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

    ApiResponse apiResponse = await  homeRepository.getHomeInfo();
    if(apiResponse.apiStatus.code ==  ApiResponseType.OK.code)
    return HomeSuccessResponseModel.fromJson(apiResponse.result);
    else   throw Exception(apiResponse.message);


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
      return AddBranchesPage(/*addToList: (){},*/);
    }));
  }
  ////---------------------------

  @override
  void initState() {
    super.initState();
    ProductCard.counter = ProductCard.counter;

    setValues();
    //todo: show after calling api
    /*    if (widget.isHasBranch == false) {
      showAddBranchDialog();
    }*/
  }

  String? setCategoryName(CategoryItem categoryList) {
 return language == 'ar' ?  categoryList.arName :  categoryList.name;
  }
  


}


