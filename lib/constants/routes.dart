import 'package:flutter/material.dart';
import 'package:authapp/ui/ui.dart';
import 'package:authapp/ui/auth/auth.dart';

class Routes {
  Routes._();
  static const String signin = '/signin';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String settings = '/settings';
  static const String resetPassword = '/reset-password';
  static const String updateProfile = '/update-profile';

  static final routes = <String, WidgetBuilder>{
    home: (BuildContext context) => HomeUI(),
    signin: (BuildContext context) => SignInUI(),
    signup: (BuildContext context) => SignUpUI(),
    settings: (BuildContext context) => SettingsUI(),
    //resetPassword: (BuildContext context) => ResetPasswordUI(),
    //updateProfile: (BuildContext context) => UpdateProfileUI(),
  };
}
