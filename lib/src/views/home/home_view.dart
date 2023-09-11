import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:respet_app/src/Models/user_model.dart';
import 'package:respet_app/src/bloc/login_bloc/login_bloc.dart';

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
      body: BlocBuilder<LoginBloc, LoginState>(builder: (_, state) {
        return state.existUser
            ? homepageView(user: state.user!)
            : Column(
                children: [
                  const Text("no existe data para mostrar"),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                      color: Colors.blue,
                      onPressed: () {
                        final userSend = User(
                            name: "luciano@gmail.com",
                            pass: "123456789");
                        //! dentro de este boton puedo llamara a las funciones que se necesitan para ocupar la data ejemplo seria pasar los campos que necesito renderizar como nombre y estado
                        BlocProvider.of<LoginBloc>(context, listen: false)
                            .add(LoginInWithEmailButtonPressed(user: userSend));
                      },
                      child: const Text(
                        'Inicializar data',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  )
                ],
              );
      }),
    );
  }
}

class homepageView extends StatelessWidget {
  const homepageView({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(title: Text("nombre : ${user.name}")),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(title: Text("pass : ${user.pass}")),
        ),

        const Text("Estoy en el home")
      ],
    );
  }
}