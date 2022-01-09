import 'package:flutter/material.dart';
import 'package:khudrah_companies/pages/contact_us.dart';
import 'package:khudrah_companies/pages/edit_profile.dart';
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
      case editInfoRoute:
        return MaterialPageRoute(builder: (_) => EditProfile());
      case contactUs:
        return MaterialPageRoute(builder: (_) => ContactUs());
      default:
        return MaterialPageRoute(builder: (_) => LanguagePage());
    }
  }
}
