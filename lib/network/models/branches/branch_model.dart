class BranchModel {
  BranchModel({
    String? id,
    String? branchName,
    String? phoneNumber,
    String? address,
    String? districtName,
    String? streetName,
    String? nationalAddressNo,
    String? city,
    String? country,
    num? longitude,
    num? latitude,
    String? companyId,
  }) {
    _id = id;
    _branchName = branchName;
    _phoneNumber = phoneNumber;
    _address = address;
    _districtName = districtName;
    _streetName = streetName;
    _nationalAddressNo = nationalAddressNo;
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
    _address = json['address'];
    _districtName = json['districtName'];
    _streetName = json['streetName'];
    _nationalAddressNo = json['nationalAddressNo'];
    _city = json['city'];
    _country = json['country'];
    _longitude = json['longitude'];
    _latitude = json['latitude'];
    _companyId = json['companyId'];
  }
  String? _id;
  String? _branchName;
  String? _phoneNumber;
  String? _address;
  String? _districtName;
  String? _streetName;
  String? _nationalAddressNo;
  String? _city;
  String? _country;
  num? _longitude;
  num? _latitude;
  String? _companyId;

  String? get id => _id;
  String? get branchName => _branchName;
  String? get phoneNumber => _phoneNumber;
  String? get address => _address;
  String? get districtName => _districtName;
  String? get streetName => _streetName;
  String? get nationalAddressNo => _nationalAddressNo;
  String? get city => _city;
  String? get country => _country;
  num? get longitude => _longitude;
  num? get latitude => _latitude;
  String? get companyId => _companyId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['branchName'] = _branchName;
    map['phoneNumber'] = _phoneNumber;
    map['address'] = _address;
    map['districtName'] = _districtName;
    map['streetName'] = _streetName;
    map['nationalAddressNo'] = _nationalAddressNo;
    map['city'] = _city;
    map['country'] = _country;
    map['longitude'] = _longitude;
    map['latitude'] = _latitude;
    map['companyId'] = _companyId;
    return map;
  }

  @override
  String toString() {
    return 'BranchModel{_id: $_id, _branchName: $_branchName, _phoneNumber: $_phoneNumber, _address: $_address, _districtName: $_districtName, _streetName: $_streetName, _nationalAddressNo: $_nationalAddressNo, _city: $_city, _country: $_country, _longitude: $_longitude, _latitude: $_latitude, _companyId: $_companyId}';
  }
}
