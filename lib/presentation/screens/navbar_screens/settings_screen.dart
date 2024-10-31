import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/logic/cubits/shop_cubit/shop_cubit.dart';
import 'package:shop_app/presentation/widgets/constants.dart';
import 'package:shop_app/presentation/widgets/widgets.dart';

// ignore: must_be_immutable
class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});
  final formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        //! it good to play with model and not play with states
        var userModel = ShopCubit.get(context).userModel!.data;
        nameController.text = userModel!.name!;
        emailController.text = userModel.email!;
        phoneController.text = userModel.phone!;

        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
          builder: (context) => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsetsDirectional.all(16.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if (state is ShopLoadingUpdateDataState)
                      const LinearProgressIndicator(),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                      controller: nameController,
                      prefix: Icons.person,
                      keyBoardType: TextInputType.name,
                      label: "name",
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'must enter the name!!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    defaultFormField(
                      controller: emailController,
                      prefix: Icons.email_outlined,
                      keyBoardType: TextInputType.emailAddress,
                      label: "email address",
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'must enter the email!!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    defaultFormField(
                      controller: phoneController,
                      prefix: Icons.phone,
                      keyBoardType: TextInputType.phone,
                      label: "phone",
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'must enter the phone!!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 90),
                    defaultButton(
                      text: 'update',
                      function: () {
                        if (formKey.currentState!.validate()) {
                          ShopCubit.get(context).updateUserData(
                            email: emailController.text,
                            name: nameController.text,
                            phone: phoneController.text,
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    defaultButton(
                      text: 'logout',
                      function: () {
                        signOut(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          fallback: (context) => const CircularProgressIndicator(),
        );
      },
    );
  }
}
