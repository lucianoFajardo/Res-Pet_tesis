import 'package:flutter/material.dart';
import 'package:respet_app/src/models/data_pet.dart';

class PerfilViewData extends StatelessWidget {
  const PerfilViewData({super.key, required this.dataPetGet});

  final data_pet dataPetGet;
  //TODO -> realizar una funcion que evalua si el sexo es masculino o femenino

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
            height: 350,
            width: double.infinity,
            child: Image.network(
              dataPetGet.id_photo_pet,
              fit: BoxFit.contain,
              alignment: Alignment.center,
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  dataPetGet.name_pet,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 35),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.female,
                  color: Colors.pink,
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
              child: Text("Ciudad de ${dataPetGet.location}"),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
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
                      child: Text("${dataPetGet.age_pet.toString()} años"))),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      color: const Color.fromARGB(255, 0, 136, 248),
                      width: 113,
                      height: 50,
                      alignment: Alignment.center,
                      child: Text(
                        "Pelaje ${dataPetGet.fur_color}",
                      ))),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.blue,
                  width: 113,
                  height: 50,
                  alignment: Alignment.center,
                  child: Text("${dataPetGet.weight_pet} kilos"),
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
              dataPetGet.description_pet,
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
              SizedBox(
                width: 150,
                child: Text(
                  dataPetGet.nameUser,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              TextButton(
                onPressed: () {
                  print(dataPetGet.celphoneUser);
                },
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
                padding: const EdgeInsets.all(10),
                child: Container(
                  color: Colors.blue,
                  width: 113,
                  height: 50,
                  alignment: Alignment.center,
                  child: Text(dataPetGet.vaccines_pet),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    color: Colors.blue,
                    width: 113,
                    height: 50,
                    alignment: Alignment.center,
                    child: dataPetGet.is_sterilization
                        ? const Text('Mascota esterilizada')
                        : const Text('Mascota no esterilizada')),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.blue,
                  width: 113,
                  height: 50,
                  alignment: Alignment.center,
                  child: Text("${dataPetGet.size_pet.toString()} cm"),
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(dataPetGet.specific_care),
          )
        ],
      )),
    );
  }
}
