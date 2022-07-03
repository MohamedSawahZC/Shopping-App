// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/shared/components.dart';
import 'package:new_app/shared/cubit/states.dart';
import '../network/local/cashe_helper.dart';
import '../network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialStates());
  static ShopCubit get(context) => BlocProvider.of(context);


bool isLast= false;
//For check last index for indicator and page view to navigate to next page
  void isLastItem(int length,int? index){
    if(index==length-1){
      isLast = true;
    }else{
      isLast = false;
    }

    emit(ChangeIndicatorIndex());
  }

  void navigateTo(context, widget) {
    Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
    emit(NavigationTo());
  }


  void navigateAndFinish(context, widget) {
    Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
        (Route<dynamic> route) => false,
  );
    emit(NavigationAndFinish());
  }




}
