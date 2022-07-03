import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/models/boarding_classes.dart';
import 'package:new_app/modules/login_screen/login_screen.dart';
import 'package:new_app/shared/components.dart';
import 'package:new_app/shared/cubit/cubit.dart';
import 'package:new_app/shared/cubit/states.dart';
import 'package:new_app/shared/network/local/cashe_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'dart:ui' as ui;
import '../../shared/colors.dart';

class OnBoardingScreen extends StatelessWidget {
  List<BoardingModel> boarding = [
    BoardingModel(
        title: 'متجرك',
        body: 'متجرك لديك علي هاتفك !',
        image: 'assets/images/onboard1.png'),
    BoardingModel(
        title: 'متجرك',
        body: 'احصل علي العديد من الخصومات',
        image: 'assets/images/onboard2.png'),
    BoardingModel(
        title: 'متجرك',
        body: 'اسرع خدمة توصيل في جميع الانحاء',
        image: 'assets/images/onboard3.png'),
  ];


  var boardController = PageController();
  @override
  Widget build(BuildContext context) {
    ShopCubit cubit = ShopCubit.get(context);
    void submit(){
      CasheHelper.saveData(key: 'onBoarding', value: true).then((value) => {
        if(value!){
          cubit.navigateAndFinish(context, LoginScreen()),
    }
      });
    }
    return BlocProvider(
      create: (BuildContext context)=> ShopCubit(),
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Directionality(
            textDirection: ui.TextDirection.rtl,
            child: Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  leading: TextButton(
                      onPressed: submit,
                      child: const Text(
                        "تخطي",
                        style: TextStyle(
                          fontSize: 14,
                          color: defColor,
                        ),
                      ),
                  ),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      Expanded(
                        child: PageView.builder(
                          onPageChanged: (int index) {
                            print(index);
                            cubit.isLastItem(boarding.length, index);
                          },
                          physics: const BouncingScrollPhysics(),
                          controller: boardController,
                          itemBuilder: (context, index) =>
                              buildBoardingItem(boarding[index]),
                          itemCount: boarding.length,
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              defaultButton(
                                radius: 26,
                                  buttonWidth: 100,
                                  background: defColor!,
                                  function: () {
                                    if (cubit.isLast == true) {
                                      submit();
                                    } else {
                                      boardController.nextPage(
                                          duration: const Duration(milliseconds: 750),
                                          curve: Curves.fastLinearToSlowEaseIn);
                                    }
                                  },
                                  text: 'التالي',
                              ),
                            ],
                          ),
                          const Spacer(),
                          SmoothPageIndicator(
                            controller: boardController,
                            count: boarding.length,
                            effect: ExpandingDotsEffect(
                              dotColor: Colors.grey,
                              activeDotColor: defColor!,
                              dotHeight: 10,
                              dotWidth: 10,
                              spacing: 5.0,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )),
          );
        },
      ),
    );
  }
}
