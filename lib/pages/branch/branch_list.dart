import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/designs/appbar_design.dart';
import 'package:khudrah_companies/designs/drawar_design.dart';
import 'package:khudrah_companies/designs/no_item_design.dart';
import 'package:khudrah_companies/dialogs/message_dialog.dart';
import 'package:khudrah_companies/dialogs/progress_dialog.dart';
import 'package:khudrah_companies/helpers/custom_btn.dart';
import 'package:khudrah_companies/helpers/pref/shared_pref_helper.dart';
import 'package:khudrah_companies/network/API/api_response.dart';
import 'package:khudrah_companies/network/API/api_response_type.dart';
import 'package:khudrah_companies/network/models/user_model.dart';
import 'package:khudrah_companies/network/models/branches/branch_list_response_model.dart';
import 'package:khudrah_companies/network/models/branches/branch_model.dart';
import 'package:khudrah_companies/network/helper/network_helper.dart';
import 'package:khudrah_companies/network/repository/branches_repository.dart';
import 'package:khudrah_companies/pages/branch/edit_branch_page.dart';
import 'package:khudrah_companies/provider/branch_provider.dart';
import 'package:khudrah_companies/provider/genral_provider.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

import 'add_brunches_page.dart';
import 'branch_item.dart';
import 'package:khudrah_companies/network/helper/exception_helper.dart';


class BranchList extends StatefulWidget {
//  final List<BranchModel> list;

  const BranchList({Key? key}) : super(key: key);

  @override
  _BranchListState createState() => _BranchListState();
}

class _BranchListState extends State<BranchList> {
 static late List<Cities> cities ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDesign(context, LocaleKeys.branch_list.tr()),
      backgroundColor: Colors.grey[100],
      body: Consumer<BranchProvider>(builder: (context, value, child) {
        return FutureBuilder/*<BranchListResponseModel>*/(
          future: getListData(value),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return _buildBody(context, snapshot.data);
            } else
              return errorCase(snapshot);
          },
        );
      }),
    );
  }

  //-----------------------

  Future getListData(BranchProvider value) async {
    if (value.branchList!.isEmpty ) {
      Map<String, dynamic> headerMap = await getHeaderMap();
      String companyId = await PreferencesHelper.getUserID;

      BranchRepository branchRepository = BranchRepository(headerMap);

      ApiResponse apiResponse = await branchRepository.getAllBranch(companyId);

      if (apiResponse.apiStatus.code == ApiResponseType.OK.code) {
        BranchListResponseModel? responseModel =
            BranchListResponseModel.fromJson(apiResponse.result);

        cities = responseModel.cities!;
        print(responseModel.branches.toString());


        PreferencesHelper.saveBranchesList(responseModel.branches!);
        PreferencesHelper.saveCitiesList(responseModel.cities!);
        value.setBranchList(responseModel.branches);

        return responseModel.branches;
      } else {
        throw ExceptionHelper(apiResponse.message);
      }
    } else {
      return value.branchList;
    }
  }

  //-----------------------
  Widget _buildBody(
      BuildContext context, /*BranchListResponseModel? */ list) {
    Size size = MediaQuery.of(context).size;
    double scWidth = size.width;
    double scHeight = size.height;

    //  cities = snapshot!.cities!;
    return Column(children: [
      Expanded(
        child: list. /*branches!.*/ length > 0
            ? ListView.builder(
                itemBuilder: (context, index) {
                  //  print(snapshot?[index].toString());
                  return BranchItem(
                    list: list /*.branches!*/,
                    index: index,
                    cities: cities,
                  );
                },
                itemCount: list. /*branches!.*/ length,
              )
            : noItemDesign(LocaleKeys.no_branches.tr(), 'images/not_found.png'),
      ),
      greenBtn(LocaleKeys.add_new_branch.tr(), EdgeInsets.all(20), () {
        directToAddBranch(list /*.branches!*/);
      }),
      SizedBox(
        height: 30,
      ),
    ]);
  }

  void directToAddBranch(List<BranchModel> list) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddBranchesPage(
        cities: cities,
      );
    }));
  }
}
