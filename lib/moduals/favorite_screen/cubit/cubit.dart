
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meals_app/moduals/favorite_screen/cubit/states.dart';

import '../../../model/meal_model.dart';
import '../../../model/user_model.dart';
import '../../widget/component.dart';


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
      print(list);
    }).catchError((error) {});
  }

  Future<void> getFavMeals()async{
    emit(MealFavoriteLoadingState());
    final auth =FirebaseAuth.instance.currentUser;
    var currentUser = auth!.uid;

    FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser)
        .get()
        .then((value){
          MealsUserModel data= MealsUserModel.fromJson(value.data());
          for (var element in data.fav!) {
            favList.add(list.firstWhere((meal) => element == meal.mealId ));
            emit(MealFavoriteSuccessState(favList));
      }
    }).catchError((error){
      emit(MealFavoriteErrorState(error.toString()));
    });
  }

  bool isFavourite(String mealId) {
    return favList.any((element) => element.mealId == mealId);
  }
}