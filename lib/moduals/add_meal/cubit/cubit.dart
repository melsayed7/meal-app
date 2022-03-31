import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meals_app/moduals/add_meal/cubit/states.dart';
import 'package:meals_app/moduals/widget/component.dart';

import '../../../model/meal_model.dart';

class AddMealCubit extends Cubit<AddMealStates>
{
  AddMealCubit() : super(AddMealsInitialState());

  static AddMealCubit get(context) => BlocProvider.of(context);

  MealModel? model;

  void mealCreate({
    required String image,
    required String title,
    required String mealCategory,
    required String description,
    required String numOfMeals,
    required String price,
  }) async
  {
    emit(MealCreatedLoadingState());
    CollectionReference ref = FirebaseFirestore.instance.collection('meals');
    String id=ref.doc().id;
    await ref.doc(id)
        .set( {
          'image' : image ,
          'title' : title ,
          'description' : description ,
          'mealCategory' : mealCategory ,
          'numOfMeals' : numOfMeals ,
          'price' : price ,
          'mealId':id,
        }).then((value) {
      emit(MealCreatedSuccessState("Meal is uploaded successfully"));
    }).catchError((error) {
      emit(MealCreatedErrorState(error.toString()));
    });
  }


  File? mealImage;

  var picker = ImagePicker();

  Future<void> getMealImage() async
  {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      mealImage = File(pickedFile.path);
      emit(MealImagePickedSuccessState());
    } else {
      emit(MealImagePickedErrorState());
      showToast(text: 'No Image Selected', state: ToastStates.ERROR);
      print('No Image Selected');
    }
  }

  void uploadMealImage()
  {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('images/${Uri.file(mealImage!.path).pathSegments.last}')
        .putFile(mealImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(UploadMealImageSuccessState(value.toString()));
        print(value);
      }).catchError((error) {
        emit(UploadMealImageErrorState(error.message.toString()));
      });
    }).catchError((error) {
      emit(UploadMealImageErrorState(error.message.toString()));
    });
  }

}