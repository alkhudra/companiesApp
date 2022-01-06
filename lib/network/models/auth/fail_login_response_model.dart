/// companyStatus : "registered"
/// message : "Invalid login attempt."

class FailLoginResponseModel {
  FailLoginResponseModel({
      required String companyStatus,
      String? message,}){
    _companyStatus = companyStatus;
    _message = message;
}

  FailLoginResponseModel.fromJson(dynamic json) {
    _companyStatus = json['companyStatus'];
    _message = json['message'];
  }
  String _companyStatus ='null';
  String? _message;

  String get companyStatus => _companyStatus;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['companyStatus'] = _companyStatus;
    map['message'] = _message;
    return map;
  }

}