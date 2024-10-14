import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/logic/cubit/shop_cubit.dart';
import 'package:shop_app/presentation/widgets/widgets.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: state is! ShopLoadingGetFavoriteState,
          builder: (context) => ListView.separated(
            itemBuilder: (context, index) => buildListProduct(
                cubit.favoritesModel!.data!.data![index].product, context),
            separatorBuilder: (context, index) => const Divider(
              thickness: 1,
              indent: 10,
              endIndent: 10,
            ),
            itemCount: cubit.favoritesModel!.data!.data!.length,
          ),
          fallback: (BuildContext context) => const CircularProgressIndicator(),
        );
      },
    );
  }
}
