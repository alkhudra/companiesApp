import 'package:json_annotation/json_annotation.dart';
import 'package:khudrah_companies/network/models/error_response.dart';


@JsonSerializable()

class RegisterResponseModel {
  RegisterResponseModel({
      String? message, 
      required String userId,
    ErrorResponse? error}){
    _message = message;
    _userId = userId;
    _error = error;


}

  RegisterResponseModel.fromJson(dynamic json) {
    _message = json['message'];
    _userId = json['userId'];
    //_error!.status = json['']
  }
  String? _message;
  String _userId='';
 ErrorResponse? _error ;

  String? get message => _message;
  String get userId => _userId;

  ErrorResponse? get error => _error;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['userId'] = _userId;
    return map;
  }

}