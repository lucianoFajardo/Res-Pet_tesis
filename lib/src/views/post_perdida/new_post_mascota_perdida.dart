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
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {},
        ),
        foregroundColor: Colors.blue,
        backgroundColor: Colors.grey[300],
        title: const Text("Mascota Perdida"),

        //*Boton
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 11),
            child: ElevatedButton(
              onPressed: null,
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 10),
              ),
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'publicar',
                  style: TextStyle(fontSize: 17),
                ),
              ),
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
                  border: Border.all(width: 8, style: BorderStyle.solid)),
              child: Image.network(
                  "https://d1bvpoagx8hqbg.cloudfront.net/259/eb0a9acaa2c314784949cc8772ca01b3.jpg"),
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
                      border: UnderlineInputBorder(),
                      hintText: "Describe a la Mascota"),
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
                      hintText: "Nombre...(si esque tiene collar)"),
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
                      hintText: "Peso en Kilos..(Aproximado)"),
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
                      hintText: "Edad...(Aproximado)"),
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
                  "Donde lo Encontraste",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.blue,
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

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
