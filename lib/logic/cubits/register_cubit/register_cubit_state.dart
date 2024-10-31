part of 'register_cubit_cubit.dart';

@immutable
sealed class ShopRegisterState {}

final class RegisterCubitInitial extends ShopRegisterState {}

final class ShopRegisterLoadingStates extends ShopRegisterState {}

final class ShopRegisterSuccessStates extends ShopRegisterState {
  final ShopLoginModel loginModel;

  ShopRegisterSuccessStates(this.loginModel);
}

final class ShopRegisterErrorStates extends ShopRegisterState {
  final String error;

  ShopRegisterErrorStates({required this.error});
}

final class ChangeRegisterPasswordVisibilityState extends ShopRegisterState {}
