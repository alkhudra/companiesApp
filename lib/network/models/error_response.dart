import 'package:json_annotation/json_annotation.dart';

/// type : "https://tools.ietf.org/html/rfc7231#section-6.5.1"
/// title : "One or more validation errors occurred."
/// status : 400
/// traceId : "00-ba539fd17fb065448c399169e75a9f18-d0c2e28dc2d4dd48-00"
/// errors : {"CommercialRegistrationNo":["Please Enter a Valid Commercial Registration Number"]}
@JsonSerializable()

class ErrorResponse {
  ErrorResponse({
      String? type, 
      String? title, 
      int? status, 
      String? traceId, 
      Errors? errors,}){
    _type = type;
    _title = title;
    _status = status;
    _traceId = traceId;
    _errors = errors;
}

  ErrorResponse.fromJson(dynamic json) {
    _type = json['type'];
    _title = json['title'];
    _status = json['status'];
    _traceId = json['traceId'];
    _errors = json['errors'] != null ? Errors.fromJson(json['errors']) : null;
  }
  String? _type;
  String? _title;
  int? _status;
  String? _traceId;
  Errors? _errors;

  String? get type => _type;
  String? get title => _title;
  int? get status => _status;
  String? get traceId => _traceId;
  Errors? get errors => _errors;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = _type;
    map['title'] = _title;
    map['status'] = _status;
    map['traceId'] = _traceId;
    if (_errors != null) {
      map['errors'] = _errors?.toJson();
    }
    return map;
  }

}


class Errors {
  Errors({
      List<String>? commercialRegistrationNo,}){
    _commercialRegistrationNo = commercialRegistrationNo;
}

  Errors.fromJson(dynamic json) {
    _commercialRegistrationNo = json['CommercialRegistrationNo'] != null ? json['CommercialRegistrationNo'].cast<String>() : [];
  }
  List<String>? _commercialRegistrationNo;

  List<String>? get commercialRegistrationNo => _commercialRegistrationNo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['CommercialRegistrationNo'] = _commercialRegistrationNo;
    return map;
  }

}