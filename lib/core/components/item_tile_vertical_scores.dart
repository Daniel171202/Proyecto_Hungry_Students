import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../screens/food_details/food_details.dart';

import '../constants/constants.dart';
import 'network_image.dart';

class ItemTileVerticalScore extends StatelessWidget {
  const ItemTileVerticalScore({
    Key? key,
    required this.imageUrl,
    required this.opinion,
    required this.usuario,
    required this.calificacion,
  }) : super(key: key);

  final String opinion;
  final String calificacion;
  final String usuario;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        /*onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const FoodDetailsPage()));
        },*/
        borderRadius: AppDefaults.borderRadius,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          //Aca empieza los datos de cada ITEM
          child: Container(
            margin:
                const EdgeInsets.only(bottom: 16), // add space between items
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: CircleAvatar(
                    radius: 40, // Tamaño del círculo
                    //foregroundImage: NetworkImage(imageUrl),
                    backgroundImage: NetworkImage(imageUrl),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        usuario,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 126, 16, 9),
                            fontSize: 15),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        opinion,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 90, 88, 88),
                            fontSize: 13),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Spacer(),
                          Row(
                            children: List.generate(
                              int.parse(calificacion),
                              (index) => const Icon(
                                Icons.star_rounded,
                                color: Colors.orangeAccent,
                                size: 16,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
