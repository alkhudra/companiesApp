import 'package:flutter/material.dart';
import 'package:khudrah_companies/designs/ButtonsDesign.dart';
import 'package:khudrah_companies/designs/brand_name.dart';
import 'package:khudrah_companies/pages/welcome_page.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'package:easy_localization/easy_localization.dart';

class LanguagePage extends StatefulWidget {
  @override
  _LanguagePageState createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {


  void onLanguageButtonPressed(BuildContext context , String localeName) async{


    if(localeName == 'en')
      await context.setLocale(Locale('en'));
    else   await context.setLocale(Locale('ar'));

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return WelcomePage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                child: ButtonsDesign.buttonsText('عربي',CustomColors().primaryWhiteColor),
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
                child: ButtonsDesign.buttonsText('english',CustomColors().primaryWhiteColor),
                color: CustomColors().primaryGreenColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
