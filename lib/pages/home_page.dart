import 'package:flutter/material.dart';
import 'package:khudrah_companies/designs/ButtonsDesign.dart';
import 'package:khudrah_companies/designs/brand_name.dart';
import 'package:khudrah_companies/locale/language_const.dart';
import 'package:khudrah_companies/pages/welcome_page.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

/*  void _changeLanguage(Language language) async {
    Locale _locale = await setLocale(language.languageCode);
    MyApp.setLocale(context, _locale);
  }*/

  void _showSuccessDialog() {
    showTimePicker(context: context, initialTime: TimeOfDay.now());
  }

  void onLanguageButtonPressed(String localeName){
    //todo: edit locale problem

    print(getTranslated(context, 'personal_information'));

    // direct to login or sign up page

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
                  onLanguageButtonPressed('ar');
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
                  onLanguageButtonPressed('ar');
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
