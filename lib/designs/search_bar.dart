import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/designs/text_field_design.dart';
import 'package:khudrah_companies/pages/search_page_list.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:khudrah_companies/provider/product_provider.dart';
import 'package:provider/provider.dart';

class SearchHelper {
  Widget searchBar(context, seController, fromSearchPage, {onclickAction}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            margin: EdgeInsets.only(left: 5, right: 5),
            width: MediaQuery.of(context).size.width / 1.3,
            child: TextFieldDesign.searchFieldStyle(
                context: context,
                verMarg: 2,
                horMarg: 0,
                controller: seController,
                fromSearchPage: fromSearchPage,
                initValue: LocaleKeys.search_term.tr(),
                onActionClicked: onclickAction),
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
            onTap: fromSearchPage == true
                ? onclickAction
                : () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SearchListPage()),
                    );
                    FocusScope.of(context).unfocus();
                  },
          ),
        ],
      ),
    );
  }
}
