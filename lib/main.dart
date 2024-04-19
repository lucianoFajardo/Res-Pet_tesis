// ignore_for_file: non_constant_identifier_names, unused_local_variable
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:respet_app/src/bloc/delete_post/delete_post_cubit.dart';
import 'package:respet_app/src/bloc/edit_post/edit_post_cubit.dart';
import 'package:respet_app/src/bloc/get_data/data_user/get_all_post_user_cubit.dart';
import 'package:respet_app/src/bloc/get_data/user_information/get_user_information_cubit.dart';
import 'package:respet_app/src/bloc/login/login_cubit.dart';
import 'package:respet_app/src/bloc/new_post/new_post_cubit.dart';
import 'package:respet_app/src/bloc/new_post_perdida/new_post_perdida_cubit.dart';
import 'package:respet_app/src/bloc/register/register_cubit.dart';
import 'package:respet_app/src/bloc/register_metadata/register_metadata_cubit.dart';
import 'package:respet_app/src/routers/routers.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:respet_app/src/views/setting/account_view.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/services.dart';
import 'src/bloc/get_data/data_post_all/get_all_data_pets_cubit.dart';
import 'src/bloc/get_data/data_post_filter/get_data_filter_pets_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
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
  final getUserInformationCubit = GetUserInformationCubit();
  
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LoginCubit()),
        BlocProvider(create: (_) => RegisterCubit()),
        BlocProvider(create: (_) => NewPostCubit()),
        BlocProvider(create: (_) => NewPostPerdidaCubit()),
        BlocProvider(create: (_) => EditPostCubit()),
        BlocProvider(create: (_) => OperationCrudCubit()),
        BlocProvider(create: (_) => GetDataFivePetsCubit()),
        BlocProvider(create: (_) => GetAllPostUserCubit()),
        BlocProvider(create: (_) => RegisterMetadataCubit()),
        BlocProvider(create: (_) => DeletePostCubit()),
        BlocProvider(
          create: (context) => getUserInformationCubit,
          child: ViewAccount()
        ),
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
