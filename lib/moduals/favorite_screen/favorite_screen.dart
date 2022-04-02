import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/meal_model.dart';
import '../home_screen/cubit/cubit.dart';
import '../home_screen/cubit/status.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MealFavoriteCubit()..getMeal()..getFavMeals(),
      child: BlocConsumer<MealFavoriteCubit , MealFavoriteStates>(
        listener: (context, state) {},
        builder: (context,state)
        {
          var cubit = MealFavoriteCubit.get(context);
          if(state is MealFavoriteLoadingState) {
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
          else if (state is MealFavoriteSuccessState) {
              return ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return buildFavItem(cubit.favList[index]);
                },
                separatorBuilder: (context, index) =>
                const Divider(thickness: 1, color: Colors.black),
                itemCount: cubit.favList.length,
              );
            }
          else if (state is MealFavoriteErrorState) {
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

  Widget buildFavItem (MealModel? mealModel) => Padding (
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Container(
          width: 120.0,
          height: 120.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              image: NetworkImage('${mealModel!.image}'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 18.0,),
        Expanded(
          child: SizedBox(
            height: 120.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                 Expanded(
                  child: Text(
                    '${mealModel.mealCategory}',
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${mealModel.title}',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    Expanded(
                      child: CircleAvatar(
                        backgroundColor: Colors.grey.withOpacity(.3),
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.favorite, color: Colors.red),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
