import 'package:flutter/material.dart';
import 'package:meals_app/model/meal_model.dart';
import 'package:meals_app/moduals/meal_screen_details/background_meal.dart';
import 'package:meals_app/moduals/meal_screen_details/meal_Info.dart';

import 'add_card.dart';

class MealScreenDetails extends StatelessWidget {
  MealModel? mealModel;
  MealScreenDetails(this.mealModel);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BackgroundMeal(imageUrl: mealModel!.image),
            MealInfo(
              title: mealModel!.title,
              description: mealModel!.description,
              mealCategory: mealModel!.mealCategory,
              mealId: mealModel!.mealId,
            ),
            AddCard(
              price: mealModel!.price,
            ),
          ],
        ),
      ),
    );
  }
}
