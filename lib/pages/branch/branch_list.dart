import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/designs/ButtonsDesign.dart';
import 'package:khudrah_companies/designs/app_bar_txt.dart';
import 'package:khudrah_companies/helpers/custom_btn.dart';
import 'package:khudrah_companies/network/models/branches/branch_model.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'package:easy_localization/easy_localization.dart';

import 'add_brunches_page.dart';
import 'branch_item.dart';

class BranchList extends StatefulWidget {
  final List<BranchModel> items;

  const BranchList({Key? key,required this.items}) : super(key: key);

  @override
  _BranchListState createState() => _BranchListState();
}

class _BranchListState extends State<BranchList> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarText(LocaleKeys.add_branch.tr(), true),
        backgroundColor: CustomColors().backgroundColor,
        body: SingleChildScrollView(
          child:Container(
            child: Column(
              children: [
                ListView.builder(itemBuilder: (context,index){
                  return  BranchItem(item: widget.items[index]);
                }),

                greenBtn(LocaleKeys.add_new_branch.tr(), EdgeInsets.all(20),() {

                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AddBranchesPage();
                  }));
                })
              ],
            ),
          ),
        ));
  }
}
