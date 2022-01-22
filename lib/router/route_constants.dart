import 'package:flutter/cupertino.dart';
import 'package:khudrah_companies/pages/auth/login_page.dart';
import 'package:khudrah_companies/pages/dashboard.dart';

const String homeRoute = "home";
const String aboutRoute = "about";
const String settingsRoute = "settings";
const String loginRoute = "login";
const String signupRoute = "signup";
const String welcomeRoute = "welcome";
const String languageRoute = "language";
const String noPage="noPage";
const String editInfoRoute="editInfo";
const String mainRoute="mainRoute";
const String contactUs="contactUs";
const String dashBoardRoute="dashBoard";

final Map<String, WidgetBuilder> routMap = {
 loginRoute: (BuildContext context) => new LogInPage(),
  dashBoardRoute: (BuildContext context) => new DashboardPage(),
};