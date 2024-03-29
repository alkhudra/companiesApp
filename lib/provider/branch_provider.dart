import 'dart:collection';

import 'package:collection/src/iterable_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:khudrah_companies/network/models/branches/branch_list_response_model.dart';
import 'package:khudrah_companies/network/models/branches/branch_model.dart';

import '../Constant/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
class BranchProvider with ChangeNotifier {
  List<BranchModel>? branchList = [ ];
  List<Cities>? citiesList = [];

  BuildContext context;

  BranchProvider(this.context);

  clearProvider() {
    branchList = [];
    citiesList = [];
  }

  setCities(List<Cities>? list) {
    citiesList!.addAll(list!
        .where((a) => citiesList!.every((b) => a.arCityName != b.arCityName)));
  }

  setBranchList(List<BranchModel>? list) {
    branchList!
        .addAll(list!.where((a) => branchList!.every((b) => a.id != b.id)));
    print('branch list is ::: ' + branchList!.toString());
    //notifyListeners();
  }


  addBranchToList(BranchModel model) {
    branchList!.insert(1, model);
    notifyListeners();
  }

  removeBranchFromList(BranchModel model) {
    final branchId = model.id;
    BranchModel? branchModel = branchList!.firstWhereOrNull((element) {
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
}
