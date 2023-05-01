import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';

class HomeGreetings extends StatelessWidget {
  const HomeGreetings({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDefaults.padding),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /*Text(
              'Bienvenido, Pipocas Cato',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: Colors.grey),
            ),*/
            const SizedBox(height: 8),
            Text(
              'Bienvenido, Pipocas Cato',
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  ?.copyWith(fontWeight: FontWeight.bold, color: Color.fromARGB(255,255,64,77), fontSize: 25),
            ),
          ],
        ),
      ),
    );
  }
}