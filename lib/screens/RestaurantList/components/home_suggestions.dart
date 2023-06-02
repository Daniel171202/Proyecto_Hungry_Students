import 'package:flutter/material.dart';
import '../../../core/components/item_tile_horizontal.dart';
import '../../../core/constants/constants.dart';
import 'package:firebase_database/firebase_database.dart';

class HomeSuggestionSection extends StatelessWidget {
  const HomeSuggestionSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width,
        maxHeight: MediaQuery.of(context).size.height * 0.3,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                  '(Platos)',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Colors.grey),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: StreamBuilder(
                stream: FirebaseDatabase.instance
                    .reference()
                    .child('Popular_Dishes')
                    .onValue,
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error al obtener datos de Firebase');
                  } else if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }

                  List<Map<dynamic, dynamic>> foodsList = [];
                  Map<dynamic, dynamic> foods = snapshot.data!.snapshot.value;
                  foods.forEach((key, value) {
                    foodsList.add(value);
                  });

                  List<ItemTileHorizontal> itemTiles = [];
                  for (var food in foodsList) {
                    itemTiles.add(
                      ItemTileHorizontal(
                        foodName: food['name'],
                        description: food['description'],
                        imageUrl: food['imageUrl'],
                        price: food['price'],
                        cal: food['cal'],
                      ),
                    );
                  }

                  return Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: itemTiles,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
