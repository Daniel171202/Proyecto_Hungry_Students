import 'package:flutter/material.dart';

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
                'Recomendaciones ',
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
          scrollDirection: Axis.horizontal,
          child: StreamBuilder(
            stream: FirebaseDatabase.instance
                .ref()
                .child('Restaurantes')
                .limitToFirst(5) // Limita los datos a 5
                .onValue,
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                // Obtiene una lista de Mapas de los datos de Firebase
                List<Map<dynamic, dynamic>> foodsList = [];
                Map<dynamic, dynamic> foods = snapshot.data!.snapshot.value;
                foods.forEach((key, value) {
                  print(value);
                  foodsList.add({
                    ...value,
                    'llave': key.toString(), // Agrega la llave como atributo
                  });
                });

                // Crea una lista de ItemTileHorizontal a partir de los datos de Firebase
                List<ItemTileHorizontal> itemTiles = [];
                for (var food in foodsList) {
                  itemTiles.add(
                    ItemTileHorizontal(
                      foodName: food['name'],
                      description: food['descripcion'],
                      imageUrl: food['imageUrl'],
                      cal: food['calificacion'],
                      dire: food['direccion'],
                      hop: food['hopen'],
                      hcl: food['hclose'],
                      llave: food['llave'],
                    ),
                  );
                }

                return Row(
                  children: itemTiles,
                );
              } else if (snapshot.hasError) {
                return const Text('Error al obtener datos de Firebase');
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
      ],
    );
  }
}
