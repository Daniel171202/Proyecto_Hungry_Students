import 'package:flutter/material.dart';
import 'package:rive_animation/core/components/item_tile_horizontal_food.dart';

import '../../../core/components/item_tile_horizontal.dart';
import '../../../core/constants/constants.dart';
import 'package:firebase_database/firebase_database.dart';

class HomeSuggestionSection extends StatelessWidget {
  const HomeSuggestionSection({
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
                '(Comidas)',
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
            stream:
                FirebaseDatabase.instance.reference().child('Comidas').onValue,
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                // Obtiene una lista de Mapas de los datos de Firebase
                List<Map<dynamic, dynamic>> foodsList = [];
                Map<dynamic, dynamic> foods = snapshot.data!.snapshot.value;
                if (foods != null) {
                  int count = 0; // Contador para limitar a cinco elementos
                  foods.forEach((key, value) {
                    if (value is Map) {
                      value.forEach((innerKey, innerValue) {
                        if (count < 5) {
                          // Verifica si el valor es un mapa para acceder a los subgrupos
                          if (innerValue is Map) {
                            // Accede a los subgrupos y atributos que deseas
                            String foodName = innerValue['name'] ?? '';
                            String description =
                                innerValue['descripcion'] ?? '';
                            String imageUrl = innerValue['imageUrl'] ?? '';
                            String price = innerValue['precio'] ?? '';
                            String llave = innerValue['llave'] ?? '';

                            // Crea un mapa con los datos que necesitas
                            Map<String, dynamic> foodData = {
                              'foodName': foodName,
                              'description': description,
                              'imageUrl': imageUrl,
                              'price': price,
                              'cal': price,
                              'llave': llave,
                              // Usa el valor de 'precio' para 'cal'
                            };

                            foodsList.add(foodData);
                            count++;
                          }
                        }
                      });
                    }
                  });
                }

                // Crea una lista de ItemTileHorizontal a partir de los datos de Firebase
                List<ItemTileHorizontalFood> itemTiles = [];
                for (var food in foodsList) {
                  itemTiles.add(
                    ItemTileHorizontalFood(
                      foodName: food['foodName'],
                      description: food['description'],
                      imageUrl: food['imageUrl'],
                      price: food['price'],
                      cal: food['cal'],
                      llave: food['llave'],
                    ),
                  );
                }

                return Row(
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
