
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meals_app/layout/cubit/states.dart';
import 'package:meals_app/moduals/favorite_screen/favorite_screen.dart';
import 'package:meals_app/moduals/home_screen/home_screen.dart';
import 'package:meals_app/moduals/login_screen/login_screen.dart';
import 'package:meals_app/moduals/widget/component.dart';

import '../../model/meal_model.dart';
import '../../model/user_model.dart';


class MealsCubit extends Cubit<MealsStates> {
  MealsCubit() : super(MealsInitialState());

  static MealsCubit get(context) => BlocProvider.of(context);

  List<Widget> screen =
  [
    HomeScreen(),
    FavoriteScreen(),
  ];

  List<String> title = [
    'Meals',
    'Favorites',
  ];

  int currentIndex = 0;

  void changeNavBar(int index)
  {
    currentIndex = index;
    if (index == 0) {
      HomeScreen();
    } else {
      FavoriteScreen();
    }
    emit(MealsChangeNavBar());
  }

  bool lightTheme = true;

  void switchTheme() {
    lightTheme = !lightTheme;
    emit(ChangeThemeModeState());
  }

  void logout(context) {
    FirebaseAuth.instance.signOut().then((value) {
      emit(LogOutSuccessState());
      navigateAndFinish(context, LoginScreen());
    }).catchError((error) {
      emit(LogOutErrorState(error.message.toString()));
    });
  }


   List<String> favorite =[];

  Future<void> addFavorite(String id) async
  {
    final auth =FirebaseAuth.instance.currentUser;
    var currentUser = auth!.uid;
    final userData=await FirebaseFirestore.instance.collection('users').doc(currentUser).get();
    MealsUserModel data=MealsUserModel.fromJson(userData.data());
    favorite=data.fav!;
    if(favorite.contains(id)){
      showToast(text: 'meal already in favorite ', state: ToastStates.SUCCESS );
    }else{
      favorite.add(id);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser)
          .update({'fav':favorite})
          .then((value){
        print('add to fav');
      }).catchError((error){});
    }
  }


}
