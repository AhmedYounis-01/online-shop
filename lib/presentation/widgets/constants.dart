import 'package:flutter/material.dart';
import 'package:shop_app/data/local/cache_helper.dart';
import 'package:shop_app/presentation/screens/shop/shop_login_screen.dart';
import 'package:shop_app/presentation/widgets/widgets.dart';

const defaultColor = Colors.blue;
String? token =
    'uINsiAb2kNgFAsu6yz4pPPoSaI3IONMYV7jld89d0bHBeh1w7e3nRe9fYL6W0u0bnZBX8y';
void signOut(context) {
  CacheHelper.removeData(key: "token").then(
    (value) {
      if (value) {
        navigateAndFinish(context, ShopLoginScreen());
      }
    },
  );
}

void printFullText(String text) {
  // ignore: non_constant_identifier_names
  final Pattern = RegExp('.{1,800}');
  // ignore: avoid_print
  Pattern.allMatches(text).forEach((match) => print(match.group(0)));
}
