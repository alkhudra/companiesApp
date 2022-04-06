import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khudrah_companies/dialogs/progress_dialog.dart';
import 'package:khudrah_companies/helpers/pref/shared_pref_helper.dart';
import 'package:khudrah_companies/network/API/api_response.dart';
import 'package:khudrah_companies/network/API/api_response_type.dart';
import 'package:khudrah_companies/network/helper/network_helper.dart';
import 'package:khudrah_companies/network/repository/edit_profile_repository.dart';
import 'package:khudrah_companies/router/route_constants.dart';

void moveToNewStack(BuildContext context, String routeString) {
  Navigator.of(context)
      .pushNamedAndRemoveUntil(routeString, (Route<dynamic> route) => false);
}

void moveToNewStackWithArgs(context, MaterialPageRoute materialPageRoute) {
  Navigator.pushAndRemoveUntil(context, materialPageRoute, (route) => false);
}

void logoutUser(context) async {

  //----------start api ----------------

  Map<String, dynamic> headerMap = await getHeaderMap();


  ProfileRepository editProfileRepository = ProfileRepository(headerMap);



  editProfileRepository.logOut().then((result) async {

    print('logout successfully');
  });

/*  PreferencesHelper.setUser(null);
  PreferencesHelper.setUserLoggedIn(false);
  PreferencesHelper.setUserFirstLogIn(false);
  moveToNewStack(context, loginRoute);*/

}
