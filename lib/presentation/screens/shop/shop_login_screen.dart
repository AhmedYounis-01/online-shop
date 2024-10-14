import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/data/local/cache_helper.dart';
import 'package:shop_app/presentation/screens/register/register_screen.dart';
import 'package:shop_app/presentation/screens/shop/login_cubit/cubit/shop_cubit.dart';
import 'package:shop_app/presentation/screens/shop/shop_layout.dart';
import 'package:shop_app/presentation/widgets/constants.dart';
import 'package:shop_app/presentation/widgets/widgets.dart';

// ignore: must_be_immutable
class ShopLoginScreen extends StatelessWidget {
  ShopLoginScreen({super.key});
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginState>(
        listener: (context, state) {
          if (state is ShopLoginSuccessStates) {
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
          var shopCubit = ShopLoginCubit.get(context);
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
                          "Login",
                          style: TextStyle(fontSize: 35),
                        ),
                        const Text(
                          "Login now to browse our hot offers",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 30),
                        defaultFormField(
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "Must enter email!!";
                            }
                            return null;
                          },
                          controller: emailController,
                          prefix: Icons.email_outlined,
                          keyBoardType: TextInputType.emailAddress,
                          label: 'Email Address',
                          focusedLabelColor: Colors.blue,
                        ),
                        const SizedBox(height: 15),
                        defaultFormField(
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "Must enter password!!";
                            }
                            return null;
                          },
                          controller: passwordController,
                          prefix: Icons.lock_outlined,
                          suffix: shopCubit.suffix,
                          isPassword: ShopLoginCubit.get(context).isPassword,
                          suffixPressed: () {
                            ShopLoginCubit.get(context)
                                .changePasswordVisibility();
                          },
                          keyBoardType: TextInputType.visiblePassword,
                          label: 'Password',
                          focusedLabelColor: Colors.blue,
                          onSubmit: (val) {
                            if (formKey.currentState!.validate()) {
                              shopCubit.userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                                //context: context,
                              );
                            }
                          },
                        ),
                        const SizedBox(height: 30),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingStates,
                          builder: (context) => defaultButton(
                            text: "Login",
                            background: Colors.blue,
                            function: () {
                              if (formKey.currentState!.validate()) {
                                shopCubit.userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                          ),
                          fallback: (context) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account?"),
                            defaultTextButton(
                              text: 'Register',
                              function: () => navigateAndFinish(
                                context,
                                ShopRegisterScreen(),
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
