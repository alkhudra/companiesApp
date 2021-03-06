import 'package:flutter/material.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/designs/account_setting_design.dart';
import 'package:khudrah_companies/designs/appbar_design.dart';
import 'package:khudrah_companies/designs/drawar_design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:khudrah_companies/dialogs/message_dialog.dart';
import 'package:khudrah_companies/dialogs/passowrd_dialog.dart';
import 'package:khudrah_companies/dialogs/progress_dialog.dart';
import 'package:khudrah_companies/network/helper/network_helper.dart';
import 'package:khudrah_companies/helpers/pref/shared_pref_helper.dart';
import 'package:khudrah_companies/network/API/api_response_type.dart';
import 'package:khudrah_companies/network/models/user_model.dart';import 'package:khudrah_companies/network/repository/edit_profile_repository.dart';
import 'package:khudrah_companies/pages/account/edit_profile.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';

class AccountSettings extends StatefulWidget {
  const AccountSettings({Key? key}) : super(key: key);

  @override
  _AccountSettingsState createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  bool isForgetPassBtnEnabled = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 5,
          ),
          accountRowDesign(LocaleKeys.edit_profile_title.tr(), nav: () {
            getUserInfo();
          }),
          Divider(
            thickness: 2,
            color: CustomColors().grayColor,
          ),
          accountRowDesign(LocaleKeys.change_password.tr(), nav: () {
            showDialog(
                builder: (BuildContext context) =>
                    showEnterEmailDialog(context, true),
                context: context);
          }),
          Divider(
            thickness: 2,
            color: CustomColors().grayColor,
          ),
        ],
      ),
      // endDrawer: drawerDesign(context),
      appBar: appBarDesign(context, LocaleKeys.account_setting.tr()),
    );
  }

  void getUserInfo() async {
    print('get user info ');
    //----------show progress----------------

   // showLoaderDialog(context);

    User user = await PreferencesHelper.getUser;
    print(user.toString());
   // Navigator.pop(context);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditProfile(
                  user: user,
                )));
  }
}
