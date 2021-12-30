/// branchName : "string"
/// phoneNumber : "string"
/// adress : "string"
/// zipCode : "string"
/// longitude : 0
/// latitude : 0

class BranchesModel {
  BranchesModel({
      String? branchName, 
      String? phoneNumber, 
      String? adress, 
      String? zipCode, 
      int? longitude, 
      int? latitude,}){
    _branchName = branchName;
    _phoneNumber = phoneNumber;
    _adress = adress;
    _zipCode = zipCode;
    _longitude = longitude;
    _latitude = latitude;
}

  BranchesModel.fromJson(dynamic json) {
    _branchName = json['branchName'];
    _phoneNumber = json['phoneNumber'];
    _adress = json['adress'];
    _zipCode = json['zipCode'];
    _longitude = json['longitude'];
    _latitude = json['latitude'];
  }
  String? _branchName;
  String? _phoneNumber;
  String? _adress;
  String? _zipCode;
  int? _longitude;
  int? _latitude;

  String? get branchName => _branchName;
  String? get phoneNumber => _phoneNumber;
  String? get adress => _adress;
  String? get zipCode => _zipCode;
  int? get longitude => _longitude;
  int? get latitude => _latitude;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['branchName'] = _branchName;
    map['phoneNumber'] = _phoneNumber;
    map['adress'] = _adress;
    map['zipCode'] = _zipCode;
    map['longitude'] = _longitude;
    map['latitude'] = _latitude;
    return map;
  }

}