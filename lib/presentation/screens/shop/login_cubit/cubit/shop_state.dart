part of 'shop_cubit.dart';

@immutable
sealed class ShopLoginState {}

final class ShopLoginInitialStates extends ShopLoginState {}

final class ShopLoginLoadingStates extends ShopLoginState {}

final class ShopLoginSuccessStates extends ShopLoginState {
  final ShopLoginModel loginModel;

  ShopLoginSuccessStates(this.loginModel);
}

final class ShopLoginErrorStates extends ShopLoginState {
  final String error;

  ShopLoginErrorStates({required this.error});
}

final class ChangePasswordVisibility extends ShopLoginState {}
