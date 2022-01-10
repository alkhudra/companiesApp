
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/pages/branch/branch_list.dart';
import 'package:khudrah_companies/pages/contact_us.dart';
import 'package:khudrah_companies/pages/credit_page.dart';
import 'package:khudrah_companies/pages/edit_profile.dart';
import 'package:khudrah_companies/pages/language/language_page.dart';
import 'package:khudrah_companies/pages/language/language_setting.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';

Drawer drawerDesign(context) {
  return Drawer(
    child: ListView(
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
              // Container(
              //   width: 100,
              //   height: 100,
              //   margin: EdgeInsets.only(top: 40),
              //   child: CircleAvatar(
              //     backgroundImage: AssetImage('images/male_avatar.png'),
              //   ),
              // ),
              Container(
                //TODO: replace with company variable from DB
                child: Text('Company Name', style: TextStyle(
                  color: CustomColors().primaryWhiteColor,
                  fontSize: 21,
                  fontWeight: FontWeight.w600,
                ),),
              ),
              SizedBox(height: 10,),
              Container(
                //TODO: replace with email variable from DB
                child: Text('company@email.com', style: TextStyle(
                  color: CustomColors().primaryWhiteColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                ),),
              ),
              SizedBox(height: 20,),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => EditProfile())
                  );
                },
                child: Container(
                  width: 120,
                  height: 40,
                  decoration: BoxDecoration(
                    color: CustomColors().primaryWhiteColor,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Center(child: Text(LocaleKeys.edit_profile.tr(),
                    style: TextStyle(color: CustomColors().primaryGreenColor,
                        fontWeight: FontWeight.w700),)),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10,),
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: CustomColors().branchBG
                ),
                child: Icon(Icons.storefront_rounded, color: CustomColors().branch),
              ),
              SizedBox(width: 10,),
              Text(LocaleKeys.my_branches.tr(), style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),),
            ],
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
              MaterialPageRoute(
                  builder: (context) => BranchList(items: [],)
              ),
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
                    color: CustomColors().creditBG
                ),
                child: Icon(Icons.credit_card_rounded, color: CustomColors().credit),
              ),
              SizedBox(width: 10,),
              Text(LocaleKeys.credit.tr(), style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),),
            ],
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
              MaterialPageRoute(
                  builder: (context) => CreditPage(),
              ),
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
                    color: CustomColors().languageBG
                ),
                child: Icon(Icons.language, color: CustomColors().language,),
              ),
              SizedBox(width: 10,),
              Text(LocaleKeys.languages.tr(), style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),),
            ],
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
              MaterialPageRoute(
                  builder: (context) => LanguageSetting()
              ),
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
                child: Icon(Icons.verified_user_rounded, color: CustomColors().contact,),
              ),
              SizedBox(width: 10,),
              Text(LocaleKeys.contact_us.tr(), style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),),
            ],
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
              MaterialPageRoute(
                  builder: (context) => ContactUs()
              ),
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
                    color: CustomColors().logOutBG
                ),
                child: Icon(Icons.logout, color: CustomColors().logOut,),
              ),
              SizedBox(width: 10,),
              Text(LocaleKeys.log_out.tr(), style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),),
            ],
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
              MaterialPageRoute(
                  builder: (context) => EditProfile()
              ),
            );
          },
        ),
      ],
    ),
  );
}