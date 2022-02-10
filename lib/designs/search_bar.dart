import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/designs/text_field_design.dart';
import 'package:khudrah_companies/pages/search_page_list.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class SearchHelper{
  Widget searchBar(context, seController,fromSearchPage) {

    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // SizedBox(width: 10,),
          // Container(
          //   child: IconButton(
          //     icon: Icon(Icons.menu_rounded,),
          //     color: CustomColors().brownColor,
          //     iconSize: 28,
          //     onPressed: () {},
          //   ),
          // ),
          // SizedBox(width: 5,),
          Container(
            margin: EdgeInsets.only(left: 5, right: 5),
            width: MediaQuery.of(context).size.width/1.3,
            child: TextFieldDesign.searchFieldStyle(
              context: context,
              verMarg: 2,
              horMarg: 0,
              controller: seController,

              initValue: LocaleKeys.search_term.tr(),

            ),
          ),
          GestureDetector(
            child: Container(
              padding: EdgeInsets.all(8.0),
              width: MediaQuery.of(context).size.width*0.08,
              height: MediaQuery.of(context).size.height*0.04,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/logo.png'),
                ),
              ),
            ),
            onTap: () {
              if(fromSearchPage)
                directToSearchPageFromSearchPage(context, seController);
                else
              directToSearchPage(context, seController);
            },
          ),
        ],
      ),
    );
  }


  static void directToSearchPageFromSearchPage(BuildContext context, TextEditingController? controller){
    String txt = controller!.text;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => SearchListPage(
            keyWords: txt,
          )),
    );
    FocusScope.of(context).unfocus();
    controller.clear();
  }

  static void directToSearchPage(BuildContext context, TextEditingController? controller){
    String txt = controller!.text;
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SearchListPage(
            keyWords: txt,
          )),
    );
    FocusScope.of(context).unfocus();
    controller.clear();
  }
}
