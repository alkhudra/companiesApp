
class ContactUsResponseModel {
  ContactUsResponseModel({
      String? email, 
      String? phoneNumber, 
      String? whatsApp,
    String? twitter,
      double? longitude, 
      double? latitude,}){
    _email = email;
    _phoneNumber = phoneNumber;
    _whatsApp = whatsApp;
    _longitude = longitude;
    _twitter =twitter;
    _latitude = latitude;
}

  ContactUsResponseModel.fromJson(dynamic json) {
    _email = json['email'];
    _phoneNumber = json['phoneNumber'];
    _whatsApp = json['whatsApp'];
    _longitude = json['longitude'];
    _latitude = json['latitude'];
    _twitter = json['twitter'];
  }
  String? _email;
  String? _phoneNumber;
  String? _twitter;
  String? _whatsApp;
  double? _longitude;
  double? _latitude;

  String? get email => _email;
  String? get phoneNumber => _phoneNumber;
  String? get whatsApp => _whatsApp;
  double? get longitude => _longitude;
  double? get latitude => _latitude;
  String? get twitter => _twitter;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = _email;
    map['phoneNumber'] = _phoneNumber;
    map['whatsApp'] = _whatsApp;
    map['longitude'] = _longitude;
    map['twitter'] = _twitter;
    map['latitude'] = _latitude;
    return map;
  }

}