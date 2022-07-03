import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/modules/search/cubit/states.dart';
import 'package:new_app/shared/components.dart';


import '../../models/favorites_model.dart';
import '../../models/search_model.dart';
import '../../shared/colors.dart';
import '../favourite/favourite_screen.dart';
import 'cubit/cubit.dart';

class SearchScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit, SearchStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
          ),
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  ModTextFormField(
                    labelText: 'Search',
                    hintText: 'Searc...',
                    textFieldController: searchController,
                    onSubmit: (String text) {
                      SearchCubit.get(context).search(
                        text: text,
                      );
                    },
                    validateTextField: (String? value) {
                      if (value!.isEmpty) {
                        return 'enter text to search';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  if (state is SearchLoadingState) LinearProgressIndicator(),
                  SizedBox(
                    height: 10.0,
                  ),
                  if (state is SearchSuccessState)
                    Expanded(
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) => buildListProductSearch(
                          model: SearchCubit.get(context)
                              .searchModel!
                              .data!
                              .data[index],
                          context: context,
                        ),
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 2.0),
                        itemCount: SearchCubit.get(context)
                            .searchModel!
                            .data!
                            .data
                            .length,
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget buildListProductSearch(
    {
      Products? model,
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
                  image: NetworkImage('${model?.image}'),
                  width: 120.0,
                  height: 120.0,
                ),
                if (model?.discount != 0 )
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
                    '${model?.name}',
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
                        '${model?.price}',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: defColor!,
                        ),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      if (model?.discount != 0 )
                        Text(
                          '${model?.oldPrice}',
                          style: const TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      const Spacer(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );