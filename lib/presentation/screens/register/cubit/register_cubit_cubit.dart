import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:shop_app/data/end_point.dart';
import 'package:shop_app/data/remote/dio_helper.dart';
import 'package:shop_app/models/shop_login_model.dart';

part 'register_cubit_state.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterState> {
  ShopRegisterCubit() : super(RegisterCubitInitial());
  static ShopRegisterCubit get(context) => BlocProvider.of(context);
  ShopLoginModel? loginModel;

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    emit(ShopRegisterLoadingStates());

    DioHelper.postData(
      url: register,
      data: {
        "email": email,
        'password': password,
        'name': name,
        "phone": phone,
      },
    ).then(
      (value) {
        loginModel = ShopLoginModel.fromJson(value!.data);

        emit(ShopRegisterSuccessStates(loginModel!));
      },
    ).catchError((error) {
      print(error.toString());
      emit(ShopRegisterErrorStates(error: error.toString()));
    });
  }

  // Password visibility logic remains the same
  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;

  void changePasswordVisibility() {
    suffix =
        isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    isPassword = !isPassword;
    emit(ChangeRegisterPasswordVisibilityState());
  }
}
