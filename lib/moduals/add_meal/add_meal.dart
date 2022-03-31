import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meals_app/moduals/add_meal/cubit/cubit.dart';
import 'package:meals_app/moduals/widget/component.dart';

import 'cubit/states.dart';

class AddMeal extends StatelessWidget {
  AddMeal({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var desController = TextEditingController();
  var mealCategoryController = TextEditingController();
  var noMealsController = TextEditingController();
  var priceController = TextEditingController();
  var imageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddMealCubit(),
      child: BlocConsumer<AddMealCubit, AddMealStates>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is UploadMealImageSuccessState) {
            AddMealCubit.get(context).mealCreate(
              image: state.imageURL,
              title: titleController.text,
              description: desController.text,
              mealCategory: mealCategoryController.text,
              numOfMeals: noMealsController.text,
              price: priceController.text,
            );
          } else if (state is UploadMealImageErrorState) {
            showToast(text: state.error, state: ToastStates.ERROR);
          } else if (state is MealCreatedSuccessState) {
            showToast(text: state.successMessage, state: ToastStates.SUCCESS);
          } else if (state is MealCreatedErrorState) {
            showToast(text: state.error, state: ToastStates.ERROR);
          }

          var mealImage = AddMealCubit.get(context).mealImage;

          return Scaffold(
            appBar: AppBar(
                title: const Text('Add New Meal'),
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                )),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      defaultTextField(
                          controller: titleController,
                          type: TextInputType.text,
                          label: 'Title',
                          prefix: Icons.title,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return ('enter Title');
                            }
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultTextField(
                          controller: desController,
                          type: TextInputType.text,
                          label: 'Description',
                          prefix: Icons.description,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return ('enter Description');
                            }
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultTextField(
                          controller: mealCategoryController,
                          type: TextInputType.text,
                          label: 'Meal Category',
                          prefix: Icons.menu,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return ('enter Meal Category');
                            }
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultTextField(
                        controller: noMealsController,
                        type: TextInputType.text,
                        label: 'No Meals',
                        prefix: Icons.image,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return ('Number of meals must not empty');
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultTextField(
                          controller: priceController,
                          type: TextInputType.text,
                          label: 'Price',
                          prefix: Icons.price_change,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return ('enter price');
                            }
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      Align(
                        child: Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            if (mealImage != null)
                              Container(
                                  height: 140.0,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                    image: DecorationImage(
                                      image: mealImage == null
                                          ? const NetworkImage('')
                                          : FileImage(mealImage) as ImageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                            IconButton(
                              onPressed: () {
                                AddMealCubit.get(context).getMealImage();
                              },
                              icon: const CircleAvatar(
                                  radius: 20.0,
                                  child: Icon(
                                    Icons.camera_alt,
                                    size: 16.0,
                                  )),
                            ),
                          ],
                        ),
                        alignment: AlignmentDirectional.topCenter,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ConditionalBuilder(
                        condition: state is! MealCreatedLoadingState,
                        builder: (context) => defaultButton(
                            text: 'Save',
                            function: () {
                              if (formKey.currentState!.validate()) {
                                AddMealCubit.get(context).uploadMealImage();
                              }
                            }),
                        fallback: (context) =>
                            const Center(child: CircularProgressIndicator()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
