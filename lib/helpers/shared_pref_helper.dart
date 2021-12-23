import 'package:khudrah_companies/Constant/pref_cont.dart';
import 'package:khudrah_companies/helpers/pref_manager.dart';

class PreferencesHelper {

  //------------ put values ----------
  static void saveUserLaunchDate(String value) {
    SharedPrefsManager.setString(userLaunchDate, value);
  }

  static void saveUserEstateCount(int value) {
    SharedPrefsManager.setInt(userEstatesCount, value);
  }

  static void saveUserReservationCount(int value) {
    SharedPrefsManager.setInt(userReservationCount, value);
  }

  static void saveLat(String value) {
    SharedPrefsManager.setString(lat, value);
  }

  static void saveLag(String value) {
    SharedPrefsManager.setString(lag, value);
  }

  static void saveUserName(String value) {
    SharedPrefsManager.setString(userName, value);
  }

  static void setIsLoggedOut(bool value) {
    SharedPrefsManager.setBool(isLoggedOut, value);
  }
  static void setIsLoggedIn(bool value) {
    SharedPrefsManager.setBool(isLoggedIn, value);
  }

  static void isUserFirstLogIn(bool value) {
    SharedPrefsManager.setBool(firstLogin, value);
  }

  static void setUserPhone(String value) {
    SharedPrefsManager.setString(userPhone, value);
  }

  static void setIsNewUser(bool value) {
    SharedPrefsManager.setBool(isNew, value);
  }

  static void saveSMSCode(String value) {
    SharedPrefsManager.setString(smsCode, value);
  }

  static void saveLanguage(String value) {
    SharedPrefsManager.setString(languageKey, value);
  }

  static void saveHeaderLanguage(String value) {
    SharedPrefsManager.setString(headerLanguageKey, value);
  }

  static void saveToken(String value) {
    SharedPrefsManager.setString(token, value);
  }

  static void saveTokenType(String value) {
    SharedPrefsManager.setString(tokenType, value);
  }

  static void saveNotificationID(String value) {
    SharedPrefsManager.setString(notificationID, value);
  }

  static void saveNotificationCount(int value) {
    SharedPrefsManager.setInt(notificationCount, value);
  }

/*
   static void saveSelectedCountry(CountriesItem country) {
    Gson gson = new Gson();
    String json = gson.toJson(country);
    SharedPrefsManager.setString(selectedCountry, json);
  }
*/

  ///---------get data ----------

  static String getUserLaunchDate() {
    return SharedPrefsManager.getString(userLaunchDate);
  }

  static int getUserEstateCount(int defValue) {
    return SharedPrefsManager.getInt(userEstatesCount);
  }

  static int getUserReservationCount(int defValue) {
    return SharedPrefsManager.getInt(userReservationCount);
  }

  static String getLat() {
    return SharedPrefsManager.getString(lat);
  }

  static String getLag() {
    return SharedPrefsManager.getString(lag);
  }

  static bool getLoggedIn() {
    return SharedPrefsManager.getBool(isLoggedIn);
  }

  static bool getUserFirstLogInState() {
    return SharedPrefsManager.getBool(firstLogin);
  }

  static bool getIsNewUser() {
    return SharedPrefsManager.getBool(isNew);
  }

  static String getNotificationID(String defValue) {
    return SharedPrefsManager.getString(notificationID);
  }

  static int getNotificationCount(int defValue) {
    return SharedPrefsManager.getInt(notificationCount);
  }

  static String getUserPhone(String defValue) {
    return SharedPrefsManager.getString(userPhone);
  }

  static String getUserName(String defValue) {
    return SharedPrefsManager.getString(userName);
  }

  static String getSMSCode(String defValue) {
    return SharedPrefsManager.getString(smsCode);
  }

  static String getLanguage(String defValue) {
    return SharedPrefsManager.getString(languageKey);
  }

  static String getHeaderLanguage(String defValue) {
    return SharedPrefsManager.getString(headerLanguageKey);
  }

  static String getToken(String defValue) {
    return SharedPrefsManager.getString(token);
  }

  static String getTokenType(String defValue) {
    return SharedPrefsManager.getString(tokenType);
  }
}
