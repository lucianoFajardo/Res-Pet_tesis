import 'package:flutter/material.dart';
import 'package:respet_app/src/views/home/app_bar.dart';
import 'package:respet_app/src/views/home/builder_body_home.dart';

class HomeViewPage extends StatefulWidget {
  const HomeViewPage({super.key});
  @override
  State<HomeViewPage> createState() => _HomeViewPageState();
}

class _HomeViewPageState extends State<HomeViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarView(),
        body: Column(
          children: [
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
              padding: const EdgeInsets.all(4),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      textAlign: TextAlign.right,
                      'New Post',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'view_all_post');
                        },
                        child: const Text(
                          textAlign: TextAlign.right,
                          'ver mas..',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      )),
                ],
              ),
            ),
            const Expanded(child: GridC()),
            const Padding(
              padding: EdgeInsets.all(5.0),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      textAlign: TextAlign.right,
                      'Mascota perdida',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.only(right: 15),
                    child: Text(
                      textAlign: TextAlign.right,
                      'ver mas..',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
            const Flexible(child: GridC()),
          ],
        ));
  }
}
