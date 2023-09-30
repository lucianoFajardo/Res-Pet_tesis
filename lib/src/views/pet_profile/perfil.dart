import 'package:flutter/material.dart';

class perfil extends StatefulWidget {
  const perfil({super.key});

  @override
  State<perfil> createState() => _perfilState();
}

class _perfilState extends State<perfil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {},
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_horiz),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
              'https://t2.ea.ltmcdn.com/es/razas/2/3/5/pug-o-carlino_532_0_orig.jpg'),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "NOMBRE",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.male,
                  color: Colors.blue,
                  size: 55.0,
                ),
              )
            ],
          ),
          Row(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.location_on,
                color: Colors.transparent,
                size: 20,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text("UBICACION"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.blue,
                width: 90,
                height: 25,
                alignment: Alignment.center,
                child: Text(
                  "ESTADO",
                ),
              ),
            ),
          ]),
          Row(
            children: [
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      color: Colors.blue,
                      width: 113,
                      height: 50,
                      alignment: Alignment.center,
                      child: Text(
                        "EDAD",
                      ))),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      color: Color.fromARGB(255, 0, 136, 248),
                      width: 113,
                      height: 50,
                      alignment: Alignment.center,
                      child: Text(
                        "COLOR",
                      ))),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.blue,
                  width: 113,
                  height: 50,
                  alignment: Alignment.center,
                  child: Text(
                    "KILOS",
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'HISTORIA',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'AQUI IRIA UNA BREVE HISTORIA DEL PERRO QUE CUENTE CON DETALLES SU RESCATE Y CIERTAS COASAS MAS ',
              style: TextStyle(fontSize: 15),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.green,
                  radius: 40,
                  backgroundImage: NetworkImage(
                      "https://static.vecteezy.com/system/resources/previews/008/302/516/original/eps10-green-user-icon-or-logo-in-simple-flat-trendy-modern-style-isolated-on-white-background-free-vector.jpg"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Luciano\n Fajardo',
                  style: TextStyle(fontSize: 21),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'CONTACTAR',
                  style: TextStyle(fontSize: 22),
                ),
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    backgroundColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 121, 223, 124),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                                color: Color.fromARGB(255, 94, 218, 98))))),
              )
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.blue,
                  width: 113,
                  height: 50,
                  alignment: Alignment.center,
                  child: Text(
                    "VACUNAS",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.blue,
                  width: 113,
                  height: 50,
                  alignment: Alignment.center,
                  child: Text(
                    "ESTERELIZADO",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.blue,
                  width: 113,
                  height: 50,
                  alignment: Alignment.center,
                  child: Text(
                    "TAMAÑO",
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Cuidados Especificos',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                'AQUI HIRIA LOS CUIDADOS ESPECIFICOS DE LA MASCOTA, SI ESQUE UTILIZA ALGUN TIPO DE COMIDA O TIENE ENFERMEDASDES O POSEE ALERGIAS Y COSAS '),
          )
        ],
      )),
    );
  }
}
