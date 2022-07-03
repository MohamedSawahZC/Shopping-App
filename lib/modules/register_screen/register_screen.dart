

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/models/boarding_classes.dart';
import 'package:new_app/modules/login_screen/login_screen.dart';
import 'package:new_app/modules/register_screen/cubit/cubit.dart';
import 'package:new_app/modules/register_screen/cubit/states.dart';
import 'package:new_app/shared/components.dart';
import 'package:new_app/shared/cubit/cubit.dart';
import 'package:new_app/shared/cubit/states.dart';
import 'package:new_app/shared/network/local/cashe_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../layouts/home_screen.dart';
import '../../shared/colors.dart';
import '../../shared/constants.dart';

class RegisterScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
      listener: (context, state) {
        if (state is ShopRegisterSucessStates) {
          if (state.loginModel.status==true) {
            CasheHelper.saveData(key: 'token', value: state.loginModel.data?.token).then((value) =>
            {
              token = state.loginModel.data?.token,
             navigateAndFinish(context, HomeScreen()),
            showToast(message: state.loginModel.message!, state: ToastStates.SUCESS)
            });
          } else {
            showToast(
              message:state.loginModel.message!,
              state: ToastStates.ERROR,
            );
          }
        }
      },
      builder: (context,state){
        var nameController = TextEditingController();
        var emailController = TextEditingController();
        var phoneController = TextEditingController();
        var passwordController = TextEditingController();
        var formKey = GlobalKey<FormState>();
        ShopRegisterCubit cubit = ShopRegisterCubit.get(context);
        return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
            body: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    children: [
                      const Center(
                        child: Text(
                          'التسجيل',
                          style: TextStyle(
                            fontSize: 40,
                            color: defColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      ModTextFormField(
                        filledColor: defColor!,
                        prefixWidget: const Icon(
                          Icons.account_circle,
                          color: Colors.white,
                        ),
                        textFieldController: nameController,
                        validateTextField: (String? val) {
                          if (val!.isEmpty) {
                            return 'يرحي ادخال الأسم';
                          }
                          return null;
                        },
                        labelText: 'الأسم',
                        hintText: 'يرجي ادخال الأسم',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ModTextFormField(
                        filledColor: defColor!,
                        prefixWidget: const Icon(
                          Icons.email,
                          color: Colors.white,
                        ),
                        textFieldController: emailController,
                        validateTextField: (String? val) {
                          if (val!.isEmpty) {
                            return 'يرحي ادخال البريد الألكتروني';
                          }
                          return null;
                        },
                        labelText: 'البريد الألكتروني',
                        hintText: 'يرجي ادخال البريد الألكتروني',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ModTextFormField(
                        filledColor: defColor!,
                        prefixWidget: const Icon(
                          Icons.phone_enabled,
                          color: Colors.white,
                        ),
                        textFieldController: phoneController,
                        validateTextField: (String? val) {
                          if (val!.isEmpty) {
                            return 'يرحي ادخال رقم الهاتف';
                          }
                          return null;
                        },
                        labelText: 'رقم الهاتف',
                        hintText: 'يرجي ادخال رقم الهاتف',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ModTextFormField(
                        filledColor: defColor!,
                        prefixWidget: const Icon(
                          Icons.lock,
                          color: Colors.white,
                        ),
                        suffixWidget: IconButton(
                          onPressed: (){
                           //cubit.changePasswordVisibility();
                          },
                          icon: Icon(
                            cubit.suffix,
                            color: Colors.white,
                          ),
                        ),
                        textFieldController: passwordController,
                        validateTextField: (String? val) {
                          if (val!.isEmpty) {
                            return 'يرحي ادخال الرقم السري';
                          } else if (val.length < 6) {
                            return 'الرقم السري قصير';
                          }
                          return null;
                        },
                        labelText: 'الرقم السري',
                        hintText: 'يرجي ادخال الرقم السري',
                        isSecure: cubit.isPassword,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ConditionalBuilder(
                        condition: state is! ShopRegisterLoadingStates,
                        builder: (context) => defaultButton(
                          radius: 3.0,
                          function: () {
                            if (formKey.currentState!.validate()) {
                              cubit.userRegister(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name: nameController.text,
                                  phone: phoneController.text,
                              );
                              if(state is ShopRegisterSucessStates){
                                navigateTo(context, HomeScreen());
                              }
                            }
                          },
                          text: 'التسجيل',
                          isUpperCase: true,
                          background: Colors.blue,
                          buttonWidth: double.infinity,
                        ),
                        fallback: (context) =>
                        const Center(child: CircularProgressIndicator()),
                      ),
                    ],
                  ),
                ),
              ),
            )
        );
      },
    );
  }
}