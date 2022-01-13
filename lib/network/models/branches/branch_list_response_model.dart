import 'package:khudrah_companies/network/models/branches/branch_model.dart';


class BranchListResponseModel {


  List<BranchModel>? _branches;
  String? message ;

  BranchListResponseModel(this._branches, this.message);

  BranchListResponseModel.fromJson(dynamic json) {
  //  message = json['message'];

    if (json[''] != null) {
      _branches = [];
      json[''].forEach((v) {
        _branches?.add(BranchModel.fromJson(v));
      });
    }
  }

  @override
  String toString() {
    return 'BranchListResponseModel{branchList: $_branches}';
  }
}