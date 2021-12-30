import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'package:khudrah_companies/router/custom_route.dart';
import 'package:khudrah_companies/router/route_constants.dart';

import 'Constant/pref_cont.dart';
import 'helpers/pref_manager.dart';
import 'helpers/shared_pref_helper.dart';

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
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flutter Localization Demo",
      color: CustomColors().primaryGreenColor,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
      onGenerateRoute: CustomRouter.generatedRoute,
      theme: ThemeData(accentColor: CustomColors().primaryGreenColor),
      /************
       * if first time in app show language page
       * if already login show home page
       * if logout show welcome page without language page
       * **********/
      initialRoute: homeRoute/*getRout()*/,
    );
    //  }
  }
/*
  String getRout() {
    //todo: edit problem with shared preference
    String routName;

    if (!SharedPrefsManager.getBool(firstLogin))
      routName = languageRoute;
   else if (!SharedPrefsManager.getBool(isNew))
      routName = signupRoute;
    else if (SharedPrefsManager.getBool(isLoggedIn))
      routName = homeRoute;// change to home
    else
      routName = welcomeRoute;
    return routName;
  }*/
}
