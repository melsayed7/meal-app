import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meals_app/model/user_model.dart';
import 'package:meals_app/moduals/register_screen/cubit/status.dart';

class MealsRegisterCubit extends Cubit<MealsRegisterStates> {
  MealsRegisterCubit() : super(MealsRegisterInitialState());

  static MealsRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(MealsRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      print(value.user!.uid);
      print(value.user!.email);
      userCreate(
        uId: value.user!.uid,
        name: name,
        email: email,
        phone: phone,
      );
      //emit(MealsRegisterSuccessState());
    }).catchError((error) {
      emit(MealsRegisterErrorState(error.toString()));
    });
  }

  void userCreate({
    required String name,
    required String email,
    required String uId,
    required String phone,
  }) {
    MealsUserModel model = MealsUserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      fav: [],
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(MealsCreateUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(MealsCreateUserErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(MealsRegisterChangePasswordVisibilityState());
  }
}
