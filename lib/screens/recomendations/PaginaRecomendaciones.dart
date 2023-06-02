import 'package:flutter/material.dart';
import 'package:rive_animation/screens/Admin/home/components/home_greetings.dart';

import '../../core/components/search_box.dart';
import 'components/suggestion.dart';

class RecomendationPage extends StatelessWidget {
  const RecomendationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            //SearchBox(),

            HomeSuggestionSectionRestaurants(),

            SizedBox(height: 70),
          ],
        ),
      ),
    );
  }
}
