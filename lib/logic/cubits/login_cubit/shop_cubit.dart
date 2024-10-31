import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/data/end_point.dart';
import 'package:shop_app/data/remote/dio_helper.dart';
import 'package:shop_app/models/shop_login_model.dart';

part 'shop_state.dart';

class ShopLoginCubit extends Cubit<ShopLoginState> {
  ShopLoginCubit() : super(ShopLoginInitialStates());
  static ShopLoginCubit get(context) => BlocProvider.of(context);

  ShopLoginModel? loginModel;
  void userLogin({
    required String email,
    required String password,
  }) async {
    emit(ShopLoginLoadingStates());

    DioHelper.postData(
      url: login,
      data: {
        "email": email,
        'password': password,
      },
    ).then(
      (value) {
        if (value != null && value.statusCode == 200) {
          // ignore: avoid_print
          print("API Call successful: ${value.data}");
          loginModel = ShopLoginModel.fromJson(value.data);

          emit(ShopLoginSuccessStates(loginModel!));
        } else {
          // ignore: avoid_print
          print("API Call failed : Invalid response");
          emit(ShopLoginErrorStates(error: "Invalid response"));
        }
      },
    ).catchError((error) {
      // ignore: avoid_print
      print("API Call failed error: $error");

      String errorMessage = loginModel?.message ?? "حدث خطأ غير معروف";

      emit(ShopLoginErrorStates(error: errorMessage));
    });
  }

  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;
  void changePasswordVisibility() {
    suffix =
        isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    isPassword = !isPassword;
    emit(ChangePasswordVisibility());
  }
}
