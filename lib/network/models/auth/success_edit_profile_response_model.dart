import 'package:khudrah_companies/network/models/user_model.dart';

/// message : "Updating user profile completed successfully"
/// user : {"id":"eb805db4-3f64-4ef3-ace8-33fcfc94ccb5","email":"somaru.chan@gmail.com","phoneNumber":"0587234461","ownerName":"salma comp","companyName":"salma comp name","commercialRegistrationNo":"5842365988","vatNo":"123456789012345","branchNumber":0,"branches":[{"id":"2f722e79-060a-45d8-ab11-44f687b21091","branchName":"string","phoneNumber":"0512345678","address":"string","districtName":"string","streetName":"string","nationalAddressNo":"1234","city":"string","country":"KSA","longitude":0,"latitude":0,"companyId":"eb805db4-3f64-4ef3-ace8-33fcfc94ccb5"}]}

class SuccessEditProfileResponseModel {
  SuccessEditProfileResponseModel({
      String? message, 
      User? user,}){
    _message = message;
    _user = user;
}

  SuccessEditProfileResponseModel.fromJson(dynamic json) {
    _message = json['message'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  String? _message;
  User? _user;

  String? get message => _message;
  User? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }

}
