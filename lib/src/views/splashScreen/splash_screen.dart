import 'package:flutter/material.dart';
import 'package:respet_app/main.dart';

class SplashScreeen extends StatefulWidget {
  const SplashScreeen({super.key});

  @override
  State<SplashScreeen> createState() => _SplashScreeenState();
} 
class _SplashScreeenState extends State<SplashScreeen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 5), () {
      if (userPersistence) {
        print('si existe un usuario dentro de la aplicacion');
        Navigator.pushReplacementNamed(context, 'home_view');
      } else {
        print('no existe un usario dentro de la aplicacion');
        Navigator.pushReplacementNamed(context, 'login');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}
