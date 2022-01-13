import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/designs/appbar_design.dart';
import 'package:khudrah_companies/designs/drawar_design.dart';
import 'package:khudrah_companies/dialogs/message_dialog.dart';
import 'package:khudrah_companies/helpers/custom_btn.dart';
import 'package:khudrah_companies/helpers/pref/shared_pref_helper.dart';
import 'package:khudrah_companies/network/API/api_response_type.dart';
import 'package:khudrah_companies/network/models/auth/success_login_response_model.dart';
import 'package:khudrah_companies/network/models/branches/branch_list_response_model.dart';
import 'package:khudrah_companies/network/models/branches/branch_model.dart';
import 'package:khudrah_companies/network/network_helper.dart';
import 'package:khudrah_companies/network/repository/branches_repository.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'package:easy_localization/easy_localization.dart';

import 'add_brunches_page.dart';
import 'branch_item.dart';

class BranchList extends StatefulWidget {
  final List<BranchModel> items;

  const BranchList({Key? key, required this.items}) : super(key: key);

  @override
  _BranchListState createState() => _BranchListState();
}

class _BranchListState extends State<BranchList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarDesign(context, LocaleKeys.branch_list.tr()),
        endDrawer: drawerDesign(context),
        backgroundColor: CustomColors().backgroundColor,
        body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    return FutureBuilder<List<BranchModel>?>(
        future: getBranchList(),
        builder: (context, snapshot) {
          if (snapshot.hasError) showErrorMessageDialog(context, 'error');
          List<BranchModel>? list = snapshot.data;
          return _buildList(context, list);
        });
  }

  Widget _buildList(BuildContext context, List<BranchModel>? snapshot) {
    return Column(children: [
      Expanded(
        child: ListView.builder(itemBuilder: (context, index) {
          print( snapshot![index].toString());
          return BranchItem(item: snapshot[index]);
        }
        ,itemCount: snapshot!.length,),
      ),

      SizedBox(
        height: 20,
      ),
      greenBtn(LocaleKeys.add_new_branch.tr(), EdgeInsets.all(20), () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return AddBranchesPage();
        }));
      })
    ]);
  }

  Future<List<BranchModel>?> getBranchList() async {
    Map<String, dynamic> headerMap = await getHeaderMap();

    User user = await PreferencesHelper.getUser;
    print(user.toString());


    return user.branches;

 /*   String companyID = await PreferencesHelper.getUserID;
    BranchRepository branchRepository = BranchRepository(headerMap);
    List<BranchModel> list = [];
    BranchListResponseModel branchListResponseModel =
        BranchListResponseModel([], LocaleKeys.wrong_error.tr());
    branchRepository.getAllBranch(companyID).then((result) async {
      //-------- fail response ---------
      print(result.result);
      final de = jsonDecode(result.result.toString());
      branchListResponseModel = BranchListResponseModel.fromJson(de);

      print(branchListResponseModel.toString());
    });
    return branchListResponseModel;

    */

  }
}
