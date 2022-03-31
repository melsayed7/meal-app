import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meals_app/layout/cubit/cubit.dart';
import 'package:meals_app/layout/cubit/states.dart';

import '../moduals/add_meal/add_meal.dart';
import '../moduals/widget/component.dart';

class MealsLayout extends StatelessWidget {
  const MealsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MealsCubit, MealsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = MealsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.title[cubit.currentIndex]),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.language)),
              IconButton(
                  onPressed: () {
                    cubit.switchTheme();
                  },
                  icon: const Icon(Icons.brightness_4_outlined)),
              IconButton(
                  onPressed: () {
                    cubit.logout(context);
                  },
                  icon: const Icon(Icons.logout)),
            ],
          ),
          body: cubit.screen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: MealsCubit.get(context).currentIndex,
            onTap: (index) {
              MealsCubit.get(context).changeNavBar(index);
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: 'Favorites'),
            ],
          ),
          floatingActionButton: cubit.currentIndex == 0
              ? FloatingActionButton(
                  onPressed: () {
                    navigateTO(context, AddMeal());
                  },
                  child: const Icon(Icons.add),
                )
              : null,
        );
      },
    );
  }
}
