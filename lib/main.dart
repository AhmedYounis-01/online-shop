import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc_observer.dart';
import 'package:shop_app/data/local/cache_helper.dart';
import 'package:shop_app/data/remote/dio_helper.dart';
import 'package:shop_app/logic/cubit/shop_cubit.dart';
import 'package:shop_app/presentation/screens/on_boarding_screen.dart';
import 'package:shop_app/presentation/screens/shop/shop_layout.dart';
import 'package:shop_app/presentation/screens/shop/shop_login_screen.dart';
import 'package:shop_app/presentation/widgets/constants.dart';

void main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init(); 
  await CacheHelper.init();

  bool onBoarding = (CacheHelper.getData(key: "onBoarding") as bool?) ?? false;
  String? token = CacheHelper.getData(key: "token") as String?;
  Widget startWidget;

  // Decide the start widget based on token and onboarding status
  if (onBoarding) {
    startWidget = (token != null && token.isNotEmpty)
        ? const ShopLayout()
        : ShopLoginScreen();
  } else {
    startWidget = const OnBoardingScreen();
  }

  runApp(MyApp(startWidget: startWidget));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  const MyApp({super.key, required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ShopCubit()
            ..getHomeData()
            ..getCategoriesData()
            ..getFavorites()
            ..getUserData(),
        ),
      ],
      // Use builder to ensure the context is properly initialized
      child: Builder(
        builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: startWidget,
            theme: ThemeData(
              primarySwatch: defaultColor,
              fontFamily: 'ShortBaby',
            ),
          );
        },
      ),
    );
  }
}
