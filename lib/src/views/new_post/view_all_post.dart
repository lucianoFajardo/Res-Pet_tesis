import 'package:flutter/material.dart';
import 'package:respet_app/src/views/new_post/builder_body_all_data.dart';

class ViewAllPostPets extends StatelessWidget {
  const ViewAllPostPets({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ver todas las publicaciones'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: const ViewDataAllPet(),
    );
  }
}
