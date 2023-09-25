import 'package:flutter/material.dart';
import 'package:respet_app/src/views/home/home_view.dart';
import 'package:respet_app/src/views/login/login_view.dart';
import 'package:respet_app/src/views/register/register_view.dart';
import 'package:respet_app/src/views/setting/settings_view.dart';
import 'package:respet_app/src/views/splashScreen/splash_screen.dart';

class Routers {
  static const initialRoute = 'splash_screen';
  static Map<String, Widget Function(BuildContext)> routes = {
    'login': (context) => const LoginView(),
    'register': (context) => const RegisterView(),
    'home_view': (context) => const HomeViewPage(),
    'splash_screen': (context) => const SplashScreeen(),
    'settings':(context) => const SettingPageUI(),
  };

  static Route<dynamic> onGenerateRoutesProvider(RouteSettings) {
    return MaterialPageRoute(builder: (context) => const LoginView());
  }
}
