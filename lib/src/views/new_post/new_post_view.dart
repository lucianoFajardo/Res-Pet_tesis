import 'package:flutter/material.dart';

class NewPostView extends StatefulWidget {
  const NewPostView({super.key});

  @override
  State<NewPostView> createState() => _NewPostViewState();
}

class _NewPostViewState extends State<NewPostView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.deepPurple[600],
        backgroundColor: Colors.grey[300],
        title: const Text("Nueva Publicacion"),

        //*Boton
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 11),
            child: ElevatedButton(
              onPressed: null,
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: const Text(" Publicar "),
            ),
          ),
        ],
      ),

      //*Medio
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            //?Cambiar imagen por una Card
            Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 15, style: BorderStyle.solid)),
              child: Image.network(
                  "https://static.fundacion-affinity.org/cdn/farfuture/PVbbIC-0M9y4fPbbCsdvAD8bcjjtbFc0NSP3lRwlWcE/mtime:1643275542/sites/default/files/los-10-sonidos-principales-del-perro.jpg"),
            ),

            Divider(
                indent: 5, endIndent: 5, thickness: 1, color: Colors.grey[500]),

            ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 300,
              ),
              child: const Padding(
                padding: EdgeInsets.only(left: 5, right: 5),
                child: TextField(
                  maxLines: null,
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(), hintText: "Pie de Foto"),
                ),
              ),
            ),

            const SizedBox(height: 10),

            ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 300,
              ),
              child: const Padding(
                padding: EdgeInsets.only(left: 5, right: 5),
                child: TextField(
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(), hintText: "Nombre"),
                ),
              ),
            ),

            const SizedBox(height: 10),

            ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 300,
              ),
              child: const Padding(
                padding: EdgeInsets.only(left: 5, right: 5),
                child: TextField(
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: "Color del Pelaje"),
                ),
              ),
            ),

            const SizedBox(height: 10),

            ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 300,
              ),
              child: const Padding(
                padding: EdgeInsets.only(left: 5, right: 5),
                child: TextField(
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: "Peso en Kilos"),
                ),
              ),
            ),

            const SizedBox(height: 10),

            ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 300,
              ),
              child: const Padding(
                padding: EdgeInsets.only(left: 5, right: 5),
                child: TextField(
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(), hintText: "Edad"),
                ),
              ),
            ),

            const SizedBox(height: 10),

            ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 300,
              ),
              child: const Padding(
                padding: EdgeInsets.only(left: 5, right: 5),
                child: TextField(
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(), hintText: "Sexo"),
                ),
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Text(
                  "Agregar Ubicacion",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.deepPurple[600],
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 8),

            ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 30,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 6),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 16),
                        backgroundColor: Colors.white60,
                        foregroundColor: Colors.black87,
                        shadowColor: Colors.black,
                      ),
                      child: const Text(" Iquique "),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 16),
                          backgroundColor: Colors.white60,
                          foregroundColor: Colors.black87,
                          shadowColor: Colors.black,
                        ),
                        child: const Text(" Alto Hospicio "),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 16),
                          backgroundColor: Colors.white60,
                          foregroundColor: Colors.black87,
                          shadowColor: Colors.black,
                        ),
                        child: const Text(" ... "),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Divider(
                indent: 5,
                endIndent: 5,
                thickness: 1,
                color: Colors.grey[500],
                height: 30),

            ConstrainedBox(
              constraints: const BoxConstraints(
                minHeight: 50,
              ),
              child: TextButton(
                child: Row(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Vacunas",
                        style: TextStyle(
                            color: Colors.deepPurple[600],
                            fontSize: 19,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: 270),
                    Icon(Icons.arrow_forward_ios_rounded,
                        color: Colors.deepPurple[600]),
                  ],
                ),
                onPressed: () {},
              ),
            ),

            Divider(
                indent: 5,
                endIndent: 5,
                thickness: 1,
                color: Colors.grey[500],
                height: 30),

            ConstrainedBox(
              constraints: const BoxConstraints(
                minHeight: 50,
              ),
              child: TextButton(
                child: Row(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Chip",
                        style: TextStyle(
                            color: Colors.deepPurple[600],
                            fontSize: 19,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: 305),
                    Icon(Icons.arrow_forward_ios_rounded,
                        color: Colors.deepPurple[600]),
                  ],
                ),
                onPressed: () {},
              ),
            ),

            Divider(
                indent: 5,
                endIndent: 5,
                thickness: 1,
                color: Colors.grey[500],
                height: 30),

            ConstrainedBox(
              constraints: const BoxConstraints(
                minHeight: 50,
              ),
              child: TextButton(
                child: Row(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Estirilización",
                        style: TextStyle(
                            color: Colors.deepPurple[600],
                            fontSize: 19,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: 230),
                    Icon(Icons.arrow_forward_ios_rounded,
                        color: Colors.deepPurple[600]),
                  ],
                ),
                onPressed: () {},
              ),
            ),

            Divider(
                indent: 5,
                endIndent: 5,
                thickness: 1,
                color: Colors.grey[500],
                height: 30),

            ConstrainedBox(
              constraints: const BoxConstraints(
                minHeight: 50,
              ),
              child: TextButton(
                child: Row(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Tamaño",
                        style: TextStyle(
                            color: Colors.deepPurple[600],
                            fontSize: 19,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: 270),
                    Icon(Icons.arrow_forward_ios_rounded,
                        color: Colors.deepPurple[600]),
                  ],
                ),
                onPressed: () {},
              ),
            ),

            Divider(
                indent: 5,
                endIndent: 5,
                thickness: 1,
                color: Colors.grey[500],
                height: 30),

            ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 300,
              ),
              child: const Padding(
                padding: EdgeInsets.only(left: 5, right: 5),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    icon: Icon(Icons.phone),
                    hintText: "+56 9 ",
                  ),
                ),
              ),
            ),

            Divider(
                indent: 5,
                endIndent: 5,
                thickness: 1,
                color: Colors.grey[500],
                height: 30),

            SizedBox(
              width: double.infinity,
              child: Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Cuidados Específicos",
                          style: TextStyle(
                              color: Colors.deepPurple[600],
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const TextField(
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                          hintText: "Escriba aqui.",
                        ),
                      ),
                    ],
                  )),
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
