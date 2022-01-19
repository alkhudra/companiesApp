import '../branches/branch_model.dart';


class SuccessLoginResponseModel {
  SuccessLoginResponseModel({
      User? user, 
     required String token,}){
    _user = user;
    _token = token;
}

  SuccessLoginResponseModel.fromJson(dynamic json) {
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _token = json['token'];
  }
  User? _user;
  String _token = '';

  User? get user => _user;
  String get token => _token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    map['token'] = _token;
    return map;
  }

}


class User {
  User({
     required String id,
      String? email, 
      String? phoneNumber, 
      String? ownerName, 
      String? companyName, 
      String? commercialRegistrationNo,
    String? vatNo,
    int? branchNumber,
      List<BranchModel>? branches,}){
    _id = id;
    _email = email;
    _phoneNumber = phoneNumber;
    _ownerName = ownerName;
    _companyName = companyName;
    _commercialRegistrationNo = commercialRegistrationNo;
    _vatNo = vatNo;
    _branchNumber = branchNumber;
    _branches = branches;
}

  User.fromJson(dynamic json) {
    _id = json['id'];
    _email = json['email'];
    _phoneNumber = json['phoneNumber'];
    _ownerName = json['ownerName'];
    _companyName = json['companyName'];
    _commercialRegistrationNo = json['commercialRegistrationNo'];
    _vatNo = json['vatNo'];
    _branchNumber = json['branchNumber'];
    if (json['branches'] != null) {
      _branches = [];
      json['branches'].forEach((v) {
        _branches?.add(BranchModel.fromJson(v));
      });
    }
  }
  String _id='';
  String? _email;
  String? _phoneNumber;
  String? _ownerName;
  String? _companyName;
  String? _commercialRegistrationNo;
  String? _vatNo;
  int? _branchNumber;
  List<BranchModel>? _branches;

  String? get id => _id;
  String? get email => _email;
  String? get phoneNumber => _phoneNumber;
  String? get ownerName => _ownerName;
  String? get companyName => _companyName;
  String? get commercialRegistrationNo => _commercialRegistrationNo;
  int? get branchNumber => _branchNumber;
  List<BranchModel>? get branches => _branches;

  String? get vatNo => _vatNo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['email'] = _email;
    map['phoneNumber'] = _phoneNumber;
    map['ownerName'] = _ownerName;
    map['companyName'] = _companyName;
    map['commercialRegistrationNo'] = _commercialRegistrationNo;
    map['vatNo'] = _vatNo;
    map['branchNumber'] = _branchNumber;
    if (_branches != null) {
      map['branches'] = _branches?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  @override
  String toString() {
    return 'User{_id: $_id, _email: $_email, _phoneNumber: $_phoneNumber, _ownerName: $_ownerName, _companyName: $_companyName, _commercialRegistrationNo: $_commercialRegistrationNo, _vatNo: $_vatNo, _branchNumber: $_branchNumber, _branches: $_branches}';
  }
}