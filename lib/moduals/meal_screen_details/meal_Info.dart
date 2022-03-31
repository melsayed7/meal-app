import 'package:flutter/material.dart';
import 'package:meals_app/moduals/widget/component.dart';
import '../../layout/cubit/cubit.dart';
import '../../model/meal_model.dart';
import '../favorite_screen/cubit/cubit.dart';

class MealInfo extends StatelessWidget {
  String? title;
  String? description;
  String? mealCategory;
  String? mealId;
  MealModel? mealModel;

  MealInfo({
    required this.title,
    required this.description,
    required this.mealCategory,
    required this.mealId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  '$title',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              CircleAvatar(
                backgroundColor: Colors.grey.withOpacity(.3),
                child: IconButton(
                  onPressed: () {
                    MealsCubit.get(context).addFavorite(mealId!);
                    showToast(
                        text: 'Meal Add to Favorite',
                        state: ToastStates.SUCCESS);
                  },
                  icon: const Icon(
                    Icons.favorite_outline,
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Text(
                'Meal Category',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                width: 40,
              ),
              Text(
                '$mealCategory',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Text(
                'Meal Description',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                width: 40,
              ),
              Text(
                '$description',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Text(
                'Quantity',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                width: 40,
              ),
              CircleAvatar(
                backgroundColor: Colors.grey.withOpacity(.3),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.remove_circle),
                ),
              ),
              const SizedBox(
                width: 40,
              ),
              const Text(
                '1',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                width: 40,
              ),
              CircleAvatar(
                backgroundColor: Colors.grey.withOpacity(.3),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add_circle),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
