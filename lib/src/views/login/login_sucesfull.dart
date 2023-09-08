//import 'package:flutter/cupertino.dart';
// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

class LoginSucesFull extends StatelessWidget {
  const LoginSucesFull({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 130.0),
        children: const <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 70.0,
                backgroundColor: Colors.grey,
                backgroundImage: AssetImage('images/Pulgar.arriba.2.png'),
              ),
              Text(
                'Registro Exitoso',
                style: TextStyle(fontFamily: 'italic', fontSize: 35.0),
              ),
              Divider(
                height: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
