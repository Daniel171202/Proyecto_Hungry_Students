import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:rive_animation/core/components/item_tile_vertical_scores.dart';
import 'package:rive_animation/screens/RestaurantList/components/food_info.dart';
import 'package:rive_animation/screens/entryPoint/entry_point.dart';

class ScoresPage extends StatefulWidget {
  final String calificacion;
  final String llave;

  const ScoresPage({
    Key? key,
    required this.calificacion,
    required this.llave,
  }) : super(key: key);

  @override
  _ScoresPageState createState() => _ScoresPageState();
}

class _ScoresPageState extends State<ScoresPage> {
  late String opinion = "";
  late String cal = "";
  int _calificacion = 0;

  @override
  void initState() {
    super.initState();
    _loadInfo();
  }

  Future<void> _loadInfo() async {
    final user = FirebaseAuth.instance.currentUser!;
    final ref = FirebaseDatabase.instance.ref();
    final snapshot =
        await ref.child('Scores/${widget.llave}/${user.uid}').get();
    if (snapshot.exists) {
      // ignore: avoid_print
      setState(() {
        opinion = snapshot.child('opinion').value.toString();
        cal = snapshot.child('calificacion').value.toString();
        _calificacion = int.parse(cal);
      });
    } else {
      setState(() {
        opinion = "";
        cal = "0";
      });
    }
  }

  void actualizarOpinion(
    String opinionController,
    String califi,
  ) {
    // Obtén una referencia a la entidad que deseas actualizar
    final user = FirebaseAuth.instance.currentUser!;
    DatabaseReference ref = FirebaseDatabase.instance
        .ref()
        .child('Scores/${widget.llave}')
        .child(user.uid);

    // Crea un mapa con los atributos que deseas actualizar
    Map<String, dynamic> actualizaciones = {
      'opinion': opinionController,
      'calificacion': califi,
      'name': user.displayName,
      'imageUrl': user.photoURL,
    };

    // Actualiza solo los atributos especificados en el mapa
    ref.update(actualizaciones);
  }

  List<Widget> _generarEstrellas() {
    List<Widget> estrellas = [];

    for (int i = 1; i <= 5; i++) {
      Icon icon = Icon(
        i <= _calificacion ? Icons.star : Icons.star_border,
        color: const Color.fromARGB(255, 219, 89, 57),
        size: 40,
      );
      estrellas.add(
        GestureDetector(
          child: icon,
          onTap: () {
            setState(() {
              _calificacion = i;
            });
          },
        ),
      );
    }
    return estrellas;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController opinionController =
        TextEditingController(text: opinion);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(29, 164, 180, 0.996),
        title: const Text("Opiniones"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
              margin: const EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height * 0.3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _generarEstrellas(),
                  ),
                  const SizedBox(height: 14),
                  TextFormField(
                    controller: opinionController,
                    decoration: InputDecoration(
                      labelText: 'Deja tu opinion',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    /*
                    onChanged: (value) {
                      setState(() {
                        _calificacion = int.tryParse(value) ?? 0;
                      });
                    },*/
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: ElevatedButton.icon(
                      icon: const Icon(
                        Icons.arrow_circle_up_outlined,
                        size: 40,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      label: const Text(
                        'Actualizar opinion',
                        style: TextStyle(fontSize: 15),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(172, 255, 64, 64),
                        // Color de fondo verde
                      ),
                      onPressed: () {
                        actualizarOpinion(
                          opinionController.text,
                          _calificacion.toString(),
                        );
                        showDialog(
                          context: context,
                          builder: (context) {
                            return const AlertDialog(
                              backgroundColor: Color.fromARGB(248, 11, 177, 34),
                              title: Center(
                                child: Text(
                                  'Se actualizó tu opinión',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            );
                          },
                        );
                        Future.delayed(const Duration(milliseconds: 1036), () {
                          Navigator.pop(context);
                        });
                        _loadInfo();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: StreamBuilder(
                stream: FirebaseDatabase.instance
                    .ref()
                    .child('Scores/${widget.llave}')
                    .onValue,
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData &&
                      snapshot.data!.snapshot.value != null) {
                    List<Map<dynamic, dynamic>> foodsList = [];
                    Map<dynamic, dynamic> foods = snapshot.data!.snapshot.value;
                    foods.forEach((key, value) {
                      foodsList.add(value);
                    });

                    List<ItemTileVerticalScore> itemTiles = [];
                    for (var food in foodsList) {
                      itemTiles.add(
                        ItemTileVerticalScore(
                          calificacion: food['calificacion'],
                          opinion: food['opinion'],
                          usuario: food['name'],
                          imageUrl: food['imageUrl'],
                        ),
                      );
                    }

                    return Column(
                      children: itemTiles,
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error al obtener datos de Firebase');
                  } else {
                    return Text('Aun no hay opiniones!');
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
