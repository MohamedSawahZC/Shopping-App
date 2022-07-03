import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/layouts/cubit/cubit.dart';
import 'package:new_app/layouts/cubit/states.dart';

import '../../models/categories_model.dart';

class CateogriesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context,state){

      },
        builder: (context,state){
        return ListView.separated(
          itemBuilder: (context,index)=> buildCatItem(HomeCubit.get(context).categoriesModel!.data!.dataList[index]),
          separatorBuilder: (context,index)=>Container(
            width:1,
            height:1,
            color:Colors.red[100],
          ),
          itemCount: HomeCubit.get(context).categoriesModel!.data!.dataList.length,
        );
        },
    );
  }
}

Widget buildCatItem(DataModel model)=>Padding(
  padding: EdgeInsets.all(20),
  child: Row(
    children: [
      Image(
        image: NetworkImage('${model.image}',),
        width: 80,
        height: 80,
        fit: BoxFit.cover,
      ),
      SizedBox(
        width: 20,
      ),
      Text(
        '${model.name}',
        style: TextStyle(
          fontSize: 20.0,
        ),
      ),
      Spacer(),
      Icon(
        Icons.arrow_forward_ios,
      )
    ],
  ),
);