import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rive_animation/core/components/item_tile_vertical.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../../../core/components/item_tile_horizontal.dart';
import '../../../../core/constants/constants.dart';

class RestaurantProducts extends StatelessWidget {
  const RestaurantProducts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(AppDefaults.padding),
          child: Column(
            children: [
              SizedBox(height: 75),
              Text(
                'Tus productos son',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 255, 64, 77),
                    fontSize: 25),
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: StreamBuilder(
              stream: FirebaseDatabase.instance
                  .ref()
                  .child('Comidas/${user.uid}')
                  .onValue,
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
                  List<Map<dynamic, dynamic>> foodsList = [];
                  Map<dynamic, dynamic> foods = snapshot.data!.snapshot.value;
                  foods.forEach((key, value) {
                    foodsList.add(value);
                  });

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
                  return Text('Error al obtener datos de Firebase');
                } else {
                  return Text('No tienes platillos');
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
