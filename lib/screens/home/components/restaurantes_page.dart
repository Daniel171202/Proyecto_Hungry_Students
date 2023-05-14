import 'package:flutter/material.dart';
import 'package:rive_animation/screens/RestaurantList/productsList.dart';
import 'package:rive_animation/screens/entryPoint/entry_point.dart';

class RestaurantesPage extends StatefulWidget {
  final String nombre;
  final String imageUrl;
  final String descripcion;
  final String direccion;
  final String calificacion;
  final String hope;
  final String hclo;

  const RestaurantesPage({
    Key? key,
    required this.nombre,
    required this.imageUrl,
    required this.descripcion,
    required this.direccion,
    required this.calificacion,
    required this.hope,
    required this.hclo,
  }) : super(key: key);

  @override
  _RestaurantesPageState createState() => _RestaurantesPageState();
}

class _RestaurantesPageState extends State<RestaurantesPage> {
  int _calificacion = 0;
  final TextEditingController calController = TextEditingController();

  List<Widget> _generarEstrellas() {
    List<Widget> estrellas = [];

    for (int i = 1; i <= 5; i++) {
      Icon icon = Icon(
        i <= _calificacion ? Icons.star : Icons.star_border,
        color: Color.fromARGB(255, 219, 89, 57),
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
                color: Colors.grey[200],
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
                      SizedBox(width: 65),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>  ProductList(nombreRes: widget.nombre)));
                        },
                        child: Text('Productos de\n'+widget.nombre,style: const TextStyle(
                        fontSize: 14
                      ),textAlign: TextAlign.center,),
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
                      widget.hope+' a '+widget.hclo,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _generarEstrellas(),
                  ),
                  const SizedBox(height: 14),
                  TextField(
                    controller: calController,
                    decoration: InputDecoration(
                      labelText: 'Algun comentario?',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _calificacion = int.tryParse(value) ?? 0;
                      });
                    },
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_circle_up_outlined,
                        size: 40,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        setState(() {
                          _calificacion = 0;
                          calController.clear();
                        });
                        showDialog(
                          context: context,
                          builder: (context) {
                            return const AlertDialog(
                              backgroundColor: Color.fromARGB(248, 11, 177, 34),
                              title: Center(
                                child: Text(
                                  'Se subio tu calificacion',
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
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: const Text(
                      "Calificar",
                      style: TextStyle(
                          fontSize: 15, color: Color.fromARGB(255, 90, 37, 34)),
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
