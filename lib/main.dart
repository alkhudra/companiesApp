import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:khudrah_companies/router/custom_route.dart';
import 'package:khudrah_companies/router/route_constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
        supportedLocales: [Locale('en'), Locale('ar')],
        path: 'assets/locale/lang',
        fallbackLocale: Locale('en'),
        child: MyApp()),
  );
}

class MyApp extends StatefulWidget {
  // Locale _locale;
  //const MyApp({ Key key}) : super(key: key);
/*  static void setLocale(BuildContext context, Locale newLocale) {

    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state!.setLocale(newLocale);
  }*/

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flutter Localization Demo",
/*
        theme: ThemeData(primarySwatch: CustomColors().primaryGreenColor),
*/
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
      onGenerateRoute: CustomRouter.generatedRoute,

      /************
       * if first time in app show language page
       * if already login show home page
       * if logout show welcome page without language page
       * **********/
      initialRoute: homeRoute,
    );
    //  }
  }
}

