/// Message : "Server Error, please try again later"

class ErrorMessageResponse {
  ErrorMessageResponse({
      String? message,}){
    _message = message;
}

  ErrorMessageResponse.fromJson(dynamic json) {
    _message = json['Message'];
  }
  String? _message;

  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Message'] = _message;
    return map;
  }

}