
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meals_app/moduals/favorite_screen/cubit/states.dart';

import '../../../model/meal_model.dart';
import '../../../model/user_model.dart';


class MealFavoriteCubit extends Cubit<MealFavoriteStates>
{
  MealFavoriteCubit() : super(MealFavoriteInitialState());

  static MealFavoriteCubit get (context) => BlocProvider.of(context);

  late List<MealModel> list;
  late List<MealModel> favList =[];

  Future<void> getMeal() async {
    await FirebaseFirestore.instance
        .collection('meals')
        .get()
        .then((value) {
      list = [];
      value.docs.map((s) => list.add(MealModel.fromJson(s.data()))).toList();
    }).catchError((error) {
    });
  }

  Future<void> getFavMeals()async{
    //emit(MealFavoriteLoadingState());
    final auth =FirebaseAuth.instance.currentUser;
    var currentUser = auth!.uid;
    final userData = await FirebaseFirestore.instance.collection('users').doc(currentUser).get();
    MealsUserModel data= MealsUserModel.fromJson(userData.data());
    data.fav!.forEach((element) {
      favList.add(list.firstWhere((meal) => meal.mealId == element));
      print('our list ${favList.length}');
    });

  }
}