import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../screens/food_details/food_details.dart';

import '../constants/constants.dart';
import 'network_image.dart';

class ItemTileHorizontal extends StatelessWidget {
  const ItemTileHorizontal({
    Key? key,
    required this.foodName,
    required this.imageUrl,
    required this.description,
    required this.cal,
    required this.price,
  }) : super(key: key);

  final String foodName;
  final String imageUrl;
  final String description;
  final String cal;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          /*
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const FoodDetailsPage()));
        */
        },
        borderRadius: AppDefaults.borderRadius,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 16 / 10,
                  child: NetworkImageWithLoader(imageUrl),
                ),
                const SizedBox(height: 16),
                Text(
                  foodName,
                  style: Theme.of(context).textTheme.headline6,
                ),
                /*
                const SizedBox(height: 8),
                Text(
                  description,
                  style: Theme.of(context).textTheme.caption,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Text('Precio'),
                    const Spacer(),
                    Text(
                      '$price Bs',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    /*
                    const Text('Calificación:'),
                    const Spacer(),
                    Text('$cal/5',style: const TextStyle(fontWeight: FontWeight.bold,),),
                    const Spacer(),*/
                  ],
                )*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
