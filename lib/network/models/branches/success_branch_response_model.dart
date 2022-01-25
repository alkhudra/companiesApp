import 'package:khudrah_companies/network/models/branches/branch_model.dart';

/// message : "The branch has been added successfully"
/// branchObject : {"id":"9bc4c27f-c12b-40c7-9b4a-3f431b48575b","branchName":"string","phoneNumber":"0541227860","address":"string","districtName":"string","streetName":"string","nationalAddressNo":"1234","city":"string","country":"KSA","longitude":0,"latitude":0,"companyId":"d2fa0b28-905e-4477-bcaa-159eacbdb71b"}

class SuccessBranchResponseModel {
  SuccessBranchResponseModel({
      String? message,
      BranchModel? branchObject,}){
    _message = message;
    _branchObject = branchObject;
}

  SuccessBranchResponseModel.fromJson(dynamic json) {
    _message = json['message'];
    _branchObject = json['branchObject'] != null ? BranchModel.fromJson(json['branchObject']) : null;
  }
  String? _message;
  BranchModel? _branchObject;

  String? get message => _message;
  BranchModel? get branchObject => _branchObject;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    if (_branchObject != null) {
      map['branchObject'] = _branchObject?.toJson();
    }
    return map;
  }

}
