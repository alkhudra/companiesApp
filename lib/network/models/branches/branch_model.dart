/// id : "86b34037-c2c7-44a8-8b7b-97d7dcefc861"
/// branchName : "string"
/// phoneNumber : "0541227860"
/// adress : "string"
/// zipCode : "12345"
/// city : "Jeddah"
/// country : "KSA"
/// longitude : 0
/// latitude : 0
/// companyId : "897fd3ea-e138-4947-aa94-6749584d1a4b"

class BranchModel {
  BranchModel({
      String? id, 
      String? branchName, 
      String? phoneNumber, 
      String? adress, 
      String? zipCode, 
      String? city, 
      String? country, 
      int? longitude, 
      int? latitude, 
      String? companyId,}){
    _id = id;
    _branchName = branchName;
    _phoneNumber = phoneNumber;
    _adress = adress;
    _zipCode = zipCode;
    _city = city;
    _country = country;
    _longitude = longitude;
    _latitude = latitude;
    _companyId = companyId;
}

  BranchModel.fromJson(dynamic json) {
    _id = json['id'];
    _branchName = json['branchName'];
    _phoneNumber = json['phoneNumber'];
    _adress = json['adress'];
    _zipCode = json['zipCode'];
    _city = json['city'];
    _country = json['country'];
    _longitude = json['longitude'];
    _latitude = json['latitude'];
    _companyId = json['companyId'];
  }
  String? _id;
  String? _branchName;
  String? _phoneNumber;
  String? _adress;
  String? _zipCode;
  String? _city;
  String? _country;
  int? _longitude;
  int? _latitude;
  String? _companyId;

  String? get id => _id;
  String? get branchName => _branchName;
  String? get phoneNumber => _phoneNumber;
  String? get adress => _adress;
  String? get zipCode => _zipCode;
  String? get city => _city;
  String? get country => _country;
  int? get longitude => _longitude;
  int? get latitude => _latitude;
  String? get companyId => _companyId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['branchName'] = _branchName;
    map['phoneNumber'] = _phoneNumber;
    map['adress'] = _adress;
    map['zipCode'] = _zipCode;
    map['city'] = _city;
    map['country'] = _country;
    map['longitude'] = _longitude;
    map['latitude'] = _latitude;
    map['companyId'] = _companyId;
    return map;
  }

}