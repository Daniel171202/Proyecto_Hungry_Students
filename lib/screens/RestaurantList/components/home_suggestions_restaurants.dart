import 'package:flutter/material.dart';
import 'package:rive_animation/core/components/item_tile_vertical_2.dart';

import '../../../../core/constants/constants.dart';
import 'package:firebase_database/firebase_database.dart';

class RestaurantProducts extends StatelessWidget {
  const RestaurantProducts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: StreamBuilder(
            stream: FirebaseDatabase.instance
                .reference()
                .child('Restaurantes')
                .onValue,
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                // Obtiene una lista de Mapas de los datos de Firebase
                List<Map<dynamic, dynamic>> foodsList = [];
                Map<dynamic, dynamic> foods = snapshot.data!.snapshot.value;
                foods.forEach((key, value) {
                  print(value);
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
                      cal: food['calificacion'],
                      dire: food['direccion'],
                      hop: food['hopen'],
                      hcl: food['hclose']
                    ),
                  );
                }

                return Column(
                  children: itemTiles,
                );
              } else if (snapshot.hasError) {
                return const Text('Error al obtener datos de Firebase');
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
      ],
    );
  }
}
