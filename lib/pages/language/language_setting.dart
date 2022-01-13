import 'package:khudrah_companies/designs/appbar_design.dart';
import 'package:khudrah_companies/helpers/pref/shared_pref_helper.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
// import 'package:alkhudhrah_app/designs/bottom_nav_bar.dart';
import 'package:khudrah_companies/designs/ButtonsDesign.dart';
import 'package:khudrah_companies/designs/drawar_design.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';


enum Languages { english, arabic }

class LanguageSetting extends StatefulWidget {

  @override
  _LanguageSettingState createState() => _LanguageSettingState();
}

class _LanguageSettingState extends State<LanguageSetting> {



  void onLanguageButtonPressed(BuildContext context , String localeName) async{

    if(localeName == 'en')
      await context.setLocale(Locale('en'));
    else   await context.setLocale(Locale('ar'));
    PreferencesHelper.setSelectedLanguage(localeName);
    // Navigator.push(context, MaterialPageRoute(builder: (context) {
    //   return LanguageSetting();
    // }));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // backgroundColor: Colors.grey[100],
      appBar: appBarDesign(context, LocaleKeys.app_lang.tr()),
      body: Container(
            // margin: EdgeInsets.only(top: 100),
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            color: CustomColors().primaryWhiteColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Text(LocaleKeys.select_lang.tr()+':',
                  style: TextStyle(
                    color: CustomColors().blackColor.withOpacity(0.7),
                    fontSize: 18,
                    fontWeight: FontWeight.w600
                  ),),
                ),
                SizedBox(
                  height: 20,
                ),
          Container(
          margin: EdgeInsets.only(left: 40, right: 40),
          child: MaterialButton(
            onPressed: () {
              onLanguageButtonPressed(context,'ar');
            },
            height: ButtonsDesign.buttonsHeight,
            shape: StadiumBorder(),
            child: ButtonsDesign.buttonsText('عربي',CustomColors().primaryWhiteColor),
            color: CustomColors().brownColor,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          margin: EdgeInsets.only(left: 40, right: 40),
          child: MaterialButton(
            onPressed: () {
              onLanguageButtonPressed(context,'en');
            },
            height: ButtonsDesign.buttonsHeight,
            shape: StadiumBorder(),
            child: ButtonsDesign.buttonsText('english',CustomColors().primaryWhiteColor),
            color: CustomColors().primaryGreenColor,
          ),
        ),
                // ListTile(
                //   title: Text(LocaleKeys.english.tr(),
                //   style: TextStyle(
                //     color: kLogoGreen,
                //     fontWeight: FontWeight.w700
                //   ),),
                //   leading: Radio<Languages>(
                //     activeColor: kLogoGreen,
                //     value: Languages.english,
                //     groupValue: _character,
                //     onChanged: (Languages? value) {
                //       setState(() {
                //         _character = value;
                //         onLanguageButtonPressed(context,'en');
                //       });
                //     },
                //   ),
                // ),
                //add english button

                // ListTile(
                //   title: Text(LocaleKeys.arabic.tr(),
                //   style: TextStyle(
                //     color: kLogoGreen,
                //     fontWeight: FontWeight.w700
                //   ),),
                //   leading: Radio<Languages>(
                //     activeColor: kLogoGreen,
                //     value: Languages.arabic,
                //     groupValue: _character,
                //     onChanged: (Languages? value) {
                //       setState(() {
                //         _character = value;
                //         onLanguageButtonPressed(context,'ar');
                //       });
                //     },
                //   ),
                // ),
                //add arabic button
              ],
            ),
          ),
      endDrawer: drawerDesign(context),
    );
  }
}

/*
Container(
                // margin: EdgeInsets.only(top: 100),
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                color: CustomColors().primaryWhiteColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                      child: Text(LocaleKeys.select_lang.tr()+':',
                      style: TextStyle(
                        color: CustomColors().blackColor.withOpacity(0.7),
                        fontSize: 18,
                        fontWeight: FontWeight.w600
                      ),),
                    ),
                    SizedBox(
                      height: 20,
                    ),
              Container(
              margin: EdgeInsets.only(left: 40, right: 40),
              child: MaterialButton(
                onPressed: () {
                  onLanguageButtonPressed(context,'ar');
                },
                height: ButtonsDesign.buttonsHeight,
                shape: StadiumBorder(),
                child: ButtonsDesign.buttonsText('عربي',CustomColors().primaryWhiteColor),
                color: CustomColors().brownColor,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 40, right: 40),
              child: MaterialButton(
                onPressed: () {
                  onLanguageButtonPressed(context,'en');
                },
                height: ButtonsDesign.buttonsHeight,
                shape: StadiumBorder(),
                child: ButtonsDesign.buttonsText('english',CustomColors().primaryWhiteColor),
                color: CustomColors().primaryGreenColor,
              ),
            ),
                    // ListTile(
                    //   title: Text(LocaleKeys.english.tr(),
                    //   style: TextStyle(
                    //     color: kLogoGreen,
                    //     fontWeight: FontWeight.w700
                    //   ),),
                    //   leading: Radio<Languages>(
                    //     activeColor: kLogoGreen,
                    //     value: Languages.english,
                    //     groupValue: _character,
                    //     onChanged: (Languages? value) {
                    //       setState(() {
                    //         _character = value;
                    //         onLanguageButtonPressed(context,'en');
                    //       });
                    //     },
                    //   ),
                    // ),
                    //add english button

                    // ListTile(
                    //   title: Text(LocaleKeys.arabic.tr(),
                    //   style: TextStyle(
                    //     color: kLogoGreen,
                    //     fontWeight: FontWeight.w700
                    //   ),),
                    //   leading: Radio<Languages>(
                    //     activeColor: kLogoGreen,
                    //     value: Languages.arabic,
                    //     groupValue: _character,
                    //     onChanged: (Languages? value) {
                    //       setState(() {
                    //         _character = value;
                    //         onLanguageButtonPressed(context,'ar');
                    //       });
                    //     },
                    //   ),
                    // ),
                    //add arabic button
                  ],
                ),
              ),
*/