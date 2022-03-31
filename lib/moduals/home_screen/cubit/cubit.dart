import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meals_app/moduals/home_screen/cubit/status.dart';

import '../../../model/meal_model.dart';

class MealsHomeCubit extends Cubit<MealsHomeStates> {
  MealsHomeCubit() : super(MealsHomeInitialState());

  static MealsHomeCubit get(context) => BlocProvider.of(context);

  late List<MealModel> list;

  Future<void> getMeal() async {
    emit(MealsHomeLoadingState());
    await FirebaseFirestore.instance
        .collection('meals')
        .get()
        .then((value) {
      list = [];
      value.docs.map((s) => list.add(MealModel.fromJson(s.data()))).toList();
      emit(MealsHomeSuccessState(list));
    }).catchError((error) {
      emit(MealsHomeErrorState(error.toString()));
    });
  }


}
