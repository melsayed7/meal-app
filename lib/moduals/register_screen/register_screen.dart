import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meals_app/layout/meals_layout.dart';
import 'package:meals_app/moduals/register_screen/cubit/status.dart';

import '../widget/component.dart';
import 'cubit/cubit.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => MealsRegisterCubit(),
      child: BlocConsumer<MealsRegisterCubit , MealsRegisterStates>(
          listener: (context, state) {
            if(state is MealsCreateUserSuccessState)
              {
                navigateAndFinish(context, MealsLayout());
              }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(),
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
                            'REGISTER',
                            style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.black),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          Text(
                            'Register now to browse our hot offers',
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.grey),
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          defaultTextField(
                            controller: nameController,
                            type: TextInputType.name,
                            label: 'User Name',
                            prefix: Icons.person,
                            validate: (value){
                              if(value!.isEmpty)
                              {
                                return('please enter your Name');
                              }
                            },
                          ),
                          const SizedBox(
                            height: 15.0,
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
                            suffix: MealsRegisterCubit.get(context).suffix,
                            isPassword: MealsRegisterCubit.get(context).isPassword,
                            suffixPressed: (){
                              MealsRegisterCubit.get(context).changePasswordVisibility();
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
                          defaultTextField(
                            controller: phoneController,
                            type: TextInputType.phone,
                            label: 'Phone',
                            prefix: Icons.phone,
                            validate: (value){
                              if(value!.isEmpty)
                              {
                                return('please enter your phone number');
                              }
                            },
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          ConditionalBuilder(
                            condition:state is! MealsRegisterLoadingState ,
                            builder:(context) => defaultButton(
                              function: (){
                                 if(formKey.currentState!.validate())
                                  {
                                    MealsRegisterCubit.get(context).userRegister(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      phone: phoneController.text,
                                    );
                                  }
                              },
                              text: 'register',
                              isUppercase: true,
                            ),
                            fallback:(context) => const Center(child: CircularProgressIndicator()),
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
