import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meals_app/layout/cubit/cubit.dart';
import 'package:meals_app/layout/cubit/states.dart';
import 'package:meals_app/repos/cache_helper.dart';
import 'package:meals_app/repos/constant.dart';
import 'layout/meals_layout.dart';
import 'moduals/login_screen/login_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await CacheHelper.init();


  Widget widget ;

  uId = CacheHelper.getData(key: 'uId');

  if(uId != null)
  {
    widget =MealsLayout();
  }else
  {
    widget =LoginScreen();
  }

  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  final Widget startWidget ;

  MyApp(this.startWidget );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MealsCubit(),
      child: BlocConsumer<MealsCubit , MealsStates>(
       listener: (context, state) {},
        builder: (context,state)
        { return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: MealsCubit.get(context).lightTheme ? ThemeData.light() : ThemeData.dark(),
          home: startWidget,
        );},
      ),
    );
  }
}

