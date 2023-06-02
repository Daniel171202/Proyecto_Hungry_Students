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

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String descripcion = "";
  late String direccion = "";
  late String urlimagen = "";
  late String correo = "";
  late String hop = "";
  late String hcl = "";

  @override
  void initState() {
    super.initState();
    _loadInfo();
  }

  Future<void> _loadInfo() async {
    final user = FirebaseAuth.instance.currentUser!;
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('Restaurantes/${user.uid}').get();
    if (snapshot.exists) {
      // ignore: avoid_print
      setState(() {
        descripcion = snapshot.child('descripcion').value.toString();
        direccion = snapshot.child('direccion').value.toString();
        urlimagen = snapshot.child('imageUrl').value.toString();
        correo = snapshot.child('correo').value.toString();
        hop = snapshot.child('hopen').value.toString();
        hcl = snapshot.child('hclose').value.toString();
      });
    } else {
      setState(() {
        descripcion = "Añade descripcion";
        direccion = "Añade direcion";
        urlimagen = "Añade tu enlace";
        correo = "Añade correo";
        hop = "Añade hora de apertura";
        hcl = "Añade hora de cerrado";
      });
    }
  }

  void actualizarDatos(
      String nameController,
      String direcController,
      String descController,
      String urlController,
      String correoController,
      String hopController,
      String hclController) {
    // Obtén una referencia a la entidad que deseas actualizar
    final user = FirebaseAuth.instance.currentUser!;
    DatabaseReference ref =
        FirebaseDatabase.instance.ref().child('Restaurantes').child(user.uid);

    // Crea un mapa con los atributos que deseas actualizar
    Map<String, dynamic> actualizaciones = {
      'name': nameController,
      'descripcion': descController,
      'direccion': direcController,
      'imageUrl': urlController,
      'correo': correoController,
      'hopen': hopController,
      'hclose': hclController,
      'llave': user.uid,
    };

    // Actualiza solo los atributos especificados en el mapa
    ref.update(actualizaciones);
    user.updateDisplayName(nameController);
    user.updateEmail(correoController);
    user.updatePhotoURL(urlController);
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    //final ref = FirebaseDatabase.instance.ref();
    //final snapshot = await ref.child('Restaurantes/${user.uid}').get();
    TextEditingController nameController =
        TextEditingController(text: user.displayName);
    TextEditingController direcController =
        TextEditingController(text: direccion);
    TextEditingController descController =
        TextEditingController(text: descripcion);
    TextEditingController urlController =
        TextEditingController(text: urlimagen);
    TextEditingController correoController =
        TextEditingController(text: correo);
    TextEditingController hopController = TextEditingController(text: hop);
    TextEditingController hclController = TextEditingController(text: hcl);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 100),
            const Text(
              "       Información Restaurante",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 255, 64, 77),
                fontSize: 25,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Nombre:",
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
            TextFormField(
              controller: nameController,
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
              "Correo:",
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
            TextFormField(
              controller: correoController,
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
                    Icons.email_rounded,
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
              "Dirección:",
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
            TextFormField(
              controller: direcController,
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
                    Icons.store,
                    color: Color.fromRGBO(255, 64, 64, 1),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Hora de apertura:",
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
            TextFormField(
              controller: hopController,
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
                    Icons.av_timer_sharp,
                    color: Color.fromRGBO(255, 64, 64, 1),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Hora de cierre:",
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
            TextFormField(
              controller: hclController,
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
                    Icons.lock_clock,
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
                actualizarDatos(
                    nameController.text,
                    direcController.text,
                    descController.text,
                    urlController.text,
                    correoController.text,
                    hopController.text,
                    hclController.text);

                showDialog(
                  context: context,
                  builder: (context) {
                    return const AlertDialog(
                      backgroundColor: Color.fromARGB(248, 255, 75, 90),
                      title: Center(
                        child: Text(
                          'Se actualizaron tus datos correctamente',
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
                CupertinoIcons.arrow_right,
                color: Color.fromARGB(255, 255, 252, 253),
              ),
              label: const Text(
                "Actualizar",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
