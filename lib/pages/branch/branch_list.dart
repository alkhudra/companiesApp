import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/designs/appbar_design.dart';
import 'package:khudrah_companies/designs/drawar_design.dart';
import 'package:khudrah_companies/dialogs/message_dialog.dart';
import 'package:khudrah_companies/dialogs/progress_dialog.dart';
import 'package:khudrah_companies/helpers/custom_btn.dart';
import 'package:khudrah_companies/helpers/pref/shared_pref_helper.dart';
import 'package:khudrah_companies/network/API/api_response_type.dart';
import 'package:khudrah_companies/network/models/user_model.dart';import 'package:khudrah_companies/network/models/branches/branch_list_response_model.dart';
import 'package:khudrah_companies/network/models/branches/branch_model.dart';
import 'package:khudrah_companies/network/helper/network_helper.dart';
import 'package:khudrah_companies/network/repository/branches_repository.dart';
import 'package:khudrah_companies/pages/branch/edit_branch_page.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'package:easy_localization/easy_localization.dart';

import 'add_brunches_page.dart';
import 'branch_item.dart';

class BranchList extends StatefulWidget {
  final List<BranchModel> list;

  const BranchList({Key? key, required this.list}) : super(key: key);

  @override
  _BranchListState createState() => _BranchListState();

}

class _BranchListState extends State<BranchList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarDesign(context, LocaleKeys.branch_list.tr()),
        endDrawer: drawerDesign(context),
        backgroundColor: Colors.grey[100],
        body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    return _buildList(
        context,
        widget
            .list); /*FutureBuilder<List<BranchModel>>(
      future:branchList,
      //getBranchList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            //  showErrorMessageDialog(context, 'error');
           final List<BranchModel> list = snapshot.requireData;
            return _buildList(context, list);
          } else {
            return CircularProgressIndicator();
          }
        });*/
  }

  Widget _buildList(BuildContext context, List<BranchModel> snapshot) {
    Size size = MediaQuery.of(context).size;
    double scWidth = size.width;
    double scHeight = size.height;

    return Column(children: [
      Expanded(
        child: ListView.builder(
          itemBuilder: (context, index) {
            //  print(snapshot?[index].toString());
            return BranchItem(
              list: snapshot,
                index: index,
            );
          },
          itemCount: snapshot.length,
        ),
      ),
      SizedBox(
        height: 20,
      ),
      greenBtn(LocaleKeys.add_new_branch.tr(), EdgeInsets.all(20), () {
        directToAddBranch();
      })
    ]);
  }

  void directToAddBranch() async {
    final model =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddBranchesPage(
          );
    }));

    if (model != null) {
      setState(() {
        widget.list.add(model);
      });
    }
  }
}
