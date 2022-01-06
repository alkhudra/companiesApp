/// code : "OTYzMTMx"
/// message : "if you have an account with us, an email has been sent with the instructions to reset your password"

class ForgetPasswordResponseModel {
  ForgetPasswordResponseModel({
      String? code, 
      String? message,}){
    _code = code;
    _message = message;
}

  ForgetPasswordResponseModel.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
  }
  String? _code;
  String? _message;

  String? get code => _code;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['message'] = _message;
    return map;
  }

}