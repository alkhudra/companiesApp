import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:khudrah_companies/network/models/branches/branch_list_response_model.dart';
import 'package:khudrah_companies/network/models/branches/branch_model.dart';
import 'package:khudrah_companies/pages/branch/branch_list.dart';
import 'package:khudrah_companies/pages/branch/branch_wrapper.dart';

class BranchProvider with ChangeNotifier {
  List<BranchModel>? branchList = [];
  List<Cities>? citiesList = [];

  BuildContext context;

  BranchProvider(this.context);


 Future loadData()async{
   branchList = await getListData();
   return branchList;
  }
  addBranchToList(BranchModel model){

    branchList!.add(model);
    notifyListeners();
  }

  removeBranchFromList(BranchModel model){

    branchList!.remove(model);
    notifyListeners();
  }


  int get listCount {
    return branchList!.length;
  }

  UnmodifiableListView<BranchModel> get getBranchList {
    return UnmodifiableListView(branchList!);
  }
}