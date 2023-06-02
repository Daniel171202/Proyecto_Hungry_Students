import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_svg/flutter_svg.dart'; --->no se esta usando
import 'package:rive/rive.dart';
import 'package:rive_animation/screens/Admin/entry_point_admin.dart';
import 'package:rive_animation/screens/entryPoint/entry_point.dart';
import 'package:rive_animation/screens/onboding/components/auth_service.dart';

class SignUpFormRes extends StatefulWidget {
  const SignUpFormRes({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpFormRes> createState() => _SignUpFormResState();
}

class _SignUpFormResState extends State<SignUpFormRes> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isShowLoading = false;
  bool isShowConfetti = false;
  late SMITrigger error;
  late SMITrigger success;
  late SMITrigger reset;

  late SMITrigger confetti;

  void _onCheckRiveInit(Artboard artboard) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, 'State Machine 1');

    artboard.addController(controller!);
    error = controller.findInput<bool>('Error') as SMITrigger;
    success = controller.findInput<bool>('Check') as SMITrigger;
    reset = controller.findInput<bool>('Reset') as SMITrigger;
  }

  void _onConfettiRiveInit(Artboard artboard) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, "State Machine 1");
    artboard.addController(controller!);

    confetti = controller.findInput<bool>("Trigger explosion") as SMITrigger;
  }

  void singSucces(BuildContext context) {
    //confetti.fire();
    setState(() {
      isShowConfetti = true;
      isShowLoading = true;
    });
    Future.delayed(
      const Duration(seconds: 1),
      () {
        subirRestaurante();
        success.fire();
        Future.delayed(
          const Duration(seconds: 2),
          () {
            setState(() {
              isShowLoading = false;
            });
            confetti.fire();
            // Navigate & hide confetti
            Future.delayed(const Duration(seconds: 1), () {
              // Navigator.pop(context);
              Navigator.pop(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const EntryPointAdmin(), //--camabiar a la pagina para administradores
                ),
              );
            });
          },
        );
      },
    );
  }

  void singError(BuildContext context) {
    // confetti.fire();
    setState(() {
      isShowConfetti = true;
      isShowLoading = true;
    });
    Future.delayed(
      const Duration(microseconds: 1),
      () {
        error.fire();
        Future.delayed(
          const Duration(seconds: 2),
          () {
            setState(() {
              isShowLoading = false;
            });
            reset.fire();
          },
        );
      },
    );
  }

  // sign user in method
  void signRestaurantUp() async {
    // try sign up
    try {
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        await FirebaseAuth.instance.currentUser
            ?.updateDisplayName(nameController.text);
        await FirebaseAuth.instance.currentUser?.updatePhotoURL(
            "https://i.pinimg.com/170x/3d/27/c1/3d27c1d91548b66bbe4d0610d9515615.jpg");

        // ignore: use_build_context_synchronously
        singSucces(context);
      } else {
        //las contraseñas son diferented
        showErrorMessage('Contraseñas diferentes!');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showErrorMessage('Correo ya en uso');
      } else if (e.code == 'unknown') {
        // show error to user
        showErrorMessage('Usuario desconocido');
      } else if (e.code == 'too-many-requests') {
        // show error to user
        showErrorMessage('Muchos intento fallidos');
      }
      // WRONG PASSWORD
      else if (e.code == 'weak-password') {
        // show error to user
        showErrorMessage('Contraseña debil');
      } else {
        showErrorMessage(e.code);
      }
    }
  }

  // error message
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25),
            ),
          ),
          backgroundColor: const Color.fromARGB(248, 255, 75, 90),
          title: Center(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white, fontFamily: 'Intel'),
            ),
          ),
        );
      },
    );
  }

  Future<void> subirRestaurante() async {
    final user = FirebaseAuth.instance.currentUser!;
    final database = FirebaseDatabase.instance.ref();
    Map<String, dynamic> data = {
      "name": user.displayName,
      "correo": user.email,
      "imageUrl": user.photoURL,
      "direccion": "",
      "descripcion": "",
      "calificacion": "5",
      "cantComidas": "",
    };
    final llave = user.uid;
    // Agrega el dato a la base de datos
    try {
      await database.child('Restaurantes').child(llave).set(data);
      log('Restaurante agregado a Firebase Realtime Database');
    } catch (e) {
      log('Error al agregar restaurante a Firebase Realtime Database: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Nombre del restaurante:",
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 16),
                child: TextFormField(
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
              ),
              const Text(
                "Correo:",
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 16),
                child: TextFormField(
                  controller: emailController,
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
                        Icons.email,
                        color: Color.fromRGBO(255, 64, 64, 1),
                      ),
                    ),
                  ),
                ),
              ),
              const Text(
                "Contraseña:",
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 16),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: true,
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
                        Icons.lock,
                        color: Color.fromRGBO(255, 64, 64, 1),
                      ),
                    ),
                  ),
                ),
              ),
              const Text(
                "Confirmar contraseña:",
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 16),
                child: TextFormField(
                  controller: confirmPasswordController,
                  obscureText: true,
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
                        Icons.lock,
                        color: Color.fromRGBO(255, 64, 64, 1),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 24),
                child: ElevatedButton.icon(
                  onPressed: () {
                    signRestaurantUp();
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
                    CupertinoIcons.hand_point_right_fill,
                    color: Color.fromARGB(255, 255, 252, 253),
                  ),
                  label: const Text(
                    "Registrar restaurante",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
        isShowLoading
            ? CustomPositioned(
                child: RiveAnimation.asset(
                  'assets/RiveAssets/check.riv',
                  fit: BoxFit.cover,
                  onInit: _onCheckRiveInit,
                ),
              )
            : const SizedBox(),
        isShowConfetti
            ? CustomPositioned(
                scale: 6,
                child: RiveAnimation.asset(
                  "assets/RiveAssets/confetti.riv",
                  onInit: _onConfettiRiveInit,
                  fit: BoxFit.cover,
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}

class CustomPositioned extends StatelessWidget {
  const CustomPositioned({super.key, this.scale = 1, required this.child});

  final double scale;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Column(
        children: [
          const Spacer(),
          SizedBox(
            height: 100,
            width: 100,
            child: Transform.scale(
              scale: scale,
              child: child,
            ),
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
