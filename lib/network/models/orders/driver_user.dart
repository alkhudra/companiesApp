class DriverUser {
  DriverUser({
    String? id,
    String? email,
    String? phoneNumber,
    String? driverName,
    String? image,}){
    _id = id;
    _email = email;
    _phoneNumber = phoneNumber;
    _driverName = driverName;
    _image = image;
  }

  DriverUser.fromJson(dynamic json) {
    _id = json['id'];
    _email = json['email'];
    _phoneNumber = json['phoneNumber'];
    _driverName = json['driverName'];
    _image = json['image'];
  }
  String? _id;
  String? _email;
  String? _phoneNumber;
  String? _driverName;
  String? _image;

  String? get id => _id;
  String? get email => _email;
  String? get phoneNumber => _phoneNumber;
  String? get driverName => _driverName;
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['email'] = _email;
    map['phoneNumber'] = _phoneNumber;
    map['driverName'] = _driverName;
    map['image'] = _image;
    return map;
  }

}