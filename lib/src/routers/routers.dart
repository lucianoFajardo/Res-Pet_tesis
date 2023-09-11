import 'package:flutter/material.dart';
import 'package:respet_app/src/views/home/home_view.dart';
import 'package:respet_app/src/views/login/login_view.dart';
import 'package:respet_app/src/views/register/register_view.dart';

class Routers {
  static const initialRoute = 'login';

  static Map<String, Widget Function(BuildContext)> routes = {
    'login': (context) => const LoginView(),
    'register': (context) => const RegisterView(),
    'home_view':(context) => const HomeViewPage(),
  };

  static Route<dynamic> onGenerateRoutesProvider(RouteSettings) {
    return MaterialPageRoute(builder: (context) => const LoginView());
  }
}
