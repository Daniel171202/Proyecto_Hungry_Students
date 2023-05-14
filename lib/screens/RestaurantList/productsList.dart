import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:rive_animation/screens/RestaurantList/productsRestaurant/products_of_restaurant.dart';

import 'components/home_category_selection.dart';
import 'components/home_greetings.dart';
import 'components/home_header.dart';
import 'components/home_suggestions.dart';
import 'components/home_suggestions_restaurants.dart';

import 'components/sponsored_resturants.dart';
import '../../core/components/search_box.dart';

class ProductList extends StatelessWidget {
  final String nombreRes;

  const ProductList({
    Key? key,
    required this.nombreRes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(29, 164, 180, 0.996),
        title: Text("Productos de "+nombreRes, style: TextStyle(fontSize: 16),),
      ),
      body: Material(
      child: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              ProductsOfRestaurant(nombre: nombreRes),
              const SizedBox(height: 70),
            ],
          ),
        ),
      ),
    ),
  );
  }
}