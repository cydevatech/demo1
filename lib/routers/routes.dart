// ignore_for_file: unnecessary_null_in_if_null_operators

import 'package:demo1/screens/login/login_screen.dart';
// import 'package:demo1/screens/login/test.dart';
import 'package:demo1/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';

RouteFactory routes() {
  return (RouteSettings settings) {
    Widget screen = const SizedBox();

    var name = settings.name;

    switch (name) {
      case RouterName.initScreen:
        screen = const SplashScreen();
        break;
      case RouterName.loginScreen:
        screen = const LoginScreen();
        break;
      default:
        screen = const SplashScreen();
    }

    return MaterialPageRoute(
      settings: settings,
      builder: (context) => screen,
    );
  };
}

abstract class RouterName {
  static const String initScreen = '/';
  static const String loginScreen = '/login';
  static const String dashboardScreen = '/dashboard';
}
