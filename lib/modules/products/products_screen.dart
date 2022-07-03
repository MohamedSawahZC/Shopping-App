import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/layouts/cubit/cubit.dart';
import 'package:new_app/layouts/cubit/states.dart';
import 'package:new_app/models/categories_model.dart';
import 'package:new_app/models/home_model.dart';
import 'package:new_app/shared/colors.dart';
import 'package:new_app/shared/components.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

CarouselController buttonCarouselController = CarouselController();

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = HomeCubit.get(context);
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {
          if(state is FavoritesChangeSucessStates){
            if(state.model.status == false){
              showToast(message: '${state.model.message}', state: ToastStates.ERROR);
            }else{
              showToast(message: '${state.model.message}', state: ToastStates.SUCESS);
            }

          }
        },
        builder: (context, state) {
          return ConditionalBuilder(
            condition: cubit.homeModel != null && cubit.categoriesModel !=null,
            builder: (context) => productsBuilder(cubit.homeModel!, context,cubit.categoriesModel!),
            fallback: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }

  Widget productsBuilder(HomeModel model, context,CategoriesModel categoriesModel) => SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                CarouselSlider(
                  carouselController: buttonCarouselController,
                  items: model.data?.banners!
                      .map((e) => Image(
                            image: NetworkImage(
                              '${e.image}',
                            ),
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ))
                      .toList(),
                  options: CarouselOptions(
                      height: 250,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      viewportFraction: 1.0,
                      autoPlayInterval: const Duration(
                        seconds: 3,
                      ),
                      autoPlayAnimationDuration: const Duration(
                        seconds: 1,
                      ),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      scrollDirection: Axis.horizontal,
                      onPageChanged: (index, _) => {
                            HomeCubit.get(context).changeCurrentIndex(index),
                          }),
                ),
                buildIndicator(HomeCubit.get(context).activeIndex,
                    model.data!.banners?.length)
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'الأقسام',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 100,
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context,index)=> buildCategoryItem(categoriesModel.data!.dataList[index]),
                        separatorBuilder: (context,index)=> SizedBox(width: 10.0,),
                        itemCount: categoriesModel.data!.dataList.length,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'منتجات جديدة',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.white,
              child: GridView.count(
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                childAspectRatio: 1 / 1.64,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                children: List.generate(model.data!.products!.length,
                    (index) => buildGridProduct(model.data!.products![index],context)),
              ),
            ),
          ],
        ),
      );
}

Widget buildGridProduct(ProductsModel model,context) => Card(
      elevation: 20.0,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Stack(
                    alignment: AlignmentDirectional.bottomStart,
                    children: [
                      Image(
                        image: NetworkImage(
                          model.image!,
                        ),
                        width: double.infinity,
                        height: 200,
                      ),
                      if (model.discount != 0)
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
                  Text(
                    '${model.name}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14.0,
                      height: 1.3,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        '${model.price.round()}ج.م',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 14.0, height: 1.3, color: defColor),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      if (model.discount != 0)
                        Text(
                          '${model.oldPrice.round()}ج.م',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              decoration: TextDecoration.lineThrough,
                              fontSize: 12.0,
                              height: 1.3,
                              color: Colors.grey),
                        ),
                      const Spacer(),
                      IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            HomeCubit.get(context).changeFavorites(model.id);
                          },
                          icon: CircleAvatar(
                            backgroundColor: HomeCubit.get(context).favorites[model.id]?defColor:Colors.grey,
                            radius: 15,
                            child: const Icon(
                              Icons.favorite_border,
                              size: 14,
                              color: Colors.white,
                            ),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

Widget buildCategoryItem(DataModel dataModel) => Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image(
          image: NetworkImage('${dataModel.image}'),
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Container(
          color: Colors.black.withOpacity(0.8),
          width: 100.0,
          child: Text(
            '${dataModel.name}',
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        )
      ],
    );

Widget buildIndicator(int? activeIndex, count) => Padding(
      padding: const EdgeInsets.all(10),
      child: AnimatedSmoothIndicator(
        activeIndex: activeIndex ?? 0,
        count: count,
        effect: CustomizableEffect(
          dotDecoration: DotDecoration(
            borderRadius: BorderRadius.circular(20),
            height: 10,
            width: 10,
            color: Colors.grey,
          ),
          activeDotDecoration: DotDecoration(
            rotationAngle: 180,
            color: defColor!,
            borderRadius: BorderRadius.circular(20),
            width: 30,
          ),
        ),
      ),
    );
