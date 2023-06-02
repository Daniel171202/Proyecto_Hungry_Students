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
            stream: FirebaseDatabase.instance // Configuración del flujo de datos desde Firebase
              .reference()
              .child('Restaurantes')
              .onValue, // Escucha los cambios en "Restaurantes"
            builder: (context, AsyncSnapshot snapshot) { // Función de construcción del widget basado en el snapshot del flujo de datos
              if (snapshot.hasData) { // Comprueba si hay datos en el snapshot
                // Obtiene una lista de Mapas de los datos de Firebase
                List<Map<dynamic, dynamic>> foodsList = [];
                Map<dynamic, dynamic> foods = snapshot.data!.snapshot.value;
                foods.forEach((key, value) {
                  foodsList.add({
                    ...value,
                    'llave': key.toString(), // Agrega la llave como atributo
                  });
                });

                // Crea una lista de ItemTileVertical a partir de los datos de Firebase
                List<ItemTileVertical> itemTiles = [];
                for (var food in foodsList) {
                  print("ola:$food");
                  itemTiles.add(
                    ItemTileVertical(
                      foodName: food['name'],
                      description: food['descripcion'],
                      imageUrl: food['imageUrl'],
                      cal: food['calificacion'],
                      dire: food['direccion'],
                      hop: food['hopen'],
                      hcl: food['hclose'],
                      reslat: food['rlat'],
                      reslong: food['rlong'],
                      llave: food['llave'], // Pasa la llave como atributo
                    ),
                  );
                }

                return Column(
                  children: itemTiles, // Muestra la lista de ItemTileVertical en una columna
                );
              } else if (snapshot.hasError) { // Comprueba si hay un error en el snapshot
                return const Text('Error al obtener datos de Firebase'); // Muestra un mensaje de error
              } else {
                return CircularProgressIndicator(); // Muestra un indicador de carga mientras se obtienen los datos
              }
            },
          ),

        ),
      ],
    );
  }
}
