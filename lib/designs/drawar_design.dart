import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khudrah_companies/Constant/conts.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/helpers/route_helper.dart';

import 'package:khudrah_companies/network/models/branches/branch_model.dart';

import 'package:khudrah_companies/pages/account/account_settings.dart';
import 'package:khudrah_companies/pages/branch/branch_list.dart';
import 'package:khudrah_companies/pages/contact_us.dart';
import 'package:khudrah_companies/pages/credit_page.dart';
import 'package:khudrah_companies/pages/language/language_setting.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';

late List<BranchModel> list;


//-------------------


Drawer drawerDesignWithName(context, String name, String email) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.all(0.0),
      children: [
        Container(
          width: 100,
          height: 220,
          decoration: BoxDecoration(
            color: CustomColors().primaryGreenColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(60),
              bottomRight: Radius.circular(60),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 40),
                child: Text(
                  name,
                  style: TextStyle(
                    color: CustomColors().primaryWhiteColor,
                    fontSize: 21,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Text(
                  email,
                  style: TextStyle(
                    color: CustomColors().primaryWhiteColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AccountSettings()));
                },
                child: Container(
                  width: 120,
                  height: 40,
                  decoration: BoxDecoration(
                    color: CustomColors().primaryWhiteColor,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Center(
                      child: Text(
                        LocaleKeys.account_setting.tr(),
                        style: TextStyle(
                            color: CustomColors().primaryGreenColor,
                            fontWeight: FontWeight.w700),
                      )),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: CustomColors().branchBG),
                child: Icon(
                  FontAwesomeIcons.store,
                  color: CustomColors().branch,
                  size: 20,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                LocaleKeys.my_branches.tr(),
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BranchList(
                    //  list: [],//branchListResponseModel.branches,
                  )),
            );
          },
        ),
/*        Divider(
          thickness: 2.5,
        ),
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: CustomColors().creditBG),
                child: Icon(
                  FontAwesomeIcons.creditCard,
                  color: CustomColors().credit,
                  size: 20,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                LocaleKeys.credit.tr(),
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreditPage(),
              ),
            );
          },
        ),*/
        Divider(
          thickness: 2.5,
        ),
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: CustomColors().languageBG),
                child: Icon(
                  FontAwesomeIcons.globeAfrica,
                  color: CustomColors().language,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                LocaleKeys.languages.tr(),
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LanguageSetting()),
            );
          },
        ),
        Divider(
          thickness: 2.5,
        ),
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: CustomColors().contactBG,
                ),
                child: Icon(
                  Icons.verified_user_rounded,
                  color: CustomColors().contact,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                LocaleKeys.contact_us.tr(),
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ContactUs()),
            );
          },
        ),
        Divider(
          thickness: 2.5,
        ),
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: CustomColors().logOutBG),
                child: Icon(
                  Icons.logout,
                  color: CustomColors().logOut,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                LocaleKeys.log_out.tr(),
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          onTap: () {
            Navigator.pop(context);

            logoutUser(context);

          },
        ),
        ListTile(
          title: SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
        ),
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Version ' + version,
                style: TextStyle(
                  color: CustomColors().primaryGreenColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

