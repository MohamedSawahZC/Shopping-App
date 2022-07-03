import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/layouts/cubit/cubit.dart';
import 'package:new_app/layouts/home_screen.dart';
import 'package:new_app/modules/login_screen/cubit/cubit.dart';
import 'package:new_app/modules/register_screen/cubit/cubit.dart';
import 'package:new_app/modules/register_screen/register_screen.dart';
import 'package:new_app/modules/search/cubit/cubit.dart';
import 'package:new_app/shared/constants.dart';
import 'package:new_app/shared/cubit/cubit.dart';
import 'package:new_app/shared/network/local/cashe_helper.dart';
import 'package:new_app/shared/network/remote/dio_helper.dart';
import 'modules/login_screen/login_screen.dart';
import 'modules/on_boarding/on_boarding_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  CasheHelper.init();
  await CasheHelper.init();
  Widget?widget;
  bool? onBoarding=CasheHelper.getData(key:'onBoarding');
  token=CasheHelper.getData(key: 'token');
  print(token);
  if(onBoarding!=null){
    if(token!=null) widget=HomeScreen();

    else widget=LoginScreen();
  }
  else widget=OnBoardingScreen();

  runApp(MyApp(onboarding:onBoarding,startwidget:widget));

}
class MyApp extends StatelessWidget {
  bool?onboarding;
  Widget?startwidget;
  MyApp({this.onboarding, required this.startwidget});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:(context)=>ShopCubit(),
        ),
        BlocProvider(create: (BuildContext context)=> ShopLoginCubit()..getProfileData()
        ),
        BlocProvider(create: (BuildContext context)=> HomeCubit()..getHomeData()..getCategoryData()..getFavoritesData()
        ),
        BlocProvider(create: (BuildContext context)=> SearchCubit()
        ),
    BlocProvider(create: (BuildContext context)=> ShopRegisterCubit())
      ],
      child: MaterialApp(
        localizationsDelegates: const [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale("fa", "IR"), // OR Locale('ar', 'AE') OR Other RTL locales
        ],
        theme: ThemeData(
          fontFamily: 'Jannah'
        ),
        locale: Locale("fa", "IR"),
        debugShowCheckedModeBanner:false ,
        home:startwidget,
      ),
    );
  }
}