import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/logic/cubits/search_cubit/search_cubit.dart';
import 'package:shop_app/presentation/widgets/widgets.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SearchCubit.get(context);

          return Scaffold(
              appBar: AppBar(),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      defaultFormField(
                        controller: searchController,
                        prefix: Icons.search,
                        keyBoardType: TextInputType.text,
                        label: "Search Items",
                        validate: (value) {
                          if (value!.isEmpty) "enter some text to search";
                          return null;
                        },
                        onChange: (String text) {
                          if (formKey.currentState!.validate()) {
                            cubit.search(text);
                          }
                        },
                        onSubmit: (String text) {
                          if (formKey.currentState!.validate()) {
                            cubit.search(text);
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (state is SearchLoadingState)
                        const LinearProgressIndicator(),
                      const SizedBox(
                        height: 10,
                      ),
                      if (state is SearchSuccessState)
                        Expanded(
                          child: ListView.separated(
                            itemBuilder: (context, index) => buildListProduct(
                                cubit.searchModel!.data!.data![index], context,
                                isOldPrice: false),
                            separatorBuilder: (context, index) => const Divider(
                              thickness: 1,
                              indent: 10,
                              endIndent: 10,
                            ),
                            itemCount: cubit.searchModel!.data!.data!.length, //
                          ),
                        ),
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}
