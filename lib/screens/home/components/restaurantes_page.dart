import 'package:flutter/material.dart';
import 'package:rive_animation/screens/RestaurantList/components/food_info.dart';
import 'package:rive_animation/screens/RestaurantList/mapa.dart';
import 'package:rive_animation/screens/entryPoint/entry_point.dart';
import 'package:rive_animation/screens/home/components/scores.dart';

class RestaurantesPage extends StatefulWidget {
  final String nombre;
  final String imageUrl;
  final String descripcion;
  final String direccion;
  final String calificacion;
  final String hop;
  final String hcl;
  final double reslat;
  final double reslong;
  final String llave;

  const RestaurantesPage({
    Key? key,
    required this.nombre,
    required this.imageUrl,
    required this.descripcion,
    required this.direccion,
    required this.calificacion,
    required this.hop,
    required this.hcl,
    required this.reslat,
    required this.reslong,
    required this.llave,
  }) : super(key: key);

  @override
  _RestaurantesPageState createState() => _RestaurantesPageState();
}

class _RestaurantesPageState extends State<RestaurantesPage> {
  int _calificacion = 0;
  final TextEditingController calController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(29, 164, 180, 0.996),
        title: Text(widget.nombre),
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
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
                    children: [
                      const Icon(Icons.note_alt_outlined),
                      const Text(
                        'Descripcion',
                        style: TextStyle(fontSize: 17),
                      ),
                      const SizedBox(width: 65),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      FoodnfoPage(llave: widget.llave)));
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromRGBO(180, 52, 29, 0.635),
                          ), // Cambiar el color aquí
                        ),
                        child: Text(
                          'Menú de\n${widget.nombre}',
                          style: const TextStyle(fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Text(
                      widget.descripcion,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: const [
                      Icon(Icons.house),
                      Text(
                        'Direccion',
                        style: TextStyle(fontSize: 17),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Text(
                      widget.direccion,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: const [
                      Icon(Icons.timelapse_outlined),
                      Text(
                        'Horarios:',
                        style: TextStyle(fontSize: 17),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Text(
                      '${widget.hop} a ${widget.hcl}',
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 9),
                  Container(
                    alignment: Alignment.center,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ScoresPage(
                              calificacion: widget.calificacion,
                              llave: widget.llave,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.people_alt,
                        size: 40,
                        color: Color.fromARGB(255, 255, 253, 253),
                      ),
                      label: const Text(
                        "VER OPINIONES",
                        style: TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 252, 250, 250),
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(178, 218, 35, 10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 9),
                  Container(
                    alignment: Alignment.center,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Mapa(
                              nombre: widget.nombre, 
                              desc: widget.descripcion, 
                              reslat: widget.reslat, 
                              reslong: widget.reslong
                              )
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.location_on_outlined,
                        size: 40,
                        color: Color.fromARGB(255, 255, 253, 253),
                      ),
                      label: const Text(
                        "VER EN EL MAPA",
                        style: TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 252, 250, 250),
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(178, 0,135,159),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
