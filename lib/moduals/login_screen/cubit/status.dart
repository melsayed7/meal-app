

abstract class MealsLoginStates{}

class MealsLoginInitialState extends MealsLoginStates{}

class MealsLoginLoadingState extends MealsLoginStates{}

class MealsLoginSuccessState extends MealsLoginStates{
  final String uId ;
  MealsLoginSuccessState(this.uId);
}

class MealsLoginErrorState extends MealsLoginStates{
  final String error ;
  MealsLoginErrorState(this.error);
}

class MealsChangePasswordVisibilityState extends MealsLoginStates{}