/// email : "alkahdraproject@gmail.com"
/// phoneNumber : "0551111111"
/// whatsApp : "0551111111"
/// longitude : 34.7
/// latitude : 45.87

//todo: add twitter
class ContactUsResponseModel {
  ContactUsResponseModel({
      String? email, 
      String? phoneNumber, 
      String? whatsApp, 
      double? longitude, 
      double? latitude,}){
    _email = email;
    _phoneNumber = phoneNumber;
    _whatsApp = whatsApp;
    _longitude = longitude;
    _latitude = latitude;
}

  ContactUsResponseModel.fromJson(dynamic json) {
    _email = json['email'];
    _phoneNumber = json['phoneNumber'];
    _whatsApp = json['whatsApp'];
    _longitude = json['longitude'];
    _latitude = json['latitude'];
  }
  String? _email;
  String? _phoneNumber;
  String? _whatsApp;
  double? _longitude;
  double? _latitude;

  String? get email => _email;
  String? get phoneNumber => _phoneNumber;
  String? get whatsApp => _whatsApp;
  double? get longitude => _longitude;
  double? get latitude => _latitude;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = _email;
    map['phoneNumber'] = _phoneNumber;
    map['whatsApp'] = _whatsApp;
    map['longitude'] = _longitude;
    map['latitude'] = _latitude;
    return map;
  }

}