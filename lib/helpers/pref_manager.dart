import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsManager {
//-----------------------------------

  static setString(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString(key, value);
  }

  static setInt(String key, int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt(key, value);
  }

  static setDouble(String key, double value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setDouble(key, value);
  }

  static setBool(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setBool(key, value);
  }

//-----------------------------------

  static getString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //Return String
    String stringValue = prefs.getString(key) ?? '';
    return stringValue;
  }

  static getBool(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //Return bool
    bool boolValue = prefs.getBool(key) ?? true;
    return boolValue;
  }

  static getInt(String key) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //Return int
    int intValue = prefs.getInt(key) ?? 0;
    return intValue;
  }

  static getDouble(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //Return double
    double doubleValue = prefs.getDouble(key) ?? 0;
    return doubleValue;
  }

//-----------------------------------

  static removeValues(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove(key);
  }

//--------------------------------

  static checkValue(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool checkValue = prefs.containsKey(key);
    return checkValue;
  }
}
