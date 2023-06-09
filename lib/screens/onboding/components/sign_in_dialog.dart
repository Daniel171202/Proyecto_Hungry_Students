import 'package:flutter/material.dart';
//import 'package:rive_animation/model/menu.dart'; -----> no esta en uso
import 'package:rive_animation/screens/onboding/onboding_screen.dart';
//import 'package:flutter_svg/flutter_svg.dart'; ----> no se esta usando

import 'sign_in_form.dart';

void showCustomDialogIn(BuildContext context, {required ValueChanged onValue}) {
  showGeneralDialog(
    context: context,
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 400),
    pageBuilder: (_, __, ___) {
      return Center(
        child: Container(
          height: 500,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.95),
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                offset: const Offset(0, 30),
                blurRadius: 60,
              ),
              const BoxShadow(
                color: Colors.black45,
                offset: Offset(0, 30),
                blurRadius: 60,
              ),
            ],
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              clipBehavior: Clip.none,
              children: [
                Column(
                  children: const [
                    Text(
                      "Ingresar",
                      style: TextStyle(
                        fontSize: 34,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        "Bienvenido de nuevo",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SignInForm(),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const OnbodingScreen(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
    transitionBuilder: (_, anim, __, child) {
      Tween<Offset> tween;
      // if (anim.status == AnimationStatus.reverse) {
      //   tween = Tween(begin: const Offset(0, 1), end: Offset.zero);
      // } else {
      //   tween = Tween(begin: const Offset(0, -1), end: Offset.zero);
      // }

      tween = Tween(begin: const Offset(0, -1), end: Offset.zero);

      return SlideTransition(
        position: tween.animate(
          CurvedAnimation(parent: anim, curve: Curves.easeInOut),
        ),
        // child: FadeTransition(
        //   opacity: anim,
        //   child: child,
        // ),
        child: child,
      );
    },
  ).then(onValue);
}
