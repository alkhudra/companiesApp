import 'package:flutter/material.dart';
import 'package:khudrah_companies/designs/ButtonsDesign.dart';
import 'package:khudrah_companies/designs/brand_name.dart';
import 'package:khudrah_companies/helpers/pref/shared_pref_helper.dart';
import 'package:khudrah_companies/pages/auth/login_page.dart';
import 'package:khudrah_companies/pages/home_page.dart';
import 'package:khudrah_companies/pages/welcome_page.dart';
import 'package:khudrah_companies/provider/genral_provider.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:khudrah_companies/router/route_constants.dart';
import 'package:provider/provider.dart';

class LanguagePage extends StatefulWidget {
  @override
  _LanguagePageState createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {

  @override
  void initState() {

    super.initState();
    print('welcome in language ');
  }

  void onLanguageButtonPressed(BuildContext context , String localeName) async{


    if(localeName == 'en')
      await context.setLocale(Locale('en'));
    else   await context.setLocale(Locale('ar'));
  //  PreferencesHelper.setUserFirstLogIn(false);

    PreferencesHelper.setSelectedLanguage(localeName);
    Provider.of<GeneralProvider>(context,listen: false).setUserSelectedLanguage(localeName);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return WelcomePage();
    }));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors().backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: brandName(250.0, 250.0, 30.0),
          ),
          SizedBox(
            height: 60,
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: MaterialButton(
              onPressed: () {
                onLanguageButtonPressed(context,'ar');
              },
              height: ButtonsDesign.buttonsHeight,
              shape: StadiumBorder(),
              child: ButtonsDesign.buttonsText('عربي',CustomColors().primaryWhiteColor, 15),
              color: CustomColors().brownColor,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: MaterialButton(
              onPressed: () {
                onLanguageButtonPressed(context,'en');
              },
              height: ButtonsDesign.buttonsHeight,
              shape: StadiumBorder(),
              child: ButtonsDesign.buttonsText('english',CustomColors().primaryWhiteColor, 15),
              color: CustomColors().primaryGreenColor,
            ),
          ),
        ],
      ),
    );
  }
}
