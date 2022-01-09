import 'dart:convert';

import 'package:khudrah_companies/Constant/pref_cont.dart';
import 'package:khudrah_companies/helpers/pref/pref_manager.dart';
import 'package:khudrah_companies/network/models/auth/success_login_response_model.dart';

class PreferencesHelper {
  static Future<String> get getUserID => SharedPrefsManager.getString(userID);
  static Future setUserID(String value) =>
      SharedPrefsManager.setString(userID, value);

  static String? getCompanyID(){
    PreferencesHelper.getUserID.then((value) {
      return value;
    });
  }

  //--------------------
  static Future<String> get getSelectedLanguage =>
      SharedPrefsManager.getString(currentLanguage);


  static String? getLanguage(){
    PreferencesHelper.getSelectedLanguage.then((value) {
      return value;
    });
  }
  static Future setSelectedLanguage(String value) =>
      SharedPrefsManager.setString(currentLanguage, value);
  //--------------------

  static Future<String> get getUserToken => SharedPrefsManager.getString(token);

  static Future setUserToken(String value) =>
      SharedPrefsManager.setString(token, value);

  static String? getToken(){
    PreferencesHelper.getUserToken.then((value) {
      return value;
    });
  }
  //--------------------

  static Future<User> get getUser async => User.fromJson(SharedPrefsManager.getFromJson(currentUser));

  static Future setUser(User user) {
  //  user = User.fromJson(user);
    return SharedPrefsManager.setToJson(currentUser, user);
  }

//--------------------

/*  Future<void> clear() async {
    await Future.wait(<Future>[
      setAuthenticated(false),
      setTutorialString(''),
      setPasscode(''),
    ]);
  }*/
}
