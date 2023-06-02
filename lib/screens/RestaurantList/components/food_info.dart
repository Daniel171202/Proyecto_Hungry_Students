import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rive_animation/core/components/item_tile_vertical.dart';
import '../../../../core/components/item_tile_horizontal.dart';
import '../../../../core/constants/constants.dart';
import 'package:firebase_database/firebase_database.dart';

class FoodnfoPage extends StatefulWidget {
  final String llave;

  const FoodnfoPage({
    Key? key,
    required this.llave,
  }) : super(key: key);

  @override
  State<FoodnfoPage> createState() => _FoodnfoPageState();
}

class _FoodnfoPageState extends State<FoodnfoPage> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        title: Text('Menú'),
        backgroundColor: const Color.fromRGBO(29, 164, 180, 0.996),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppDefaults.padding),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: StreamBuilder(
            stream: FirebaseDatabase.instance
                .ref()
                .child('Comidas/${widget.llave}')
                .onValue,
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
                // Obtiene una lista de Mapas de los datos de Firebase
                List<Map<dynamic, dynamic>> foodsList = [];
                Map<dynamic, dynamic> foods = snapshot.data!.snapshot.value;
                foods.forEach((key, value) {
                  foodsList.add(value);
                });

                // Crea una lista de ItemTileHorizontal a partir de los datos de Firebase
                List<ItemTileVertical> itemTiles = [];
                for (var food in foodsList) {
                  itemTiles.add(
                    ItemTileVertical(
                      foodName: food['name'],
                      description: food['descripcion'],
                      imageUrl: food['imageUrl'],
                      price: food['precio'],
                    ),
                  );
                }

                return Column(
                  children: itemTiles,
                );
              } else if (snapshot.hasError) {
                return const Text('Error al obtener datos de Firebase');
              } else {
                return const Text(
                    'Al parecer el restaurante no tiene platillos aun');
              }
            },
          ),
        ),
      ),
    );
  }
}
