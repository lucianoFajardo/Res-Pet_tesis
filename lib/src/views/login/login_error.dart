import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginEroor extends StatefulWidget {
  const LoginEroor({super.key});

  @override
  State<LoginEroor> createState() => _LoginEroorState();
}

class _LoginEroorState extends State<LoginEroor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 130.0),
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 70.0,
                backgroundColor: Colors.grey,
                backgroundImage: AssetImage('images/wifi.2.png'),
              ),
              Text(
                'Revise su estado de',
                style: TextStyle(fontFamily: 'italic', fontSize: 30.0),
              ),
              Text(
                'la red a internet',
                style: TextStyle(fontFamily: 'italic', fontSize: 30.0),
              )
            ],
          ),
        ],
      ),
    );
  }
}
