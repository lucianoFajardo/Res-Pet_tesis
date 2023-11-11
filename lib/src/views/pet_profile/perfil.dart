import 'package:flutter/material.dart';
import 'package:respet_app/src/models/data_pet.dart';

class PerfilViewData extends StatelessWidget {
  const PerfilViewData({super.key, required this.dataPetGet});

  final data_pet dataPetGet;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            height:
                350, //TODO -> verificar si todas las imagenes se pueden renderizar y ver de buena manera sino cambiar este atributo
            width: double.infinity,
            child: Image.network(
              "https://images.dog.ceo/breeds/akita/512px-Akita_inu.jpg",
              fit: BoxFit.contain,  // ! con cover puedo hacer que toda la imagen se quede en el cuadrado y ocupe todo el ancho y alto de la caja
              alignment: Alignment.center,
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  dataPetGet.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 35),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  dataPetGet.gender ? Icons.male : Icons.female,
                  color: dataPetGet.gender ? Colors.blue : Colors.pink,
                  size: 55.0,
                ),
              )
            ],
          ),
          Row(children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.location_on,
                color: Colors.grey,
                size: 30,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(dataPetGet.location),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.blue,
                width: 90,
                height: 25,
                alignment: Alignment.center,
                child: Text(
                  'estado',
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
                      child: Text(dataPetGet.years))),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      color: const Color.fromARGB(255, 0, 136, 248),
                      width: 113,
                      height: 50,
                      alignment: Alignment.center,
                      child: const Text(
                        "COLOR : cafe",
                      ))),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.blue,
                  width: 113,
                  height: 50,
                  alignment: Alignment.center,
                  child: const Text(
                    "KILOS : 10 kg",
                  ),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'HISTORIA',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              dataPetGet.id_pet,
              style: const TextStyle(fontSize: 15),
            ),
          ),
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(5),
                child: CircleAvatar(
                  backgroundColor: Colors.green,
                  radius: 30,
                  child: Icon(
                    Icons.person_sharp,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Text(
                  dataPetGet.nameUser,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              TextButton(
                onPressed: () {},
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 121, 223, 124),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(
                                color: Color.fromARGB(255, 94, 218, 98))))),
                child: const Text(
                  'CONTACTAR',
                  style: TextStyle(fontSize: 22),
                ),
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
                  child: const Text(
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
                  child: const Text(
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
                  child: const Text(
                    "TAMAÑO",
                  ),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Cuidados Especificos',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
                'AQUI HIRIA LOS CUIDADOS ESPECIFICOS DE LA MASCOTA, SI ESQUE UTILIZA ALGUN TIPO DE COMIDA O TIENE ENFERMEDASDES O POSEE ALERGIAS Y COSAS '),
          )
        ],
      )),
    );
  }
}
