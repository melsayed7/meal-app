import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultTextField({
  required TextEditingController controller,
  required TextInputType type,
  required String label,
  required IconData prefix,
  required String? Function(String?)? validate,
  bool isPassword = false,
  IconData? suffix,
  Function()? suffixPressed,
  Function()? onTaped,
  Function(String)? onSubmit,
  ValueChanged<String>? onchange,
}) =>
    TextFormField(
      style: TextStyle(),
      controller: controller,
      keyboardType: type,
      validator: validate,
      onFieldSubmitted: onSubmit,
      onTap: onTaped,
      onChanged: onchange,
      obscureText: isPassword,
      decoration: InputDecoration(
        prefixIcon: Icon(prefix),
        labelText: label,
        suffixIcon: suffix != null
            ? IconButton(onPressed: suffixPressed, icon: Icon(suffix))
            : null,
        border: OutlineInputBorder(),
      ),
    );

Widget defaultTextButton({
  required Function()? function,
  required String text,
}) =>
    TextButton(
      onPressed: function,
      child: Text(text.toUpperCase()),
    );

void navigateTO(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUppercase = true,
  double radius = 5.0,
  Function()? function,
  required String text,
}) =>
    Container(
      width: width,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUppercase ? text.toUpperCase() : text,
          style: TextStyle(fontSize: 20.0, color: Colors.white),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
    );
void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (Route<dynamic> route) => false,
    );

void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}
