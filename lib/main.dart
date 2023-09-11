// ignore_for_file: non_constant_identifier_names, unused_local_variable
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:respet_app/src/bloc/bloc_login/login_bloc.dart';
import 'package:respet_app/src/routers/routers.dart';

Future<void> main() async{
  //TODO: Despues agregar la conexion con la base de datos supabase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  //TODO : Ya instale flutter_supabase
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LoginBloc())
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter pet rest',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          initialRoute: Routers.initialRoute,
          routes: Routers.routes,
          onGenerateRoute: Routers.onGenerateRoutesProvider),
    );
  }
}
