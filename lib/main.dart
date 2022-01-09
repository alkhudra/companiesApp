import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'package:khudrah_companies/router/custom_route.dart';
import 'package:khudrah_companies/router/route_constants.dart';

import 'helpers/pref/shared_pref_helper.dart';

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
  const MyApp({Key? key ,}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: CustomColors().primaryGreenColor,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
      onGenerateRoute: CustomRouter.generatedRoute,
      theme: ThemeData(accentColor: CustomColors().primaryGreenColor),

      initialRoute: homeRoute,
      //getRout(),
    );

  }
  String getRout() {
    String routName;

    if (PreferencesHelper.isUserFirstLogIn()!)
      routName = languageRoute;
   else if (PreferencesHelper.isUserLoggedIn()!)
      routName = homeRoute;
    else if (PreferencesHelper.isUserLoggedOut()!)
      routName = welcomeRoute;
    else
      routName = welcomeRoute;
    return routName;
  }
}
