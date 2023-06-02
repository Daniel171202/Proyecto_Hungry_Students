import 'package:flutter/material.dart';

import '../../../core/constants/constants.dart';

class FoodDescription extends StatefulWidget {
  const FoodDescription({
    Key? key,
    required this.description,
  }) : super(key: key);
  final String description;
  @override
  State<FoodDescription> createState() => _FoodDescriptionState();
}

class _FoodDescriptionState extends State<FoodDescription> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDefaults.padding,
        vertical: AppDefaults.padding / 2,
      ),
      child: Text(
        widget.description,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.grey,
              height: 1.5,
            ),
      ),
    );
  }
}
