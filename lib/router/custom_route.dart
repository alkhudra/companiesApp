import 'package:flutter/material.dart';
import 'package:khudrah_companies/pages/contact_us.dart';
import 'package:khudrah_companies/pages/dashboard.dart';
import 'package:khudrah_companies/pages/account/edit_profile.dart';
import 'package:khudrah_companies/pages/home_page.dart';
import 'package:khudrah_companies/pages/language/language_page.dart';
import 'package:khudrah_companies/pages/auth/login_page.dart';
import 'package:khudrah_companies/pages/auth/sign_up_page.dart';
import 'package:khudrah_companies/pages/welcome_page.dart';
import 'package:khudrah_companies/router/route_constants.dart';


class CustomRouter {
  static Route<dynamic> generatedRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginRoute:
        return MaterialPageRoute(builder: (_) => LogInPage());
      case signupRoute:
        return MaterialPageRoute(builder: (_) => SignUpPage());
      case languageRoute:
        return MaterialPageRoute(builder: (_) => LanguagePage());
      case welcomeRoute:
        return MaterialPageRoute(builder: (_) => WelcomePage());
      default:
        return MaterialPageRoute(builder: (_) => DashboardPage());
/*      case homeRoute:
        return MaterialPageRoute(builder: (_) => DashboardPage());
      default:
        return MaterialPageRoute(builder: (_) => DashboardPage());*/
    }
  }
}
