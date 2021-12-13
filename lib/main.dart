import 'dart:ffi';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
  Locale locale;//Locale().languageCode;
  void setLocale(Locale value) {
    setState(() {
      locale = value;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text(AppLocalizations.of(context)!.helloWorld),
              TextButton(
                  child: Text(
                      "english".toUpperCase(),
                      style: TextStyle(fontSize: 14)
                  ),
                  style: ButtonsDesign.roundedButtons(),

              ),

              ButtonsDesign.buttonsTextAction(

                "ff"
              );


            ],
          ),

        ),

      ),
    );
  }
}
