import 'package:flutter/material.dart';
import 'package:respet_app/src/routers/routers.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  //TODO : Ya instale flutter_supabase
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter pet rest',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: Routers.initialRoute,
      routes: Routers.routes,
      onGenerateRoute: Routers.onGenerateRoutesProvider
    );
  }
}
