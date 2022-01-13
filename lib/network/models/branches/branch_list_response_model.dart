import 'package:khudrah_companies/network/models/branches/branch_model.dart';


class BranchListResponseModel {


  List<BranchModel>? branchList;
  String? message ;

  BranchListResponseModel(this.branchList, this.message);

  BranchListResponseModel.fromJson(dynamic json) {
  //  message = json['message'];

    if (json != null) {
      branchList = [];
      json.forEach((v) {
        branchList?.add(BranchModel.fromJson(v));
      });
    }
  }

  @override
  String toString() {
    return 'BranchListResponseModel{branchList: $branchList}';
  }
}