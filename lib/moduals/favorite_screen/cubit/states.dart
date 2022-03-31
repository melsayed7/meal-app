abstract class MealFavoriteStates {}

class MealFavoriteInitialState extends MealFavoriteStates {}

class MealFavoriteLoadingState extends MealFavoriteStates {}

class MealFavoriteSuccessState extends MealFavoriteStates {
  final String favorite;
  MealFavoriteSuccessState(this.favorite);
}

class MealFavoriteErrorState extends MealFavoriteStates {
  final String error;

  MealFavoriteErrorState(this.error);
}