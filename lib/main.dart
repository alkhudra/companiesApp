import 'package:easy_localization/easy_localization.dart';
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

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
static  bool isUserFirstLogin =true;
static  bool isUserLoggedIn =false;

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
        accentColor: CustomColors().primaryGreenColor,
        primarySwatch: Colors.green,
      ),
      home:getRout() ,
    );
  }

  Widget getRout(){
    PreferencesHelper.setUserFirstLogIn(true);
    PreferencesHelper.getIsUserFirstLogIn.then((value) {
      isUserFirstLogin = value;
    });
    PreferencesHelper.getIsUserLoggedIn.then((value) {
      isUserLoggedIn = value;

    });
    print(isUserFirstLogin);
    if(isUserFirstLogin == true && isUserLoggedIn == false)
    return LanguagePage();
    if(isUserFirstLogin == false && isUserLoggedIn == true)
     return DashboardPage();
    if(isUserFirstLogin == false && isUserLoggedIn == false)
      return LogInPage();
    else  return LanguagePage();
  }

}
