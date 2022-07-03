// ignore_for_file: prefer_const_constructors

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/layouts/cubit/cubit.dart';
import 'package:new_app/layouts/cubit/states.dart';
import 'package:new_app/modules/search/search_screen.dart';
import 'package:new_app/shared/colors.dart';
import 'package:new_app/shared/components.dart';
import 'package:new_app/shared/cubit/states.dart';

import '../shared/cubit/cubit.dart';

class HomeScreen extends StatelessWidget {

  List<IconData> icons_list = [
    Icons.home,
    Icons.apps,
    Icons.favorite,
    Icons.settings,

  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        // ignore: todo
      },
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return BlocConsumer<HomeCubit,HomeStates>(
          listener: (context, state) {

          },
          builder: (context,state){
            var cubit = HomeCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                title: Text(
                  'متجرك',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.black,
                ),
                ),
                actions: [
                  IconButton(
                    onPressed: (){
                      navigateTo(context, SearchScreen());
                    },
                    icon: Icon(
                        Icons.search,
                        color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),
              body: cubit.bottomScreens[cubit.currentIndex],
              bottomNavigationBar:BottomNavigationBar(
                items: const [
                  BottomNavigationBarItem(
                    icon:Icon(
                      Icons.home_filled,
                    ),
                    label:'الرئيسية',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                        Icons.grid_view,
                    ),
                    label: 'الأقسام',
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(
                          Icons.favorite
                      ),
                      label: 'المفضلة'
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(
                          Icons.settings
                      ),
                      label: 'الاعدادات'
                  ),
                ],
                selectedItemColor: defColor!,
                unselectedItemColor: Colors.black38,
                backgroundColor: Colors.white,
                elevation: 20.0,
                iconSize: 20,
                type: BottomNavigationBarType.fixed,
                currentIndex:cubit.currentIndex,
                onTap: (index) {
                  cubit.changeBottom(index);
                },
              ),
            );
          },
          );
      },
    );
  }
}
