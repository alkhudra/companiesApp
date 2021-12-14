import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'designs/ButtonsDesign.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: LanguagePage(),
    );
  }
}

class LanguagePage extends StatefulWidget {
  @override
  _LanguagePageState createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height / 3,
          padding: EdgeInsets.fromLTRB(20,20,20,0),
          child: Column(
            children: [
              Image(
                height: 100,
                image: AssetImage('images/logo.jpg'),
              ),
              SizedBox(
                height: 15,
              ),
              MaterialButton(
                onPressed: () {
                  print('hello');
                },
                height: ButtonsDesign.buttonsHeight,
                shape: StadiumBorder(),
                child: ButtonsDesign.buttonsText('English'),
                color: CustomColors().primaryGreenColor,
              ),
              SizedBox(
                height: 15,
              ),
              MaterialButton(
                onPressed: () {
                  print('hello');
                },
                height: ButtonsDesign.buttonsHeight,
                shape: StadiumBorder(),
                child: ButtonsDesign.buttonsText('العربية'),
                color: CustomColors().primaryGreenColor,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
