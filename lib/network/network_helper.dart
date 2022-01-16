import 'package:khudrah_companies/helpers/pref/shared_pref_helper.dart';

Future<Map<String, dynamic>> getHeaderMap() async {
  String token = await PreferencesHelper.getUserToken;

  String selectedLanguage = await PreferencesHelper.getSelectedLanguage;
  print('token from method $token');
  print('selectedLanguage from method $selectedLanguage');
  return {
    //  "language" : "$selectedLanguage",
    "Authorization": "Bearer $token"
  };
}