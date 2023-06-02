import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Mapa extends StatefulWidget {
  //constructor con los parametros requeridos para mapa
  final String nombre;
  final String desc;
  final double reslat;
  final double reslong;

  const Mapa({
    Key? key,
    required this.nombre,
    required this.desc,
    required this.reslat,
    required this.reslong,
  }) : super(key: key);

  @override
  State<Mapa> createState() => _MapaState();
}

//variable Latitud Longitud UCB
                                    //latitud , longitud de UCB
LatLng currentLocation = LatLng( -16.523048293726905, -68.1122812626133);

class _MapaState extends State<Mapa> {
  late GoogleMapController mapController;
  Map<String, Marker> _markers = {};
  @override
  void initState(){
    //llama al metodo que obtiene puntos de una polilinea
    getPolyPoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LatLng destino = LatLng(widget.reslat, widget.reslong);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(29, 164, 180, 0.996),
        title: Text("Ubicacion "+widget.nombre),
      ),
      body: GoogleMap(
        initialCameraPosition:  CameraPosition(
          target: currentLocation,
          zoom: 14,
        ),
        polylines: {
          Polyline(
            polylineId: PolylineId("route"),
            points: polylineCoordinates,
            color: Colors.purpleAccent,
            width: 4,
          ),
        },
        onMapCreated: (controller){
          mapController: controller;
          //funcion para aniadir marcas
          addMarker(widget.nombre,destino,widget.nombre,widget.desc);
          addMarker('UCB',currentLocation,'UCB','Universidad Catolica Boliviana San Pablo');
        },
        //marcadores en el mapa como tiendas 
        markers: _markers.values.toSet(),
      ),
    );
  }

  //FUNCION ANIADIR MARCA
  addMarker(String IDmark, LatLng location, String tit,String desc) async {
    //foto a icono para el mapa
    var markerIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
     'assets/images/iconoPollito.png'
    );

    var marker = Marker(
      markerId: MarkerId(IDmark),
      position: location,
      infoWindow: InfoWindow(
        title: tit,
        snippet: desc
      ),
      //icon:  markerIcon, 
    );
    //agregamos el valor a nuestra lista 
    _markers[IDmark] = marker;
    print('ola:$_markers');
    setState(() {
      // Actualizar el estado del widget 
    });
  }

  //POLYPOINTS PARA DIBUJAR RUTA
  List<LatLng> polylineCoordinates=[];
  void getPolyPoints() async {
  LatLng destino = LatLng(widget.reslat, widget.reslong);
  // Clave de API de Google Maps
  String google_api_key = 'AIzaSyAAqP33bJzJmsd4FEW0e1J8yBZZXxWjk5U';

  // Instancia de PolylinePoints para obtener las coordenadas de la ruta
  PolylinePoints polylinePoints = PolylinePoints();
  
  // Obtener la ruta entre las coordenadas actuales y las coordenadas destino
  PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
    google_api_key,
    PointLatLng(currentLocation.latitude, currentLocation.longitude),
    PointLatLng(destino.latitude, destino.longitude),
    travelMode: TravelMode.walking
  );

  // Verificar si se obtuvieron puntos de la ruta
  if (result.points.isNotEmpty) {
    // Iterar sobre los puntos de la ruta y agregar las coordenadas a polylineCoordinates
    result.points.forEach((PointLatLng point) {
      polylineCoordinates.add(LatLng(point.latitude, point.longitude));
    });
  }

  setState(() {
    print("cms:$polylineCoordinates");
    // Actualizar el estado del widget
  });
}

}