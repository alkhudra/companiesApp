/// message : "One or more validation errors occurred."
/// errors : {"Password":["The Password must be at least 6 and at max 50 characters long. It must have at least one non alphanumeric character, at least one digit ('0'-'9'), at least one lowercase('a' - 'z') and at least one uppercase('A' - 'Z')."],"ConfirmPassword":["The password and confirmation password do not match."]}

class FailClass {
  FailClass({
      String? message, 
      Errors? errors,}){
    _message = message;
    _errors = errors;
}

  FailClass.fromJson(dynamic json) {
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