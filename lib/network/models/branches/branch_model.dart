
class BranchModel {
  BranchModel({
    String? id,
    String? phoneNumber,
    String? adress,
    String? zipCode,
    String? city,
    String? country,
    num? longitude,
    num? latitude,
    String? companyId,}){
    _id = id;
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
  String? _phoneNumber;
  String? _adress;
  String? _zipCode;
  String? _city;
  String? _country;
  num? _longitude;
  num? _latitude;
  String? _companyId;

  String? get id => _id;
  String? get phoneNumber => _phoneNumber;
  String? get adress => _adress;
  String? get zipCode => _zipCode;
  String? get city => _city;
  String? get country => _country;
  num? get longitude => _longitude;
  num? get latitude => _latitude;
  String? get companyId => _companyId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
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