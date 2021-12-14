import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'package:khudrah_companies/router/custom_route.dart';
import 'package:khudrah_companies/router/route_constants.dart';
import 'designs/ButtonsDesign.dart';
import 'locale/demo_localization.dart';
import 'locale/language_const.dart';

void main() {

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
 // Locale _locale;
  //const MyApp({ Key key}) : super(key: key);
  static void setLocale(BuildContext context, Locale newLocale) {

    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state!.setLocale(newLocale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale  _locale = Locale('en');
  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        this._locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
/*
    if (this._locale == null) {
      return Container(
          child: Center(
        child: CircularProgressIndicator(
          color: CustomColors().primaryGreenColor,
        ),
      ));
    } else {*/
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Flutter Localization Demo",
        theme: ThemeData(primarySwatch: Colors.blue),
        locale: _locale,
        supportedLocales: [
          Locale("en", "US"),
          Locale("ar", "SA"),
        ],
        localizationsDelegates: [
          DemoLocalization.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale!.languageCode &&
                supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        }/*,
        home: Scaffold(
            body: Center(
          child: SafeArea(
            child: Container(

              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
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
                      print(getTranslated(context, 'personal_information'));
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
                      print(getTranslated(context, 'personal_information'));
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
        ))*/,
        onGenerateRoute: CustomRouter.generatedRoute,
        initialRoute: homeRoute,
      );
  //  }
  }
}
/*
Widget LanguagePage () {
    return Scaffold(
        body: Center(
          child: SafeArea(
            child: Container(
              height: MediaQuery.of(context).size.height / 3,
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
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
  }*/

/*

class MyApp extends StatelessWidget {
  static void setLocale(BuildContext context, Locale newLocale) {
    _LanguagePageState? state =
        context.findAncestorStateOfType<_LanguagePageState>();
    state!.setLocale(newLocale);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _locale,
      supportedLocales: [
        Locale("en", "US"),
        Locale("ar", "SA"),
      ],
      localizationsDelegates: [
        DemoLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale!.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      home: LanguagePage(),
    );
  }
}


class _LanguagePageState extends State<LanguagePage> {

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        this._locale = locale;
      });
    });
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height / 3,
          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
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
*/
