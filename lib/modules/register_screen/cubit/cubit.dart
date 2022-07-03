import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/modules/register_screen/cubit/states.dart';
import 'package:new_app/shared/network/end_points.dart';

import '../../../models/login_model.dart';
import '../../../shared/network/remote/dio_helper.dart';
import '../../login_screen/cubit/states.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialStates());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility(){
    isPassword = !isPassword;
    suffix = isPassword? Icons.visibility_outlined :  Icons.visibility_off_outlined  ;
    emit(RegisterChangePasswordVisibility());
  }

  LoginModel? loginModel;
  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }){
    emit(ShopRegisterLoadingStates());
    DioHelper.postData(
      url: REGISTER,
      data: {
        'name':name,
        'phone':phone,
        'email':email,
        'password':password,
      },
    ).then((value) => {
      print(value.data ),
      loginModel = LoginModel.fromJson(value.data),
      emit(ShopRegisterSucessStates(loginModel!))
    }).catchError((error)=>{
      print(error.toString() + "-------------------"),
      emit(ShopRegisterErrorStates(error.toString())),
    });
  }


}