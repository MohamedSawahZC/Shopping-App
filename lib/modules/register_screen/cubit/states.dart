import '../../../models/login_model.dart';

abstract class ShopRegisterStates {}

class ShopRegisterInitialStates extends ShopRegisterStates {}

class RegisterChangePasswordVisibility extends ShopRegisterStates{}


class ShopRegisterLoadingStates extends ShopRegisterStates{}

class ShopRegisterSucessStates extends ShopRegisterStates{
  final LoginModel loginModel;

  ShopRegisterSucessStates(this.loginModel);
}

class ShopRegisterErrorStates extends ShopRegisterStates{
  final String error;
  ShopRegisterErrorStates(this.error);
}