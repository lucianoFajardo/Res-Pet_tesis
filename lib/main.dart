// ignore_for_file: non_constant_identifier_names, unused_local_variable
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:respet_app/src/bloc/login/login_cubit.dart';
import 'package:respet_app/src/bloc/register/register_cubit.dart';
import 'package:respet_app/src/routers/routers.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  String url = dotenv.env['SUPABASE_URL'] ?? "not found URL";
  String supabaseKey = dotenv.env['SUPABASE_KEY'] ?? "not found KEY";
  await Supabase.initialize(
    url: url,
    anonKey: supabaseKey,
  );
  runApp(const MyApp());
}

final client = Supabase.instance.client;
final userPersistence = client.auth.currentSession != null;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LoginCubit()),
        BlocProvider(create: (_) => RegisterCubit()),],
      
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
