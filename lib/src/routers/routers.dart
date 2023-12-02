import 'package:flutter/material.dart';
// import 'package:respet_app/src/views/example/examplepruebaPubli.dart.lk';
import 'package:respet_app/src/views/home/home_view.dart';
import 'package:respet_app/src/views/login/login_view.dart';
import 'package:respet_app/src/views/new_post/new_post_view.dart';
import 'package:respet_app/src/views/new_post/view_all_post.dart';
import 'package:respet_app/src/views/register/register_account.dart';
import 'package:respet_app/src/views/register/register_data_user.dart';
import 'package:respet_app/src/views/setting/account_view.dart';
import 'package:respet_app/src/views/setting/publications_view.dart';
import 'package:respet_app/src/views/setting/settings_view.dart';
import 'package:respet_app/src/views/splashScreen/splash_screen.dart';

class Routers {
  static const initialRoute = 'splash_screen';
  static Map<String, Widget Function(BuildContext)> routes = {
    'login': (context) => const LoginView(),
    'register': (context) => const RegisterAccount(),
    'register_data_user': (context) => const RegisterDataUser(), 
    'home_view': (context) => const HomeViewPage(),
    'splash_screen': (context) => const SplashScreeen(),
    'new_post': (contex) => const NewPostView(),
    'settings': (context) => const SettingPageUI(),
    //'example': (context) => const HomePagePrueba(),
    'view_all_post':(context) => const ViewAllPostPets(),
    'view_account':(context) => const ViewAccount(),
    'view_my_publications':(context) => const ViewPublications(),
  };

  static Route<dynamic> onGenerateRoutesProvider(RouteSettings) {
    return MaterialPageRoute(builder: (context) => const LoginView());
  }
}
