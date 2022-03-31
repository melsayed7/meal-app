
abstract class MealsRegisterStates{}

class MealsRegisterInitialState extends MealsRegisterStates{}

class MealsRegisterLoadingState extends MealsRegisterStates{}

class MealsRegisterSuccessState extends MealsRegisterStates{}

class MealsRegisterErrorState extends MealsRegisterStates{
  final String error ;
  MealsRegisterErrorState(this.error);
}

class MealsCreateUserLoadingState extends MealsRegisterStates{}

class MealsCreateUserSuccessState extends MealsRegisterStates{}

class MealsCreateUserErrorState extends MealsRegisterStates{
  final String error ;
  MealsCreateUserErrorState(this.error);
}

class MealsRegisterChangePasswordVisibilityState extends MealsRegisterStates{}