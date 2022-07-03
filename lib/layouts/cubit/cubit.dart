import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/layouts/cubit/states.dart';
import 'package:new_app/models/home_model.dart';
import 'package:new_app/modules/cateogries/cateogries_screen.dart';
import 'package:new_app/modules/favourite/favourite_screen.dart';
import 'package:new_app/modules/products/products_screen.dart';
import 'package:new_app/modules/settings/settings_screen.dart';
import 'package:new_app/shared/network/end_points.dart';
import 'package:new_app/shared/network/remote/dio_helper.dart';

import '../../models/add_favorites_model.dart';
import '../../models/categories_model.dart';
import '../../models/favorites_model.dart';
import '../../models/login_model.dart';
import '../../shared/constants.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialStates());

  static HomeCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    ProductsScreen(),
    CateogriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom (int index){
    currentIndex = index;
    emit(ChangeBottomNavState());
  }
  Map<dynamic,dynamic> favorites = {};

  HomeModel? homeModel;
  void getHomeData()async{
    emit(HomeLoadingStates());
    await  DioHelper.getData(
      url:HOME,
      token: token,
    ).then((value){
      homeModel=HomeModel.fromJson(value.data);
      print(homeModel?.data?.banners![0].image);
      homeModel?.data?.products?.forEach((element) {

        favorites.addAll({
         element.id : element.inFavorites,
        });

      });
      emit(HomeSucessStates());
    }).catchError((error){
      print(error.toString());
      emit(HomeErrorStates());
    });
  }
  int activeIndex=0;

  void changeCurrentIndex(index) {

    activeIndex = index;

    emit(bannersChangeStates());
  }

  CategoriesModel? categoriesModel;


  void getCategoryData()async{
    emit(HomeLoadingStates());
    await  DioHelper.getData(
      url:GET_CATEGORIES,
      token: token,
    ).then((value){
      categoriesModel=CategoriesModel.fromJson(value.data);
      emit(CategoriesSucessStates());
    }).catchError((error){
      print(error.toString());
      emit(CategoriesErrorStates());
    });
  }
  late ChangeFavoritesModel changeFavoritesModel;
  void changeFavorites(int? productId){

    favorites[productId] = !favorites[productId];
    emit(FavoritesChangeStates());
    DioHelper.postData(
        url: FAVORITES,
        data: {
          'product_id' : productId,
        },
      token: token,
    ).then((value) => {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data),

      if(changeFavoritesModel.status==false){
       favorites[productId] = !favorites[productId],

      }else{
        getFavoritesData(),
      },

      emit(FavoritesChangeSucessStates(changeFavoritesModel)),
    }).catchError((error){


      emit(FavoritesChangeErrorStates());
    });
  }

  FavoritesModel? favoritesModel;


  void getFavoritesData()async{
    emit(FavoritesChangeStates());
    await  DioHelper.getData(
      url:FAVORITES,
      token: token,
    ).then((value){
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(FavoritesGetSucessStates());
    }).catchError((error){
      print(error.toString());
      emit(FavoritesGetErrorStates());
    });
  }







}