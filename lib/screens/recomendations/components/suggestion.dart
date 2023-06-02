import 'package:flutter/material.dart';
import 'package:rive_animation/core/components/item_tile_vertical.dart';
import 'package:rive_animation/core/components/item_tile_vertical_suggestion.dart';

import '../../../core/components/item_tile_horizontal_2.dart';
import '../../../core/constants/constants.dart';
import 'package:firebase_database/firebase_database.dart';

class HomeSuggestionSectionRestaurants extends StatelessWidget {
  const HomeSuggestionSectionRestaurants({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(AppDefaults.padding),
          child: Row(
            children: [
              Text(
                'TOP Recomendaciones ',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                '(Restaurantes)',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Colors.grey),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: StreamBuilder(
            stream: FirebaseDatabase.instance
                .reference()
                .child('Recommended_Restaurants')
                .onValue,
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                // Obtiene una lista de Mapas de los datos de Firebase
                List<Map<dynamic, dynamic>> foodsList = [];
                Map<dynamic, dynamic> foods = snapshot.data!.snapshot.value;
                foods.forEach((key, value) {
                  foodsList.add(value);
                });
                foodsList.sort((a, b) => b['cal'].compareTo(a['cal']));

                // Crea una lista de ItemTileHorizontal a partir de los datos de Firebase
                List<ItemTileVerticalSuggestion> itemTiles = [];
                for (var food in foodsList) {
                  itemTiles.add(
                    ItemTileVerticalSuggestion(
                      foodName: food['name'],
                      description: food['description'],
                      imageUrl: food['imageUrl'],
                      cal: food['cal'],
                    ),
                  );
                }

                return Column(
                  children: itemTiles,
                );
              } else if (snapshot.hasError) {
                return Text('Error al obtener datos de Firebase');
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
