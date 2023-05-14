import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:rive_animation/screens/Admin/entry_point_admin.dart';
import 'package:rive_animation/screens/Admin/home/food_form_page.dart';
import 'package:rive_animation/screens/RestaurantList/Lista.dart';
import 'package:rive_animation/screens/entryPoint/entry_point.dart';
//import 'package:rive_animation/screens/entryPoint/entry_point.dart';
import 'package:rive_animation/screens/onboding/components/auth_page.dart';
//import 'package:rive_animation/screens/onboding/onboding_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
//import 'package:firebase_database/firebase_database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAuth.instance.setLanguageCode("es");
  // Obtiene una instancia de la base de datos
  /*final database = FirebaseDatabase.instance.reference();

      // Define el dato que se va a agregar a la base de datos
      Map<String, dynamic> data = {
        'name': 'Besto plato',
        'description': 'Es un rico plato de tacos:D',
        'imageUrl':'https://cdn1.intriper.com/wp-content/uploads/2019/07/20190720/TACOS-3.jpg',
        'precio':'21',
        'restaurant': 'pollo'
      };
      // Agrega el dato a la base de datos
      try {
        await database.child('Products_Restaurants').push().set(data);
        print('Dato agregado a Firebase Realtime Database');
      } catch (e) {
        print('Error al agregar dato a Firebase Realtime Database: $e');
      }*/
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Flutter Way',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFEEF1F8),
        primarySwatch: Colors.blue,
        fontFamily: "Intel",
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          errorStyle: TextStyle(height: 0),
          border: defaultInputBorder,
          enabledBorder: defaultInputBorder,
          focusedBorder: defaultInputBorder,
          errorBorder: defaultInputBorder,
        ),
      ),
      home: const AuthPage(),
    );
  }
}

const defaultInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(16)),
  borderSide: BorderSide(
    color: Color(0xFFDEE3F2),
    width: 1,
  ),
);
