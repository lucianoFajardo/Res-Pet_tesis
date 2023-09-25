// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:respet_app/src/bloc/login/login_cubit.dart';
import 'package:respet_app/src/views/home/app_bar.dart';

class HomeViewPage extends StatefulWidget {
  const HomeViewPage({super.key});

  @override
  State<HomeViewPage> createState() => _HomeViewPageState();
}

class _HomeViewPageState extends State<HomeViewPage> {
  @override
  Widget build(BuildContext context) {
    //final _loginCubitState = BlocProvider.of<LoginCubit>(context);

    return Scaffold(
        appBar: AppBarView(),
        body: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is ErrorExitUser) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.exitUser.toString()),
                  duration: Duration(seconds: 3)));
            }
            if (state is LoginExitSuccesfull) {
              Navigator.pop(context, 'login');
            }
          },
          builder: (context, state) {
            if (state is LoginLoading) {
              Center(
                child: CircularProgressIndicator(),
              );
            }
            return Scaffold(
                body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextField(
                    textCapitalization: TextCapitalization.words,
                    enableInteractiveSelection: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Ingresar busqueda",
                      icon: Icon(Icons.search),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: MaterialButton(
                    height: 50,
                    color: Colors.amber,
                    onPressed: () {},
                    child: const Text(
                      'subir imagen',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    'categoria',
                    style: TextStyle(),
                  ),
                ),
                Row(
                  children: [
                    Card(
                      color: Colors.red,
                      child: Text('tarjeta de animales'),
                    ),
                                        Card(
                      color: Colors.red,
                      child: Text('tarjeta de animales'),
                    ),
                                        Card(
                      color: Colors.red,
                      child: Text('tarjeta de animales'),
                    ),
                                        Card(
                      color: Colors.red,
                      child: Text('tarjeta de animales'),
                    ),
                  ],
                )
              ],
            ));
          },
        ));
  }
}
