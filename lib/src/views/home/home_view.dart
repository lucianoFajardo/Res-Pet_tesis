// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
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
        body: Scaffold(
            body: SingleChildScrollView(
          child: Column(
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
              Padding(
                padding: EdgeInsets.all(8.0),
                child: GridB(),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Nuevo post"),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: GridC(),
              ),
              //Padding(padding: EdgeInsets.all(8.0),child: GridB(),),
            ],
          ),
        )));
  }
}

class GridB extends StatefulWidget {
  const GridB({Key? key}) : super(key: key);

  @override
  State<GridB> createState() => _GridBState();
}

class _GridBState extends State<GridB> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        mainAxisExtent: 120, //! this part is a height
      ),
      itemCount: 4,
      itemBuilder: (_, index) {
        return InkWell(
          highlightColor: Colors.blue.withOpacity(0.4),
          borderRadius: BorderRadius.circular(30),
          onTap: () => print('direccion a ${index}'),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                12.0,
              ),
              color: Colors.amberAccent.shade700,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipOval(
                    // borderRadius: BorderRadius.all(Radius.circular(100)),
                    child: Image.network(
                        'https://images.dog.ceo/breeds/spaniel-irish/n02102973_1299.jpg',
                        height: 80),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Center(
                      child: Text(
                    "categoria",
                    style: TextStyle(fontSize: 20),
                  )),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class GridC extends StatefulWidget {
  const GridC({Key? key}) : super(key: key);

  @override
  State<GridC> createState() => _GridCState();
}

class _GridCState extends State<GridC> {
  @override
  Widget build(BuildContext context) {
    bool isFavorite = true;
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        mainAxisExtent: 120, //! this part is a height
      ),
      itemCount: 1,
      itemBuilder: (_, index) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              12.0,
            ),
            color: Colors.amberAccent.shade700,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: ClipRRect(
                  //borderRadius: BorderRadius.all(Radius.circular(60)),
                  child: Image.network(
                      'https://images.dog.ceo/breeds/spaniel-japanese/n02085782_1774.jpg',
                      height: 95),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text(
                      "Nombre de mascota",
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      "Meses de vida",
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      "Localizacion",
                      style: TextStyle(fontSize: 15),
                    ),
                    Container(
                      color: Colors.blue,
                      child: Text(
                        "Estado: Adop , No",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: CircleAvatar(
                          backgroundColor:
                              isFavorite ? Colors.red : Colors.grey,
                          child: IconButton(
                            icon: Icon(Icons.favorite),
                            onPressed: () => {
                              //TODO: Cuando el usuario le de like el corazon debe de estar en rojo pero sino se debe de mostrar en gris.
                              //TODO: Por defecto se debe mostrar como que no esta en favoritos.
                            },
                            color: Colors.white,
                          )),
                    ),
                    CircleAvatar(
                        backgroundColor: Colors.pink.shade300,
                        child: Icon(Icons.female)),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
