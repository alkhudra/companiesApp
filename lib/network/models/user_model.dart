import 'branches/branches_model.dart';

/// user : {"id":"e7e60d82-f7f0-444c-ae24-5c5c0454203b","email":"safa3.1998@hotmail.com","phoneNumber":"0553561821","ownerName":"Test","companyName":"Test","commercialRegistrationNo":"0987654321","branchNumber":5,"branches":[]}
/// token : "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJuYW1laWQiOiJlN2U2MGQ4Mi1mN2YwLTQ0NGMtYWUyNC01YzVjMDQ1NDIwM2IiLCJ1bmlxdWVfbmFtZSI6InNhZmEzLjE5OThAaG90bWFpbC5jb20iLCJyb2xlIjoiQ29tcGFueSIsIm5iZiI6MTY0MDM2NzU1MCwiZXhwIjoxNjQwNDEwNzUwLCJpYXQiOjE2NDAzNjc1NTB9.OdPsAYPHz1Qwlut-AwSDzOUD9G132XZxxLrJc7gkHKSw1pVYwpr9nWkh8EYAc-BgIudBFUI5L4VWZFQzvQfM_g"

class UserModel {
  UserModel({
      User? user, 
      String? token,}){
    _user = user;
    _token = token;
}

  UserModel.fromJson(dynamic json) {
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _token = json['token'];
  }
  User? _user;
  String? _token;

  User? get user => _user;
  String? get token => _token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    map['token'] = _token;
    return map;
  }

}

/// id : "e7e60d82-f7f0-444c-ae24-5c5c0454203b"
/// email : "safa3.1998@hotmail.com"
/// phoneNumber : "0553561821"
/// ownerName : "Test"
/// companyName : "Test"
/// commercialRegistrationNo : "0987654321"
/// branchNumber : 5
/// branches : []

class User {
  User({
      String? id, 
      String? email, 
      String? phoneNumber, 
      String? ownerName, 
      String? companyName, 
      String? commercialRegistrationNo, 
      int? branchNumber, 
      List<BranchesModel>? branches,}){
    _id = id;
    _email = email;
    _phoneNumber = phoneNumber;
    _ownerName = ownerName;
    _companyName = companyName;
    _commercialRegistrationNo = commercialRegistrationNo;
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
    _branchNumber = json['branchNumber'];
    if (json['branches'] != null) {
      _branches = [];
      json['branches'].forEach((v) {
        _branches?.add(BranchesModel.fromJson(v));
      });
    }
  }
  String? _id;
  String? _email;
  String? _phoneNumber;
  String? _ownerName;
  String? _companyName;
  String? _commercialRegistrationNo;
  int? _branchNumber;
  List<BranchesModel>? _branches;

  String? get id => _id;
  String? get email => _email;
  String? get phoneNumber => _phoneNumber;
  String? get ownerName => _ownerName;
  String? get companyName => _companyName;
  String? get commercialRegistrationNo => _commercialRegistrationNo;
  int? get branchNumber => _branchNumber;
  List<BranchesModel>? get branches => _branches;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['email'] = _email;
    map['phoneNumber'] = _phoneNumber;
    map['ownerName'] = _ownerName;
    map['companyName'] = _companyName;
    map['commercialRegistrationNo'] = _commercialRegistrationNo;
    map['branchNumber'] = _branchNumber;
    if (_branches != null) {
      map['branches'] = _branches?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}