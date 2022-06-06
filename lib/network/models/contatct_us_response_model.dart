class ContactUsResponseModel {
  ContactUsResponseModel({
    String? email,
    String? phoneNumber,
    String? whatsApp,
    String? twitter,
    num? longitude,
    num? latitude,
  }) {
    _email = email == null ? '' : email;
    _phoneNumber = phoneNumber == null ? '' : phoneNumber;
    _whatsApp = whatsApp == null ? '' : whatsApp;
    _longitude = longitude == 0 ? 0.0 : longitude;
    _twitter = twitter == null ? '' : twitter;
    _latitude = latitude == 0 ? 0.0 : latitude;
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
  num? _longitude;
  num? _latitude;

  String? get email => _email;
  String? get phoneNumber => _phoneNumber;
  String? get whatsApp => _whatsApp;
  num? get longitude => _longitude;
  num? get latitude => _latitude;
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
