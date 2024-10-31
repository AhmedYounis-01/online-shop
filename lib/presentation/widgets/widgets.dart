import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/logic/cubits/shop_cubit/shop_cubit.dart';
import 'package:shop_app/presentation/screens/on_boarding_screen.dart';
import 'package:shop_app/presentation/widgets/constants.dart';

// ignore: avoid_types_as_parameter_names, non_constant_identifier_names
void navigateTo(context, Widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Widget,
      ),
    );
// ignore: non_constant_identifier_names, avoid_types_as_parameter_names
void navigateAndFinish(context, Widget) => Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Widget,
      ),
    );

Widget buildBoardingItem(BoardingModel model) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image.asset(
            model.image,
          ),
        ),
        Text(
          model.title,
          style: const TextStyle(
            fontSize: 25,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          model.body,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
      ],
    );

Widget defaultFormField({
  required TextEditingController controller,
  required IconData prefix,
  IconData? suffix,
  void Function()? suffixPressed,
  void Function()? onTap,
  bool isPassword = false,
  required TextInputType keyBoardType,
  required String label,
  Function(String)? onChange,
  Function(String)? onSubmit,
  required String? Function(String?)? validate,
  Color focusedLabelColor = Colors.blue, // Focused label color
}) =>
    TextFormField(
      keyboardType: keyBoardType,
      controller: controller,
      obscureText: isPassword,
      onTap: onTap,
      decoration: InputDecoration(
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(onPressed: suffixPressed, icon: Icon(suffix))
            : null,
        labelText: label,
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.blue, width: 1.0), // Border color when focused
        ),
        floatingLabelStyle:
            TextStyle(color: focusedLabelColor), // Label color when focused
      ),
      validator: validate,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
    );

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blueAccent,
  String? text,
  double radius = 0.0,
  bool toUpperCase = true,
  void Function()? function,
}) =>
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
      width: width,
      height: 40,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          text!.toUpperCase(),
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );

Widget defaultTextButton({
  required String text,
  required void Function()? function,
}) {
  return TextButton(
    onPressed: function,
    child: Text(
      text.toUpperCase(),
      style: const TextStyle(color: Colors.blue),
    ),
  );
}

void showToast({
  required String text,
  required ToastStates states,
}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(states),
        textColor: Colors.white,
        fontSize: 16.0);

// ignore: constant_identifier_names
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
      color = Colors.yellow;
      break;
  }
  return color;
}

Widget buildListProduct(model, context, {bool isOldPrice = true}) => Padding(
      padding: const EdgeInsetsDirectional.all(20),
      child: SizedBox(
        height: 130,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage("${model.image}"),
                  height: 120,
                  width: 120,
                ),
                if (model.discount != 0 && isOldPrice)
                  Container(
                      color: Colors.red,
                      child: const Text(
                        "DISCOUNT",
                        style: TextStyle(color: Colors.white),
                      ))
              ],
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${model.name}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(height: 1.3),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Text(
                        model.price.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      if (model.discount != 0 && isOldPrice)
                        Text(
                          model.oldPrice.toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      const Spacer(),
                      CircleAvatar(
                        backgroundColor:
                            ShopCubit.get(context).isFavorites[model.id]!
                                ? defaultColor
                                : Colors.grey,
                        child: IconButton(
                          onPressed: () {
                            ShopCubit.get(context).changeFavorites(model.id);
                          },
                          icon: const Icon(
                            Icons.favorite_outline,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
