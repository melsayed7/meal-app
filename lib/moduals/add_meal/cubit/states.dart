abstract class AddMealStates{}

class AddMealsInitialState extends AddMealStates {}

class MealImagePickedSuccessState extends AddMealStates {}

class MealImagePickedErrorState extends AddMealStates {}

class MealCreatedLoadingState extends AddMealStates {}

class MealCreatedSuccessState extends AddMealStates {
  final String successMessage;
  MealCreatedSuccessState(this.successMessage);
}

class MealCreatedErrorState extends AddMealStates {
  final String error;

  MealCreatedErrorState(this.error);
}

class UploadMealImageSuccessState extends AddMealStates {
  String imageURL;
  UploadMealImageSuccessState(this.imageURL);
}

class UploadMealImageErrorState extends AddMealStates {
  String error;
  UploadMealImageErrorState(this.error);
}

