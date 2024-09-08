import 'package:flutter/material.dart';
import 'package:mealsapp/models/meal.dart';
import 'package:mealsapp/screens/meal_details.dart';

class MealCard extends StatelessWidget {
  const MealCard({Key? key, required this.meal}) : super(key: key);
  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (ctx) => MealDetails(meal: meal)));
      },
      child: Card(
        // Meal'ların resmi, içindekileri, açıklaması vs.
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(meal.name),
        ),
      ),
    );
  }
}
