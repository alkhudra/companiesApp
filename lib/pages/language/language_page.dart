import 'package:flutter/material.dart';
import 'package:khudrah_companies/designs/ButtonsDesign.dart';
import 'package:khudrah_companies/designs/brand_name.dart';
import 'package:khudrah_companies/helpers/pref/shared_pref_helper.dart';
import 'package:khudrah_companies/pages/auth/login_page.dart';
import 'package:khudrah_companies/pages/home_page.dart';
import 'package:khudrah_companies/pages/welcome_page.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:khudrah_companies/router/route_constants.dart';

class LanguagePage extends StatefulWidget {
  @override
  _LanguagePageState createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  void onLanguageButtonPressed(BuildContext context, String localeName) async {
    if (localeName == 'en')
      await context.setLocale(Locale('en'));
    else
      await context.setLocale(Locale('ar'));
    //  PreferencesHelper.setUserFirstLogIn(false);
    PreferencesHelper.setSelectedLanguage(localeName);

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return WelcomePage();
    }));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[100],

      body: Container(
        // margin: EdgeInsets.only(top: 100),
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        color: CustomColors().primaryWhiteColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

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

    );
  }
}
