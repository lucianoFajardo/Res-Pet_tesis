// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:respet_app/src/bloc/login/login_cubit.dart';

class HomeViewPage extends StatefulWidget {
  const HomeViewPage({super.key});

  @override
  State<HomeViewPage> createState() => _HomeViewPageState();
}

class _HomeViewPageState extends State<HomeViewPage> {
  @override
  Widget build(BuildContext context) {
    final _loginCubitState = BlocProvider.of<LoginCubit>(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text("home page"),
        ),
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
                Text("Hola usuario"),
                Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Center(
                      child: MaterialButton(
                        height: 50,
                        color: Colors.amber,
                        onPressed: () {
                          _loginCubitState.SingOut();
                        },
                        child: const Text(
                          'SingOut',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    )),
              ],
            ));
          },
        ));
  }
}
