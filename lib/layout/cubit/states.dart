import '../../model/meal_model.dart';

abstract class MealsStates {}

class MealsInitialState extends MealsStates {}

class MealsChangeNavBar extends MealsStates {}

class OnChangeModeState extends MealsStates {}

class ChangeThemeModeState extends MealsStates {}

class LogOutSuccessState extends MealsStates {}

class LogOutErrorState extends MealsStates {
  String error;
  LogOutErrorState(this.error);
}

class MealFavoriteLoadingState extends MealsStates {}

class MealFavoriteSuccessState extends MealsStates {
  final String favorite;
  MealFavoriteSuccessState(this.favorite);
}

class MealFavoriteErrorState extends MealsStates {
  final String error;

  MealFavoriteErrorState(this.error);
}

