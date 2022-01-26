
import 'package:khudrah_companies/network/models/auth/success_login_response_model.dart';

class LoginResponse {
  LoginResponse({
      User? user, 
      String? token,}){
    _user = user;
    _token = token;
}

  LoginResponse.fromJson(dynamic json) {
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

