/// error : {"message":"Please Enter a Valid Value added number(VAT)"}

class ErrorResponseModel {
  ErrorResponseModel({
      Error? error,}){
    _error = error;
}

  ErrorResponseModel.fromJson(dynamic json) {
    _error = json['error'] != null ? Error.fromJson(json['error']) : null;
  }
  Error? _error;

  Error? get error => _error;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_error != null) {
      map['error'] = _error?.toJson();
    }
    return map;
  }

}

/// message : "Please Enter a Valid Value added number(VAT)"

class Error {
  Error({
      String? message,}){
    _message = message;
}

  Error.fromJson(dynamic json) {
    _message = json['message'];
  }
  String? _message;

  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    return map;
  }

}