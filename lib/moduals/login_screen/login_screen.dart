import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/meals_layout.dart';
import '../../moduals/login_screen/cubit/status.dart';
import '../../repos/cache_helper.dart';
import '../register_screen/register_screen.dart';
import '../widget/component.dart';
import 'cubit/cubit.dart';


class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MealsLoginCubit(),
      child: BlocConsumer<MealsLoginCubit , MealsLoginStates>(
        listener: (context, state) {
          if(state is MealsLoginErrorState)
            {
              showToast(text: state.error, state: ToastStates.ERROR);
            }
          if( state is MealsLoginSuccessState)
          {
            CacheHelper.saveData(
              key: 'uId',
              value: state.uId,
            ).then((value)
            {
              navigateAndFinish(context, MealsLayout());
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LOGIN',
                        style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.black),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        'Login now to browse our hot offers',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      defaultTextField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        label: 'Email Address',
                        prefix: Icons.email_outlined,
                        validate: (value){
                          if(value!.isEmpty)
                          {
                            return('please enter your email address');
                          }
                        },
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      defaultTextField(
                        controller: passwordController,
                        type: TextInputType.visiblePassword,
                        suffix: MealsLoginCubit.get(context).suffix,
                        isPassword: MealsLoginCubit.get(context).isPassword,
                        suffixPressed: (){
                          MealsLoginCubit.get(context).changePasswordVisibility();
                        },
                        label: 'Password',
                        prefix: Icons.lock_outlined,
                        validate: (value){
                          if(value!.isEmpty)
                          {
                            return('password is too short');
                          }
                        },
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      ConditionalBuilder(
                        condition: state is! MealsLoginLoadingState ,
                        builder:(context) => defaultButton(
                          function: (){
                            if(formKey.currentState!.validate())
                            {
                              MealsLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          text: 'login',
                          isUppercase: true,
                        ),
                        fallback:(context) => const Center(child: CircularProgressIndicator()),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                              'Don\'t have an account?'
                          ),
                          defaultTextButton(
                            function: (){
                              navigateTO(context, RegisterScreen());
                            },
                            text: 'register',
                          ),
                        ],
                      ),
                    ],
                  ),
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
