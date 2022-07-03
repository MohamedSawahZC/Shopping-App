
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_app/models/boarding_classes.dart';
import 'package:new_app/modules/login_screen/login_screen.dart';
import 'package:new_app/shared/colors.dart';

import '../layouts/cubit/cubit.dart';
import '../models/favorites_model.dart';
import 'cubit/cubit.dart';
import 'network/local/cashe_helper.dart';
class ModTextFormField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final Color borderColor;
  final TextEditingController? textFieldController;
  final Function? suffixTap;
  final Function? validateTextField;
  final Function? onSubmit;
  final Color? filledColor;
  final bool isSecure;
  final int lineHeight;
  final double labelFontSize;
  final double hintFontSize;

  const ModTextFormField({
    Key? key,
    required this.hintText,
    required this.labelText,
    this.prefixWidget,
    this.suffixWidget,
    this.borderColor = Colors.blue,
    this.textFieldController,
    this.suffixTap,
    this.onSubmit,
    this.validateTextField,
    this.filledColor = Colors.lightBlue,
    this.isSecure = false,
    this.lineHeight = 1,
    this.labelFontSize = 16,
    this.hintFontSize = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText),
        const SizedBox(height: 10),
        TextFormField(
          onFieldSubmitted: (String? value) {
            return onSubmit!(value);
          },
          style: TextStyle(
            color: Colors.white,
          ),
          controller: textFieldController,
          obscureText: isSecure,
          maxLines: lineHeight,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 15,
            ),
            errorStyle: const TextStyle(
              fontSize: 16,
            ),
            filled: true,
            fillColor: filledColor,

            hintText: hintText,
            prefixIcon: prefixWidget,
            suffixIcon: suffixWidget,
            labelStyle: TextStyle(
              fontSize: labelFontSize,
            ),
            hintStyle: TextStyle(
              fontSize: hintFontSize,
              color: Colors.white,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                width: 0.5,
                style: BorderStyle.solid,
                color: borderColor,
              ),
            ),
          ),
          validator: (String? value) {
            return validateTextField!(value);
          },
        ),
      ],
    );
  }
}

Widget buildBoardingItem(BoardingModel model) => Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Image(
            width: 400,
              image: AssetImage('${model.image}')
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          '${model.title}',
          style: TextStyle(
            fontSize: 48,
            color: defColor,
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          '${model.body}',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );

class defaultButton extends StatelessWidget {
  defaultButton({
    required this.buttonWidth,
    required this.background,
    required this.function,
    required this.text,
    this.radius,
    bool? isUpperCase,
  });

  double buttonWidth = double.infinity;
  Color background = Colors.blue;
  bool isUpperCase = true;
  double? radius = 3.0;
  VoidCallback function;
  String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: buttonWidth,
      height: 50.0,

      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius!,
        ),
        color: background,
      ),
    );
  }
}

Widget defaultTextButton({
  required Function function,
  required Color textColor,
  required String text,
  double? TextFontSize,
}) =>
    TextButton(
      onPressed: function(),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          color: defColor,
          fontWeight: FontWeight.bold,
          fontSize: TextFontSize,
        ),
      ),
    );

void showToast({
  required String message,
  required ToastStates state,
})=>Fluttertoast.showToast(
  msg: message,
  toastLength: Toast.LENGTH_SHORT,
  gravity: ToastGravity.BOTTOM,
  timeInSecForIosWeb: 5,
  backgroundColor: chooseToastColor(state),
  textColor: Colors.white,
  fontSize: 16.0,
);
enum ToastStates {SUCESS,ERROR,WARNING}

Color chooseToastColor(ToastStates state){
  Color color;
  switch(state){
    case ToastStates.SUCESS:
    color =  Colors.green;
    break;
    case ToastStates.ERROR:
      color =  Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amberAccent;
      break;
  }
  return color;


}
void navigateTo(context, widget) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}


void navigateAndFinish(context, widget) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
        (Route<dynamic> route) => false,
  );
}
void signOut(context){
  CasheHelper.removeData(key: 'token',

  ).then((value) => {
    if(value){
      navigateAndFinish(context,LoginScreen()),
    }
  });
}

