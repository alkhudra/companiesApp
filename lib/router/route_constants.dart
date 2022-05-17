import 'package:flutter/cupertino.dart';
import 'package:khudrah_companies/pages/auth/login_page.dart';
import 'package:khudrah_companies/pages/cart_page.dart';
import 'package:khudrah_companies/pages/dashboard.dart';

import '../main.dart';

const String homeRoute = "home";
const String aboutRoute = "about";
const String cartRoute = "cart";
const String loginRoute = "login";
const String signupRoute = "signup";
const String welcomeRoute = "welcome";
const String languageRoute = "language";
const String noPage = "noPage";
const String editInfoRoute = "editInfo";
const String mainRoute = "mainRoute";
const String contactUs = "contactUs";
const String dashBoardRoute = "dashBoard";
const String branchListRoute = "branchList";

final Map<String, WidgetBuilder> routMap = {
 // mainRoute: (BuildContext context) => new MyApp(),
  loginRoute: (BuildContext context) => new LogInPage(),
  dashBoardRoute: (BuildContext context) => new DashboardPage(),
 cartRoute: (BuildContext context) => new CartPage(),
};
