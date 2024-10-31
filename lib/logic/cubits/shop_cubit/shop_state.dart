part of 'shop_cubit.dart';

@immutable
sealed class ShopStates {}

final class ShopInitialState extends ShopStates {}

final class ShopChangeBottomNavState extends ShopStates {}

final class ShopLoadingHomeDataState extends ShopStates {}

final class ShopSuccessHomeDataState extends ShopStates {}

final class ShopErrorHomeDataState extends ShopStates {}

final class ShopSuccessCategoriesState extends ShopStates {}

final class ShopErrorCategoriesState extends ShopStates {}

final class ShopChangeFavoritesState extends ShopStates {}

final class ShopSuccessChangeFavoritesState extends ShopStates {
  final ChangeFavoritesModel model;

  ShopSuccessChangeFavoritesState(this.model);
}

final class ShopErrorChangeFavoritesState extends ShopStates {}

final class ShopLoadingGetFavoriteState extends ShopStates {}

final class ShopSuccessGetFavoritesState extends ShopStates {}

final class ShopErrorGetFavoritesState extends ShopStates {}

final class ShopLoadingUserDataState extends ShopStates {}

final class ShopSuccessUserDataState extends ShopStates {}

final class ShopErrorUserDataState extends ShopStates {}

final class ShopLoadingUpdateDataState extends ShopStates {}

final class ShopSuccessUpdateDataState extends ShopStates {
  final ShopLoginModel loginModel;

  ShopSuccessUpdateDataState(this.loginModel);
}

final class ShopErrorUpdateDataState extends ShopStates {}
