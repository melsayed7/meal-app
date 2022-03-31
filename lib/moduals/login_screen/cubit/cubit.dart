import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meals_app/moduals/widget/component.dart';

import '../../../moduals/login_screen/cubit/status.dart';





class MealsLoginCubit extends Cubit<MealsLoginStates>
{
  MealsLoginCubit() : super(MealsLoginInitialState());

  static MealsLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String email ,
    required String password ,
})
  {
    emit(MealsLoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
        email: email,
        password: password,)
        .then((value) {
      print(value.user!.uid);
      print(value.user!.email);
      print('login successfully');
      showToast(text: 'login successfully', state: ToastStates.SUCCESS);
          emit(MealsLoginSuccessState(value.user!.uid));
    })
        .catchError((error){
          emit(MealsLoginErrorState(error.message.toString()));
    });
  }
  IconData suffix = Icons.visibility_outlined ;
  bool isPassword = true ;

  void changePasswordVisibility()
  {
    isPassword = !isPassword ;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined ;

    emit(MealsChangePasswordVisibilityState());
  }

}