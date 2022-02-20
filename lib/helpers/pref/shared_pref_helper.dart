import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:khudrah_companies/Constant/pref_cont.dart';
import 'package:khudrah_companies/helpers/pref/pref_manager.dart';
import 'package:khudrah_companies/network/models/branches/branch_list_response_model.dart';
import 'package:khudrah_companies/network/models/user_model.dart';import 'package:khudrah_companies/network/models/branches/branch_model.dart';

class PreferencesHelper {
  static Future<bool> get getIsUserFirstLogIn =>
      SharedPrefsManager.getBool(firstLogin);
  static Future setUserFirstLogIn(bool value) =>
      SharedPrefsManager.setBool(firstLogin, value);


  //----------------
  static Future<bool> get getIsUserLoggedIn =>
      SharedPrefsManager.getBool(isLoggedIn);
  static Future setUserLoggedIn(bool value) =>
      SharedPrefsManager.setBool(isLoggedIn, value);

  //------------------

  static Future<bool> get getIsUserLoggedOut =>
      SharedPrefsManager.getBool(isLoggedOut);
  static Future setUserLoggedOut(bool value) =>
      SharedPrefsManager.setBool(isLoggedOut, value);


  //------------------

  static Future<String> get getUserID => SharedPrefsManager.getString(userID);
  static Future setUserID(String value) =>
      SharedPrefsManager.setString(userID, value);


  //--------------------
  static Future<String> get getSelectedLanguage =>
      SharedPrefsManager.getString(currentLanguage);

  static Future setSelectedLanguage(String value) =>
      SharedPrefsManager.setString(currentLanguage, value);
  //--------------------

  static Future<String> get getUserToken => SharedPrefsManager.getString(token);

  static Future setUserToken(String value) =>
      SharedPrefsManager.setString(token, value);
  //--------------------
/*
  static Future<List<Cities>> get getCities async {
    List<Cities> citiesList =[];
  *//*  Map<String, dynamic> userMap =
    await SharedPrefsManager.getFromJson(cities);*//*
   List< Cities> o = SharedPrefsManager.getFromJson(cities);
    o.forEach((v) {
      citiesList.add(Cities.fromJson(v));
    });
    return citiesList;//Cities.fromJson(userMap);
  }

  static Future setCities(List<Cities>? citiesValue) {
    //  user = User.fromJson(user);
    if (citiesValue != null)
      return SharedPrefsManager.setToJson(cities, citiesValue);
    else
      return SharedPrefsManager.setToJson(cities, '');
  }*/
  //--------------------

  static Future<User> get getUser async {
    Map<String, dynamic> userMap =
        await SharedPrefsManager.getFromJson(currentUser);
    return User.fromJson(userMap);
  }

  static Future setUser(User? user) {
    //  user = User.fromJson(user);
    if (user != null)
      return SharedPrefsManager.setToJson(currentUser, user);
    else
      return SharedPrefsManager.setToJson(currentUser, '');
  }
  //--------------------

  static Future<List<BranchModel>?> get getUserList async {
    Map<String, dynamic> userMap =
    await SharedPrefsManager.getFromJson(currentUser);
    User user= User.fromJson(userMap);
    List<BranchModel>? list = user.branches;
    return list;
  }
  static Future  addToUserList (BranchModel model)async {
    Map<String, dynamic> userMap =
    await SharedPrefsManager.getFromJson(currentUser);
    User user= User.fromJson(userMap);
    List<BranchModel>? list = user.branches;

    list?.add(model);
  }
  static Future  removeFromUserList (BranchModel model)async {
    Map<String, dynamic> userMap =
    await SharedPrefsManager.getFromJson(currentUser);
    User user= User.fromJson(userMap);
    List<BranchModel>? list = user.branches;

    list?.remove(model);
  }
//--------------------

  static void clearPrefs(){
    SharedPrefsManager.clear();
  }
/*  Future<void> clear() async {
    await Future.wait(<Future>[
      setAuthenticated(false),
      setTutorialString(''),
      setPasscode(''),
    ]);
  }*/
}
