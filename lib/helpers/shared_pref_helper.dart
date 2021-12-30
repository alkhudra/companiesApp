import 'package:khudrah_companies/Constant/pref_cont.dart';
import 'package:khudrah_companies/helpers/pref_manager.dart';

class PreferencesHelper {

  static Future<String> get getUserID => SharedPrefsManager.getString(userID);

  static Future setUserID(String value) => SharedPrefsManager.setString(userID, value);

/*
  static Future<bool> get authenticated => SharedPrefsManager.getBool(Const.AUTHENTICATED);

  static Future setAuthenticated(bool value) => SharedPrefsManager.setBool(Const.AUTHENTICATED, value);

  static Future<String> get passcode => SharedPrefsManager.getString(Const.PASSCODE);

  static Future setPasscode(String value) => SharedPrefsManager.setString(Const.PASSCODE, value);
*/

/*  Future<void> clear() async {
    await Future.wait(<Future>[
      setAuthenticated(false),
      setTutorialString(''),
      setPasscode(''),
    ]);
  }*/
}
