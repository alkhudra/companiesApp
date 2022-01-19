class BranchModel {
  BranchModel({
    String? id,
    String? branchName,
    String? phoneNumber,
    String? adress,
    String? district,
    String? street,
    String? nationalID,
    String? city,
    String? country,
    num? longitude,
    num? latitude,
    String? companyId,
  }) {
    _id = id;
    _branchName = branchName;
    _phoneNumber = phoneNumber;
    _adress = adress;
    _nationalID = nationalID;
    _city = city;
    _street = street;
    _district = district;
    _country = country;
    _longitude = longitude;
    _latitude = latitude;
    _companyId = companyId;
  }

  BranchModel.fromJson(dynamic json) {
    _id = json['id'];
    _branchName = json['branchName'];
    _phoneNumber = json['phoneNumber'];
    _adress = json['address'];
    _nationalID = json['nationalAddressNo'];
    _city = json['city'];
    _street = json['streetName'];
    _district = json['districtName'];
    _country = json['country'];
    _longitude = json['longitude'];
    _latitude = json['latitude'];
    _companyId = json['companyId'];
  }
  String? _id;
  String? _phoneNumber;
  String? _adress;
  String? _nationalID;
  String? _city;
  String? _district;
  String? _street;
  String? _country;
  num? _longitude;
  num? _latitude;
  String? _companyId;
  String? _branchName;


  String? get district => _district;

  String? get id => _id;
  String? get phoneNumber => _phoneNumber;
  String? get adress => _adress;
  String? get nationalID => _nationalID;
  String? get city => _city;
  String? get country => _country;
  num? get longitude => _longitude;
  num? get latitude => _latitude;
  String? get companyId => _companyId;
  String? get branchName => _branchName;
  String? get street => _street;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['branchName'] = _branchName;
    map['phoneNumber'] = _phoneNumber;
    map['address'] = _adress;
    map['nationalAddressNo'] = _nationalID;
    map['city'] = _city;
    map['districtName'] = _district;
    map['streetName'] = _street;
    map['country'] = _country;
    map['longitude'] = _longitude;
    map['latitude'] = _latitude;
    map['companyId'] = _companyId;
    return map;
  }

}
