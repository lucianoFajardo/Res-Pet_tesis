// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, no_leading_underscores_for_local_identifiers, deprecated_member_use
import 'package:flutter/material.dart';
import 'package:respet_app/main.dart';
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
                  onPressed: () {
                    Navigator.pushNamed(context, 'new_post');
                  },
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

//TODO -> publicaciones en este apartado

class _GridCState extends State<GridC> {
  Color _isButtonColor = Colors.grey;
  bool _isFavorite = true;
  List dataList = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  void _isFunctionFavorite() {
    setState(() {
      if (_isFavorite) {
        _isButtonColor = Colors.red;
        print('Agregar a lista de favoritos');
      } else {
        _isButtonColor = Colors.grey;
        print('eliminar de la lista de favoritos');
      }
      _isFavorite = !_isFavorite;
    });
  }

  Future<dynamic> getData() async {
    try {
      // final response = await client.from('countries').select('*').execute();
      final resdata = await client.from('public_pets').select('*').execute();
      final data = resdata.data as List;
      print(data);
      setState(() {
        dataList = data;
      });
      return data;
    } catch (e) {
      print('Error al obtener datos: ${e}');
    }
  }

//TODO -> revisar mañana el tema de la lectura de datos la idea es que si tiene datos me tiene que imprimir por consola el nombre del perro

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        mainAxisExtent: 120, //! this part is a height
      ),
      itemCount: 2,
      itemBuilder: (_, index) {
        //print(index);
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              12.0,
            ),
            color: Colors.amberAccent.shade700,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
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
                padding: const EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${dataList[index]['name']}",
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      "${dataList[index]['location']}",
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      "${dataList[index]['isAdopted']}",
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
                    Expanded(
                      
                      child: Align(
                        alignment: Alignment.topRight,
                        child: CircleAvatar(
                            backgroundColor: _isButtonColor,
                            child: IconButton(
                              icon: Icon(Icons.favorite),
                              onPressed:
                                  _isFunctionFavorite, //TODO : -> revisar esta funcion para tomar los indices que tengo y solo agregar el que yo seleccione.
                              color: Colors.white,
                            )),
                      ),
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


/**
 *               Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2),
                      child: CircleAvatar(
                          backgroundColor: _isButtonColor,
                          child: IconButton(
                            icon: Icon(Icons.favorite),
                            onPressed:
                                _isFunctionFavorite, //TODO : -> revisar esta funcion para tomar los indices que tengo y solo agregar el que yo seleccione.
                            color: Colors.white,
                          )),
                    ),
                    CircleAvatar(
                        backgroundColor: Colors.pink.shade300,
                        child: Icon(Icons.female)),
                  ],
                ),
              )
 */