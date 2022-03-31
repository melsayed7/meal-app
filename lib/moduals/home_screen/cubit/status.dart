import '../../../model/meal_model.dart';

abstract class MealsHomeStates {}

class MealsHomeInitialState extends MealsHomeStates {}

class MealsHomeLoadingState extends MealsHomeStates {}

class MealsHomeSuccessState extends MealsHomeStates {
  final List<MealModel> mealModel;
  MealsHomeSuccessState(this.mealModel);
}

class MealsHomeErrorState extends MealsHomeStates {
  final String error;
  MealsHomeErrorState(this.error);
}

