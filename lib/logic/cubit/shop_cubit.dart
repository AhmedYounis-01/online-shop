import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages, unnecessary_import
import 'package:meta/meta.dart';
import 'package:shop_app/data/end_point.dart';
import 'package:shop_app/data/remote/dio_helper.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/shop_login_model.dart';
import 'package:shop_app/presentation/screens/nav_screens/categories_screen.dart';
import 'package:shop_app/presentation/screens/nav_screens/favorites_screen.dart';
import 'package:shop_app/presentation/screens/nav_screens/products_screen.dart';
import 'package:shop_app/presentation/screens/nav_screens/settings_screen.dart';
import 'package:shop_app/presentation/widgets/constants.dart';

part 'shop_state.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());
  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> bottomScreen = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    SettingsScreen(),
  ];
  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;
  Map<int?, bool?> isFavorites = {};
  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: home,
      token: "$token",
    ).then(
      (value) {
        homeModel = HomeModel.fromJson(value!.data);
        // printFullText(homeModel!.data.banners[0].image);

        for (var element in homeModel!.data!.products) {
          isFavorites.addAll({
            element.id: element.inFavorites,
          });
        }

        // ignore: avoid_print
        print(isFavorites.toString());
        emit(ShopSuccessHomeDataState());
      },
    ).catchError((error) {
      // ignore: avoid_print
      print('Error :- $error');
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;
  void getCategoriesData() {
    DioHelper.getData(url: categories).then(
      (value) {
        categoriesModel = CategoriesModel.fromJson(value!.data);
        emit(ShopSuccessCategoriesState());
      },
    ).catchError((error) {
      // ignore: avoid_print
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorites(int? productId) {
    isFavorites[productId] = !isFavorites[productId]!;
    // ignore: avoid_print
    print('Updated isFavorites: $isFavorites');

    emit(ShopChangeFavoritesState());

    DioHelper.postData(
      url: favorite,
      data: {'product_id': productId},
      token: "$token",
    ).then(
      (value) {
        changeFavoritesModel = ChangeFavoritesModel.fromJson(value!.data);
        // ignore: avoid_print
        print(value.data);
        if (!changeFavoritesModel!.status!) {
          isFavorites[productId] = !isFavorites[productId]!;
        } else {
          getFavorites();
        }
        emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
      },
    ).catchError((error) {
      isFavorites[productId] = !isFavorites[productId]!;
      emit(ShopErrorChangeFavoritesState());
    });
  }

  FavoriteModel? favoritesModel;
  void getFavorites() {
    emit(ShopLoadingGetFavoriteState());

    DioHelper.getData(
      url: favorite,
      token: "$token",
    ).then(
      (value) {
        favoritesModel = FavoriteModel.fromJson(value!.data);

        emit(ShopSuccessGetFavoritesState());
      },
    ).catchError((error) {
      // ignore: avoid_print
      print("Error fetching favorites: $error");
      emit(ShopErrorGetFavoritesState());
    });
  }

  ShopLoginModel? userModel;
  void getUserData() {
    emit(ShopLoadingUserDataState());

    DioHelper.getData(
      url: profile,
      token: "$token",
    ).then(
      (value) {
        userModel = ShopLoginModel.fromJson(value!.data);
        print("the name is working ${userModel!.data!.name}");
        emit(ShopSuccessUserDataState());
      },
    ).catchError((error) {
      // ignore: avoid_print
      print("Error fetching favorites: $error");
      emit(ShopErrorUserDataState());
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopLoadingUpdateDataState());

    DioHelper.putData(
      url: updateProfile,
      token: "$token",
      data: {
        "name": name,
        "email": email,
        "phone": phone,
      },
    ).then(
      (value) {
        userModel = ShopLoginModel.fromJson(value!.data);

        emit(ShopSuccessUpdateDataState(userModel!));
      },
    ).catchError((error) {
      // ignore: avoid_print
      print("Error fetching favorites: $error");
      emit(ShopErrorUpdateDataState());
    });
  }
}
