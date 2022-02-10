import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:khudrah_companies/pages/auth/login_page.dart';
import 'package:khudrah_companies/pages/branch/add_brunches_page.dart';
import 'package:khudrah_companies/pages/dashboard.dart';
import 'package:khudrah_companies/pages/home_page.dart';
import 'package:khudrah_companies/pages/language/language_page.dart';
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

Future init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static  bool isUserFirstLogin=false;
  static  bool isUserLoggedIn=true;
  @override
  void initState() {
    super.initState();
    setValues();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: CustomColors().primaryGreenColor,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
      routes: routMap,
      theme: ThemeData(
        fontFamily: 'Almarai',
        accentColor: CustomColors().primaryGreenColor,
        primarySwatch: Colors.green,
      ),
      home: getRout(),
    );
  }

  Widget getRout() {

    print(isUserFirstLogin);

    if (isUserFirstLogin == false && isUserLoggedIn == true)
      return DashboardPage();
    if (isUserFirstLogin == false && isUserLoggedIn == false)
      return LogInPage();
    else
      return LanguagePage();
  }

  setValues() async {
    isUserFirstLogin = await PreferencesHelper.getIsUserFirstLogIn;
    isUserLoggedIn = await PreferencesHelper.getIsUserLoggedIn;
  }
}
