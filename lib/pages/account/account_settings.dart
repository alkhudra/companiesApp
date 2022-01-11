import 'package:flutter/material.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/designs/account_setting_design.dart';
import 'package:khudrah_companies/designs/appbar_design.dart';
import 'package:khudrah_companies/designs/drawar_design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:khudrah_companies/dialogs/passowrd_dialog.dart';
import 'package:khudrah_companies/pages/edit_profile.dart';
import 'package:khudrah_companies/pages/reset_password/change_password.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';


class AccountSettings extends StatefulWidget {
  const AccountSettings({ Key? key }) : super(key: key);

  @override
  _AccountSettingsState createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 2,),
          accountRowDesign(LocaleKeys.edit_profile_title.tr(),
          nav: () {
            Navigator.push(context, MaterialPageRoute(
            builder: (context) => EditProfile())
            );
          }
          ),
          Divider(thickness: 2, color: CustomColors().grayColor,),
          accountRowDesign(LocaleKeys.change_password.tr(),
          nav: () {
            showDialog(
              builder: (BuildContext context) =>
                showEnterEmailDialog(context,true),
                  context: context);
          }),
          Divider(thickness: 2, color: CustomColors().grayColor,),
        ],
      ),
      endDrawer: drawerDesign(context),
      appBar: appBarDesign(context, LocaleKeys.account_setting.tr()),
    );
  }
}
