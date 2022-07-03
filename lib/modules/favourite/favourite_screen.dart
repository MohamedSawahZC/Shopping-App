import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layouts/cubit/cubit.dart';
import '../../layouts/cubit/states.dart';
import '../../models/favorites_model.dart';
import '../../shared/colors.dart';
import '../cateogries/cateogries_screen.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<HomeCubit,HomeStates>(
      listener:(context,state){},
      builder:(context,state){
        print(HomeCubit.get(context).favoritesModel?.data?.favourites.toString());
        return ConditionalBuilder(
          condition:state is !FavoritesChangeStates ,
          builder: (BuildContext context) =>ListView.separated(
            physics:const BouncingScrollPhysics(),
            itemBuilder:(context,index)=>Container(color:Colors.white,child: buildListProduct(model: HomeCubit.get(context).favoritesModel?.data?.favourites[index],context: context)),
            separatorBuilder:(context,index)=>Container(
              width:1,
              height:1,
              color:Colors.grey,
            ),
            itemCount:HomeCubit.get(context).favoritesModel!.data!.favourites.length ,
          ),
          fallback: (BuildContext context)=>const Center(child: CircularProgressIndicator()),

        );



      },

    );
  }



}



Widget buildListProduct(
{
  DataProducts? model,
  context,
}) =>
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120.0,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage('${model?.product?.image}'),
                  width: 120.0,
                  height: 120.0,
                ),
                if (model?.product?.discount != 0 )
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.red,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        'خصم خاص',
                        style: TextStyle(
                            fontSize: 10.0, color: Colors.white),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model?.product?.name}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14.0,
                      height: 1.3,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        '${model?.product?.price}',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: defColor!,
                        ),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      if (model?.product?.discount != 0 )
                        Text(
                          '${model?.product?.oldPrice}',
                          style: const TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          HomeCubit.get(context).changeFavorites(model?.product?.id);
                        },
                        icon: CircleAvatar(
                          radius: 14.0,
                          backgroundColor:
                          HomeCubit.get(context).favorites[model?.product?.id]
                              ? defColor!
                              : Colors.grey,
                          child: const Icon(
                            Icons.favorite_border,
                            size: 14.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );