import '../../../model/meal_model.dart';

abstract class MealFavoriteStates {}

class MealFavoriteInitialState extends MealFavoriteStates {}

class MealFavoriteLoadingState extends MealFavoriteStates {}

class MealFavoriteSuccessState extends MealFavoriteStates {
  final List<MealModel> mealModel;
  MealFavoriteSuccessState(this.mealModel);
}

class MealFavoriteErrorState extends MealFavoriteStates {
  final String error;

  MealFavoriteErrorState(this.error);
}