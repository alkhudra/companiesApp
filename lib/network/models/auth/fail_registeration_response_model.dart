/// type : "https://tools.ietf.org/html/rfc7231#section-6.5.1"
/// title : "One or more validation errors occurred."
/// status : 400
/// traceId : "00-4c08ea56879b5e47863448247ea9cbf0-2c042174e312d444-00"
/// errors : {"Password":["The Password must be at least 6 and at max 50 characters long. It must have at least one non alphanumeric character, at least one digit ('0'-'9'), at least one lowercase('a' - 'z') and at least one uppercase('A' - 'Z')."],"ConfirmPassword":["The password and confirmation password do not match."]}

class FailRegisterResponseModel {
  FailRegisterResponseModel({
/*      String? type,
      String? title, 
      int? status, 
      String? traceId,*/
  String? message,
      Errors? errors,}){
/*    _type = type;
    _title = title;
    _status = status;
    _traceId = traceId;*/
    _message = message;
    _errors = errors;
}

  FailRegisterResponseModel.fromJson(dynamic json) {
 /*   _type = json['type'];
    _title = json['title'];
    _status = json['status'];
    _traceId = json['traceId'];*/
    _message = json['message'];
    _errors = json['errors'] != null ? Errors.fromJson(json['errors']) : null;
  }
/*  String? _type;
  String? _title;
  int? _status;
  String? _traceId;*/
  Errors? _errors;
  String? _message;

  String? get message => _message;

/*  String? get type => _type;
  String? get title => _title;
  int? get status => _status;
  String? get traceId => _traceId;*/
  Errors? get errors => _errors;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
/*    map['type'] = _type;
    map['title'] = _title;
    map['status'] = _status;
    map['traceId'] = _traceId;*/
    map['message'] = _message ;
    if (_errors != null) {
      map['errors'] = _errors;//?.toJson();
    }
    return map;
  }

}

/// Password : ["The Password must be at least 6 and at max 50 characters long. It must have at least one non alphanumeric character, at least one digit ('0'-'9'), at least one lowercase('a' - 'z') and at least one uppercase('A' - 'Z')."]
/// ConfirmPassword : ["The password and confirmation password do not match."]

class Errors {
  Errors({
      List<String>? password, 
      List<String>? confirmPassword,}){
    _password = password;
    _confirmPassword = confirmPassword;
}

  Errors.fromJson(dynamic json) {
    _password = json['Password'] != null ? json['Password'].cast<String>() : [];
    _confirmPassword = json['ConfirmPassword'] != null ? json['ConfirmPassword'].cast<String>() : [];
  }
  List<String>? _password;
  List<String>? _confirmPassword;

  List<String>? get password => _password;
  List<String>? get confirmPassword => _confirmPassword;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Password'] = _password;
    map['ConfirmPassword'] = _confirmPassword;
    return map;
  }

}