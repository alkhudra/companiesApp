
class LoginResponse {
  LoginResponse({
      User? user, 
      String? token,}){
    _user = user;
    _token = token;
}

  LoginResponse.fromJson(dynamic json) {
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _token = json['token'];
  }
  User? _user;
  String? _token;

  User? get user => _user;
  String? get token => _token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    map['token'] = _token;
    return map;
  }

}


class User {
  User({
      String? id, 
      String? email, 
      String? phoneNumber, 
      String? ownerName, 
      String? companyName, 
      String? commercialRegistrationNo, 
      int? branchNumber, 
      List<Branches>? branches,}){
    _id = id;
    _email = email;
    _phoneNumber = phoneNumber;
    _ownerName = ownerName;
    _companyName = companyName;
    _commercialRegistrationNo = commercialRegistrationNo;
    _branchNumber = branchNumber;
    _branches = branches;
}

  User.fromJson(dynamic json) {
    _id = json['id'];
    _email = json['email'];
    _phoneNumber = json['phoneNumber'];
    _ownerName = json['ownerName'];
    _companyName = json['companyName'];
    _commercialRegistrationNo = json['commercialRegistrationNo'];
    _branchNumber = json['branchNumber'];
    if (json['branches'] != null) {
      _branches = [];
      json['branches'].forEach((v) {
        _branches?.add(Branches.fromJson(v));
      });
    }
  }
  String? _id;
  String? _email;
  String? _phoneNumber;
  String? _ownerName;
  String? _companyName;
  String? _commercialRegistrationNo;
  int? _branchNumber;
  List<Branches>? _branches;

  String? get id => _id;
  String? get email => _email;
  String? get phoneNumber => _phoneNumber;
  String? get ownerName => _ownerName;
  String? get companyName => _companyName;
  String? get commercialRegistrationNo => _commercialRegistrationNo;
  int? get branchNumber => _branchNumber;
  List<Branches>? get branches => _branches;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['email'] = _email;
    map['phoneNumber'] = _phoneNumber;
    map['ownerName'] = _ownerName;
    map['companyName'] = _companyName;
    map['commercialRegistrationNo'] = _commercialRegistrationNo;
    map['branchNumber'] = _branchNumber;
    if (_branches != null) {
      map['branches'] = _branches?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}



class Branches {
  Branches({
      String? id, 
      String? phoneNumber, 
      String? adress, 
      String? zipCode, 
      String? city, 
      String? country, 
      double? longitude, 
      double? latitude, 
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

  Branches.fromJson(dynamic json) {
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
  double? _longitude;
  double? _latitude;
  String? _companyId;

  String? get id => _id;
  String? get phoneNumber => _phoneNumber;
  String? get adress => _adress;
  String? get zipCode => _zipCode;
  String? get city => _city;
  String? get country => _country;
  double? get longitude => _longitude;
  double? get latitude => _latitude;
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