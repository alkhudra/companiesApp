import 'package:json_annotation/json_annotation.dart';

/// email : "user@example.com"
/// password : "string"
/// confirmPassword : "string"
/// phoneNumber : "string"
/// ownerName : "string"
/// companyName : "string"
/// commercialRegistrationNo : "string"
/// branchNumber : 0
@JsonSerializable()

class RegisterClass {
  RegisterClass({
      String? email, 
      String? password, 
      String? confirmPassword, 
      String? phoneNumber, 
      String? ownerName, 
      String? companyName, 
      String? commercialRegistrationNo, 
      int? branchNumber,}){
    _email = email;
    _password = password;
    _confirmPassword = confirmPassword;
    _phoneNumber = phoneNumber;
    _ownerName = ownerName;
    _companyName = companyName;
    _commercialRegistrationNo = commercialRegistrationNo;
    _branchNumber = branchNumber;
}

  RegisterClass.fromJson(dynamic json) {
    _email = json['email'];
    _password = json['password'];
    _confirmPassword = json['confirmPassword'];
    _phoneNumber = json['phoneNumber'];
    _ownerName = json['ownerName'];
    _companyName = json['companyName'];
    _commercialRegistrationNo = json['commercialRegistrationNo'];
    _branchNumber = json['branchNumber'];
  }
  String? _email;
  String? _password;
  String? _confirmPassword;
  String? _phoneNumber;
  String? _ownerName;
  String? _companyName;
  String? _commercialRegistrationNo;
  int? _branchNumber;

  String? get email => _email;
  String? get password => _password;
  String? get confirmPassword => _confirmPassword;
  String? get phoneNumber => _phoneNumber;
  String? get ownerName => _ownerName;
  String? get companyName => _companyName;
  String? get commercialRegistrationNo => _commercialRegistrationNo;
  int? get branchNumber => _branchNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = _email;
    map['password'] = _password;
    map['confirmPassword'] = _confirmPassword;
    map['phoneNumber'] = _phoneNumber;
    map['ownerName'] = _ownerName;
    map['companyName'] = _companyName;
    map['commercialRegistrationNo'] = _commercialRegistrationNo;
    map['branchNumber'] = _branchNumber;
    return map;
  }

}