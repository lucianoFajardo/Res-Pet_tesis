// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:respet_app/main.dart';

class HomeViewPage extends StatefulWidget {
  const HomeViewPage({super.key});

  @override
  State<HomeViewPage> createState() => _HomeViewPageState();
}

class _HomeViewPageState extends State<HomeViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("home page"),
        ),
        body: Scaffold(
            body: Column(
          children: [
            Text("Hola usuario"),
            Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Center(
                  child: MaterialButton(
                    height: 50,
                    color: Colors.amber,
                    onPressed: () async {
                      try {
                        await client.auth.signOut();
                        Navigator.of(context).pushReplacementNamed('login');
                      } catch (e) {
                        print("error singOut: ${e}");
                      }
                    },
                    child: const Text(
                      'SingOut',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                )),
          ],
        )));
  }
}
