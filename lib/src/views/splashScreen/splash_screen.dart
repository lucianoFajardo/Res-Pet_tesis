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
    Future.delayed(const Duration(seconds: 2), () {
      if (userPersistence) {
        Navigator.pushReplacementNamed(context, 'home_view');
      } else {
        Navigator.pushReplacementNamed(context, 'login');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
