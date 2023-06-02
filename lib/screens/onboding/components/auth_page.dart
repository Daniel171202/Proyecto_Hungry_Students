import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:rive_animation/screens/RestaurantList/mapa.dart';
import 'package:rive_animation/screens/Admin/entry_point_admin.dart';
import 'package:rive_animation/screens/entryPoint/entry_point.dart';
import 'package:rive_animation/screens/onboding/components/entry_point_pruebita.dart';
import 'package:rive_animation/screens/onboding/onboding_screen.dart';

class AuthPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const AuthPage({Key? key});

  Future<bool> esRestaurante() async {
    final user = FirebaseAuth.instance.currentUser!;
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('Restaurantes/${user.uid}').get();
    if (snapshot.exists) {
      log("esta");
      // ignore: avoid_print
      print(snapshot.value);
      return true;
    } else {
      log('No esta');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const OnbodingScreen();
          }

          return FutureBuilder<bool>(
            future: esRestaurante(),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data!) {
                return const EntryPointAdmin(); //es restaurante
              } else {
                return const EntryPoint(); //no es restaurante
              }
            },
          );
        },
      ),
    );
  }
}
