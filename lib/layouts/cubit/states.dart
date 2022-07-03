import 'package:new_app/models/add_favorites_model.dart';

abstract class HomeStates {}

class HomeInitialStates extends HomeStates {}

class ChangeBottomNavState extends HomeStates {}

class HomeLoadingStates extends HomeStates {}
class HomeSucessStates extends HomeStates {}
class HomeErrorStates extends HomeStates {}

class bannersChangeStates extends HomeStates{}


class CategoriesSucessStates extends HomeStates {}

class CategoriesErrorStates extends HomeStates {}

class FavoritesChangeStates extends HomeStates {}

class FavoritesChangeSucessStates extends HomeStates {

  final ChangeFavoritesModel model;

  FavoritesChangeSucessStates(this.model);
}

class FavoritesChangeErrorStates extends HomeStates {}

class FavoritesGetSucessStates extends HomeStates {}
class FavoritesGetErrorStates extends HomeStates {}


