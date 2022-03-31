import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meals_app/model/meal_model.dart';
import 'package:meals_app/moduals/home_screen/cubit/cubit.dart';

import '../meal_screen_details/meal_screen_details.dart';
import 'cubit/status.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MealsHomeCubit()..getMeal(),
      child: BlocConsumer<MealsHomeCubit, MealsHomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          MealsHomeCubit cubit = MealsHomeCubit.get(context);
          if (state is MealsHomeLoadingState) {
            return const Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              ),
            );
          }
          else if (state is MealsHomeSuccessState) {
            if (cubit.list.isNotEmpty == true) {
              return ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return buildMealItem(cubit.list[index], context);
                },
                separatorBuilder: (context, index) =>
                    const Divider(thickness: 1, color: Colors.black),
                itemCount: cubit.list.length,
              );
            } else {
              return const Center(
                child: Text('No Data'),
              );
            }
          }
          else if (state is MealsHomeErrorState) {
            return const Center(
              child: Text('error'),
            );
          }
          else {
            return Container(
              color: Colors.white,
            );
          }
        },
      ),
    );
  }

  Widget buildMealItem(MealModel? mealModel, context) => InkWell(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
                  builder: (context) => MealScreenDetails(mealModel)))
                   .then((value) => MealsHomeCubit()..getMeal());
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey,
                  image: DecorationImage(
                    image: NetworkImage(mealModel?.image ?? ''),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          '${mealModel?.title}',
                          style: const TextStyle(
                            backgroundColor: Colors.black38,
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          '${mealModel?.mealCategory}',
                          style: const TextStyle(
                            backgroundColor: Colors.black38,
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );

}
