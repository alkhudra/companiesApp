import 'package:khudrah_companies/helpers/pref/shared_pref_helper.dart';
import 'package:khudrah_companies/network/models/branches/branch_model.dart';


class BranchListResponseModel {


  List<BranchModel> _branches=[];
  String? message ;

  List<BranchModel> get branches =>
      _branches; //BranchListResponseModel(this._branches, this.message);

  BranchListResponseModel.fromJson(dynamic json) {
    message = json['message'];

    if (json != null && json['message'] == null)  {
      _branches = [];
      json.forEach((v) {
        _branches.add(BranchModel.fromJson(v));
      });
    }
  }

  @override
  String toString() {
    String model = _branches.toString();
    return 'BranchListResponseModel{branchList: $model}';
  }




  BranchListResponseModel();
}