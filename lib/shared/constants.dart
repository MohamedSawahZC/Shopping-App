import 'package:new_app/modules/login_screen/login_screen.dart';
import 'package:new_app/shared/components.dart';
import 'package:new_app/shared/network/local/cashe_helper.dart';

String? token = '';

void signOut(context){
  CasheHelper.removeData(key: 'token').then((value) => {
    if(value){
      navigateAndFinish(context,LoginScreen()),
    }
  });
}