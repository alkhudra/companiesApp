
class FailEditProfileResponseModel {
  FailEditProfileResponseModel({
    String? message,
    Errors? errors,}){
    _message = message;
    _errors = errors;
  }

  FailEditProfileResponseModel.fromJson(dynamic json) {
    _message = json['message'];
    _errors = json['errors'] != null ? Errors.fromJson(json['errors']) : null;
  }
  String? _message;
  Errors? _errors;

  String? get message => _message;
  Errors? get errors => _errors;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    if (_errors != null) {
      map['errors'] = _errors?.toJson();
    }
    return map;
  }

}


class Errors {
  Errors({
    List<String>? commercialRegistrationNo,
    List<String>? phoneNumber,}){
    _commercialRegistrationNo = commercialRegistrationNo;
    _phoneNumber = phoneNumber;
  }

  Errors.fromJson(dynamic json) {
    _commercialRegistrationNo = json['CommercialRegistrationNo'] != null ? json['CommercialRegistrationNo'].cast<String>() : [];
    _phoneNumber = json['PhoneNumber'] != null ? json['PhoneNumber'].cast<String>() : [];
  }
  List<String>? _commercialRegistrationNo;
  List<String>? _phoneNumber;

  List<String>? get commercialRegistrationNo => _commercialRegistrationNo;
  List<String>? get phoneNumber => _phoneNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['CommercialRegistrationNo'] = _commercialRegistrationNo;
    map['PhoneNumber'] = _phoneNumber;
    return map;
  }

}