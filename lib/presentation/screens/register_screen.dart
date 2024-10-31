import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/data/local/cache_helper.dart';
import 'package:shop_app/logic/cubits/register_cubit/register_cubit_cubit.dart';
import 'package:shop_app/presentation/screens/shop_layout.dart';
import 'package:shop_app/presentation/screens/shop_login_screen.dart';
import 'package:shop_app/presentation/widgets/constants.dart';
import 'package:shop_app/presentation/widgets/widgets.dart';

// ignore: must_be_immutable
class ShopRegisterScreen extends StatelessWidget {
  ShopRegisterScreen({super.key});
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterState>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessStates) {
            if (state.loginModel.status == true) {
              CacheHelper.saveData(
                key: "token",
                value: state.loginModel.data!.token,
              ).then(
                (value) {
                  token = state.loginModel.data!.token;
                  // ignore: use_build_context_synchronously
                  navigateAndFinish(context, const ShopLayout());
                },
              );
            } else if (state.loginModel.status == false) {
              showToast(
                text: state.loginModel.message,
                states: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (context, state) {
          var shopCubit = ShopRegisterCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsetsDirectional.all(20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Register",
                          style: TextStyle(fontSize: 35),
                        ),
                        const Text(
                          "Register now to browse our hot offers",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 30),
                        defaultFormField(
                          controller: nameController,
                          prefix: Icons.person,
                          keyBoardType: TextInputType.name,
                          label: 'Name',
                          focusedLabelColor: Colors.blue,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "Must enter name!!";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        defaultFormField(
                          controller: emailController,
                          prefix: Icons.email_outlined,
                          keyBoardType: TextInputType.emailAddress,
                          label: 'Email Address',
                          focusedLabelColor: Colors.blue,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "Must enter email!!";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        defaultFormField(
                          controller: passwordController,
                          prefix: Icons.lock_outlined,
                          suffix: shopCubit.suffix,
                          isPassword: ShopRegisterCubit.get(context).isPassword,
                          suffixPressed: () {
                            ShopRegisterCubit.get(context)
                                .changePasswordVisibility();
                          },
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "Must enter password!!";
                            }
                            return null;
                          },
                          keyBoardType: TextInputType.visiblePassword,
                          label: 'Password',
                          focusedLabelColor: Colors.blue,
                          onSubmit: (val) {},
                        ),
                        const SizedBox(height: 15),
                        defaultFormField(
                          controller: phoneController,
                          prefix: Icons.phone,
                          keyBoardType: TextInputType.phone,
                          label: 'phone ',
                          focusedLabelColor: Colors.blue,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "Must enter phone!!";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 30),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingStates,
                          builder: (context) => defaultButton(
                            text: "Register",
                            background: Colors.blue,
                            function: () {
                              if (formKey.currentState!.validate()) {
                                shopCubit.userRegister(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name: nameController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                          ),
                          fallback: (context) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("I have an account before !!"),
                            defaultTextButton(
                              text: 'Login',
                              function: () => navigateAndFinish(
                                context,
                                ShopLoginScreen(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}


