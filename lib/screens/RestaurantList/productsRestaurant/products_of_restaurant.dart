import 'package:flutter/material.dart';
import 'package:rive_animation/core/components/item_tile_vertical_2.dart';

import '../../../../core/constants/constants.dart';
import 'package:firebase_database/firebase_database.dart';

import 'item_tile_vertical_products.dart';

class ProductsOfRestaurant extends StatelessWidget {
  final String nombre;
  const ProductsOfRestaurant({
    required this.nombre,
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
                .child('Products_Restaurants')
                .orderByChild('restaurant')
                .equalTo(nombre)
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
                List<ItemTileVerticalProducts> itemTiles = [];
                for (var food in foodsList) {
                  itemTiles.add(
                    ItemTileVerticalProducts(
                      foodName: food['name'],
                      description: food['description'],
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
                return CircularProgressIndicator();
              }
            },
          ),
        ),
      ],
    );
  }
}
