import 'dart:developer';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rive_animation/screens/home/components/restaurantes_page.dart';

import '../../../core/components/network_image.dart';
import '../../../core/constants/constants.dart';

class FoodMetaData extends StatefulWidget {
  const FoodMetaData({
    Key? key,
    required this.foodName,
    required this.price,
    required this.llave,
  }) : super(key: key);
  final String foodName;
  final String price;
  final String llave;

  @override
  State<FoodMetaData> createState() => _FoodMetaDataState();
}

class _FoodMetaDataState extends State<FoodMetaData> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDefaults.padding),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                widget.foodName,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Text(
                "${widget.price} Bs",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const SizedBox(height: 16),
          /// Resturant Details
          Row(
            children: [
              ResturantDetails(llave: widget.llave),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 14),

          /// Delivery Data
          /*
          Row(
            children: [
              SvgPicture.asset(AppIcons.time),
              const Text('10 min'),
              const Spacer(),
              SvgPicture.asset(AppIcons.stars),
              const Text('4.5'),
              const Spacer(),
              SvgPicture.asset(AppIcons.delivery),
              const Text('Free Delivery'),
              const Spacer(flex: 5),
            ],
          ),*/
        ],
      ),
    );
  }
}

class ResturantDetails extends StatefulWidget {
  const ResturantDetails({
    Key? key,
    required this.llave,
  }) : super(key: key);
  final String llave;

  @override
  _ResturantDetailsState createState() => _ResturantDetailsState();
}

class _ResturantDetailsState extends State<ResturantDetails> {
  late String descripcion = "";
  late String direccion = "";
  late String urlimagen = "";
  late String correo = "";
  late String hop = "";
  late String hcl = "";
  late String name = "";
  late String cal = "";
  late String reslat = "";
  late String reslong = "";

  @override
  void initState() {
    super.initState();
    info();
  }

  Future<void> info() async {
    final ref = FirebaseDatabase.instance.ref();
    //log(widget.llave);
    final snapshot = await ref.child('Restaurantes/${widget.llave}').get();
    if (snapshot.exists) {
      print(snapshot.value);
      // ignore: avoid_print
      setState(() {
        descripcion = snapshot.child('descripcion').value.toString();
        direccion = snapshot.child('direccion').value.toString();
        urlimagen = snapshot.child('imageUrl').value.toString();
        correo = snapshot.child('correo').value.toString();
        hop = snapshot.child('hopen').value.toString();
        hcl = snapshot.child('hclose').value.toString();
        name = snapshot.child('name').value.toString();
        cal = snapshot.child('calificacion').value.toString();
        reslat = snapshot.child('rlat').value.toString();
        reslong = snapshot.child('rlong').value.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //log(widget.llave);

    return SingleChildScrollView(
      child: Row(
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: NetworkImageWithLoader(
              urlimagen,
            ),
          ),
          const SizedBox(width: 13),
          Row(
            children: [
              Text(
                name,
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(width: 10),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RestaurantesPage(
                          nombre: name,
                          imageUrl: urlimagen,
                          descripcion: descripcion,
                          direccion: direccion,
                          calificacion: cal,
                          hop: hop,
                          hcl: hcl,
                          reslat: double.parse(reslat),
                          reslong:double.parse(reslong),
                          llave: widget.llave),
                    ),
                  );
                },
                icon: const Icon(Icons.arrow_circle_right),
                color: Color.fromARGB(255, 255, 38, 0), // Cambia el color aquí
              )

              /*
              Row(
                children: List.generate(
                  int.parse(cal),
                  (index) => const Icon(
                    Icons.star_rounded,
                    color: Colors.orangeAccent,
                    size: 9,
                  ),
                ),
              )*/
            ],
          ),
        ],
      ),
    );
  }
}
