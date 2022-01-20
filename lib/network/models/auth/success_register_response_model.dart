import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class SuccessRegisterResponseModel {
  SuccessRegisterResponseModel({
    String? message,
    required String userId,
  }) {
    _message = message;
    _userId = userId;
  }

  SuccessRegisterResponseModel.fromJson(dynamic json) {
    _message = json['message'];
    _userId = json['userId'];
    //_error!.status = json['']
  }
  String? _message;
  String _userId = '';

  String? get message => _message;
  String get userId => _userId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['userId'] = _userId;
    return map;
  }
}
