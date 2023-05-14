import 'dart:developer';
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'components/home_category_selection.dart';
import 'components/home_greetings.dart';
import 'components/home_header.dart';
import 'components/home_suggestions.dart';
import 'components/home_info_restaurante.dart';
import '../../../core/components/search_box.dart';
import '../../../../core/constants/constants.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rive/rive.dart';
//import 'package:rive_animation/screens/entryPoint/entry_point.dart';
import 'package:rive_animation/screens/Admin/home/entry_page.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({
    Key? key,
  }) : super(key: key);

  @override
  _FoodPageState createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  final foodController = TextEditingController();
  final descController = TextEditingController();
  final precioController = TextEditingController();
  final urlController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> subirComida() async {
    final user = FirebaseAuth.instance.currentUser!;
    final database = FirebaseDatabase.instance.ref();
    Map<String, dynamic> data = {
      "name": foodController.text,
      "precio": precioController.text,
      "imageUrl": urlController.text,
      "description": descController.text,
      "restaurant": user.displayName,
    };
    final llave = user.uid;
    // Agrega el dato a la base de datos
    try {
      await database.child('Products_Restaurants').push().set(data);
      log('Comida agregada a Firebase Realtime Database');
    } catch (e) {
      log('Error al agregar restaurante a Firebase Realtime Database: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    //final ref = FirebaseDatabase.instance.ref();
    //final snapshot = await ref.child('Restaurantes/${user.uid}').get();

    return Material(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 100),
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back),
            ),
            const Text(
              "       Informacion de comida",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 255, 64, 77),
                fontSize: 25,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Nombre de tu comida:",
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
            TextFormField(
              controller: foodController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "";
                }
                return null;
              },
              decoration: const InputDecoration(
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Icon(
                    Icons.restaurant,
                    color: Color.fromRGBO(255, 64, 64, 1),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Descripcion:",
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
            TextFormField(
              controller: descController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "";
                }
                return null;
              },
              decoration: const InputDecoration(
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Icon(
                    Icons.article,
                    color: Color.fromRGBO(255, 64, 64, 1),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Precio:",
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: precioController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "";
                }
                return null;
              },
              decoration: const InputDecoration(
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Icon(
                    Icons.monetization_on,
                    color: Color.fromRGBO(255, 64, 64, 1),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Imagen Restaurante url:",
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
            TextFormField(
              controller: urlController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "";
                }
                return null;
              },
              decoration: const InputDecoration(
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Icon(
                    Icons.image,
                    color: Color.fromRGBO(255, 64, 64, 1),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                subirComida();
                foodController.clear();
                descController.clear();
                precioController.clear();
                urlController.clear();
                showDialog(
                  context: context,
                  builder: (context) {
                    return const AlertDialog(
                      backgroundColor: Color.fromARGB(248, 255, 75, 90),
                      title: Center(
                        child: Text(
                          'Se añadio tu comida correctamente',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  },
                );
                Future.delayed(const Duration(milliseconds: 1036), () {
                  Navigator.pop(context);
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(255, 64, 64, 1),
                minimumSize: const Size(double.infinity, 56),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                  ),
                ),
              ),
              icon: const Icon(
                CupertinoIcons.plus_app,
                color: Color.fromARGB(255, 255, 252, 253),
              ),
              label: const Text(
                "Añadir",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
