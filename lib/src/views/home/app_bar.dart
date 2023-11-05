// ignore_for_file: avoid_print, non_constant_identifier_names
import 'package:flutter/material.dart';

AppBarView(){
  return AppBar(
    leading: Builder(
      builder: (BuildContext context) {
        return IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            Navigator.pushNamed(context, "settings");
          },
        );
      },
    ),
    title: const Text('Menu'),
    actions: <Widget>[
      IconButton(
        icon: const Icon(Icons.notifications_sharp),
        onPressed: () => print('open notifications'),
      ),
    ],
  );
}
