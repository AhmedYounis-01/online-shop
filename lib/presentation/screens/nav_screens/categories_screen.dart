import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/logic/cubit/shop_cubit.dart';
import 'package:shop_app/models/categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return ListView.separated(
            itemBuilder: (context, index) =>
                buildCatItems(cubit.categoriesModel!.data!.data[index]),
            separatorBuilder: (context, index) => const Divider(),
            itemCount: cubit.categoriesModel!.data!.data.length);
      },
    );
  }

  Widget buildCatItems(DataModel model) {
    return Row(
      children: [
        Image(width: 100, height: 100, image: NetworkImage('${model.image}')),
        const SizedBox(
          width: 20,
        ),
        Text(
          '${model.name}',
          style: const TextStyle(fontSize: 20),
        ),
        const Spacer(),
        IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_forward_ios))
      ],
    );
  }
}
