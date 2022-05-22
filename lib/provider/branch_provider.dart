import 'dart:collection';

import 'package:collection/src/iterable_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:khudrah_companies/network/models/branches/branch_list_response_model.dart';
import 'package:khudrah_companies/network/models/branches/branch_model.dart';

class BranchProvider with ChangeNotifier {
  List<BranchModel>? branchList = [];
  List<Cities>? citiesList = [];

  BuildContext context;

  BranchProvider(this.context);


  setBranchList(List<BranchModel>? list){
    branchList = list;
    notifyListeners();
  }
  setCitiesList( List<Cities>?  list){
    citiesList = list;
    notifyListeners();
  }
  addBranchToList(BranchModel model) {
    branchList!.insert(0,model);
    notifyListeners();
  }

  removeBranchFromList(BranchModel model) {
    final branchId = model.id;
    BranchModel? branchModel =
    branchList!.firstWhereOrNull((element) {
      return element.id == branchId;
    });
    if (branchModel != null) {
      branchList!.remove(branchModel);
      notifyListeners();
    }

  }

  int get listCount {
    return branchList!.length;
  }

  UnmodifiableListView<BranchModel> get getBranchList {
  //  if(branchList!.length !=0)
    return UnmodifiableListView(branchList!);
   // else return loadData();

  }
  UnmodifiableListView<Cities> get getCitiesList {
    return UnmodifiableListView(citiesList!);

  }
}
