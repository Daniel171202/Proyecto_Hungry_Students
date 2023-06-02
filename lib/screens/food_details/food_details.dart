import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/constants/constants.dart';
import 'components/food_categories.dart';
import 'components/food_data.dart';
import 'components/food_description.dart';
import 'components/food_image_slider.dart';
import 'components/food_meta_data.dart';

class FoodDetailsPage extends StatefulWidget {
  const FoodDetailsPage({
    Key? key,
    required this.foodName,
    required this.imageUrl,
    required this.description,
    required this.cal,
    required this.price,
    required this.llave,
  }) : super(key: key);
  final String foodName;
  final String imageUrl;
  final String description;
  final String cal;
  final String price;
  final String llave;

  @override
  State<FoodDetailsPage> createState() => _FoodDetailsPageState();
}

class _FoodDetailsPageState extends State<FoodDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(29, 164, 180, 0.996),
        automaticallyImplyLeading: true, // Muestra el botón de retroceso
        title: Text(
          widget.foodName,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 252, 252, 252),
              ),
        ),
      ),
      body: Column(
        children: [
          //ImageSliderFood(),
          Image.network(
            widget.imageUrl,
          ),

          FoodMetaData(
              foodName: widget.foodName,
              price: widget.price,
              llave: widget.llave),
          FoodDescription(description: widget.description),
          //FoodCategories(),
          //Divider(height: AppDefaults.margin * 2),
          //FoodData(),
          //Spacer(),
          //PlaceOrderButton(),
        ],
      ),
    );
  }
}

class PlaceOrderButton extends StatelessWidget {
  const PlaceOrderButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDefaults.padding),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: AppDefaults.boxShadow,
      ),
      child: SafeArea(
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppDefaults.padding),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: AppDefaults.borderRadius,
              ),
              child: SvgPicture.asset(AppIcons.order2),
            ),
            const Spacer(),
            Text(
              '\$12.00',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: ElevatedButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Place Order',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.white,
                          ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: AppDefaults.borderRadius,
                      ),
                      child: Text(
                        '2',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
