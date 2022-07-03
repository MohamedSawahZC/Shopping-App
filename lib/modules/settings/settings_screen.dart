import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/layouts/cubit/cubit.dart';
import 'package:new_app/modules/login_screen/cubit/cubit.dart';
import 'package:new_app/modules/login_screen/cubit/cubit.dart';
import 'package:new_app/modules/login_screen/cubit/states.dart';

import '../../shared/colors.dart';
import '../../shared/components.dart';
import '../login_screen/cubit/cubit.dart';

class SettingsScreen extends StatelessWidget {
var nameController = TextEditingController();
var emailController = TextEditingController();
var phoneController = TextEditingController();
var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener: (context,state){
            if(state is UpdateUserSucessStates){
              showToast(message: 'تم التعديل بنجاح', state: ToastStates.SUCESS);
            }
        },
      builder: (context,state){
          return ConditionalBuilder(
            condition: state is ProfileSucessStates || state is UpdateUserSucessStates,
            builder: (context) {
              var model = ShopLoginCubit.get(context).profileModel;
              nameController.text=model!.data!.name!;
              emailController.text=model.data!.email!;
              phoneController.text=model.data!.phone!;
              var image=model.data?.image;
              return SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      if(state is UpdateUserLoadingStates)
                        LinearProgressIndicator(),
                      SizedBox(
                        height: 10,
                      ),
                      CircleAvatar(
                        radius: 35,
                        backgroundImage:NetworkImage(
                          '$image',
                        ) ,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'الصورة الشخصية'
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
                          Icons.lock,
                          color: Colors.white,
                        ),
                        textFieldController: phoneController,
                        validateTextField: (String? val) {
                          if (val!.isEmpty) {
                            return 'يرحي ادخال البريد الهاتف';
                          }
                          return null;
                        },
                        labelText: 'رقم الهاتف',
                        hintText: 'يرجي ادخال رقم الهاتف',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defaultButton(
                        radius: 3.0,
                        function: () {
                          ShopLoginCubit.get(context).updateProfileData(
                              name: nameController.text,
                              phone: phoneController.text,
                              email: emailController.text,
                          );
                        },
                        text: 'تحديث الملف الشخصي',
                        isUpperCase: true,
                        background: Colors.green,
                        buttonWidth: double.infinity,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defaultButton(
                        radius: 3.0,
                        function: () {
                          signOut(context);
                        },
                        text: 'تسجيل الخروج',
                        isUpperCase: true,
                        background: Colors.blue,
                        buttonWidth: double.infinity,
                      ),

                    ],
                  ),
                ),
              ),
            );
            },
            fallback: (context)=> Center(child: CircularProgressIndicator(),),
          );
      },

    );
  }
}
