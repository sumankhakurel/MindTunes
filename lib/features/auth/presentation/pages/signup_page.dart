import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindtunes/core/common/widgets/loader.dart';
import 'package:mindtunes/core/theme/app_pallet.dart';
import 'package:mindtunes/core/utils/show_snacksbar.dart';
import 'package:mindtunes/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mindtunes/features/auth/presentation/pages/login_page.dart';
import 'package:mindtunes/features/auth/presentation/widgets/auth_field.dart';
import 'package:mindtunes/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:mindtunes/nav_bar.dart';

class SignUpPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const SignUpPage());
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final repasswordController = TextEditingController();
  final nameController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    repasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthFailure) {
                showSnackBar(context, state.message);
              } else if (state is AuthSuccess) {
                Navigator.pushAndRemoveUntil(
                    context, NavBar.route(), (route) => false);
              }
            },
            builder: (context, state) {
              if (state is AuthLoading) {
                return const Loader();
              }
              return Form(
                key: formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Sign Up.",
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),
                    AuthField(
                      icon: const Icon(CupertinoIcons.profile_circled),
                      hintText: "Name",
                      controller: nameController,
                      action: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter Name";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    AuthField(
                      icon: const Icon(CupertinoIcons.mail),
                      hintText: "Email",
                      controller: emailController,
                      action: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter Email";
                        } else if (!RegExp(
                                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                            .hasMatch(value)) {
                          return "Please enter valid email";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    AuthField(
                      icon: const Icon(CupertinoIcons.lock),
                      hintText: "Password",
                      controller: passwordController,
                      isObsecuteText: true,
                      action: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Password is missing!";
                        } else if (value.length < 5) {
                          return "Minimum password length is 5";
                        } else if (!RegExp(r'^(?=.*[a-zA-Z])(?=.*\d).{6,}$')
                            .hasMatch(value)) {
                          return "Password must contain at least 1 alphabet and number";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    AuthField(
                      icon: const Icon(CupertinoIcons.lock),
                      hintText: "Re-Password",
                      controller: repasswordController,
                      isObsecuteText: true,
                      action: TextInputAction.done,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Re-Password is missing!";
                        } else if (value.length < 5) {
                          return "Minimum password length is 5";
                        } else if (value != passwordController.text) {
                          return "Password do not match";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    AuthGradientButton(
                      buttonName: "Sign Up",
                      onPress: () {
                        if (formkey.currentState!.validate()) {
                          context.read<AuthBloc>().add(AuthSignUp(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                                name: nameController.text.trim(),
                              ));
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, LoginPage.route());
                      },
                      child: RichText(
                        text: TextSpan(
                            text: "Already have an account? ",
                            style: Theme.of(context).textTheme.titleMedium,
                            children: [
                              TextSpan(
                                text: 'Sign In',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      color: AppPallete.gradient2,
                                      fontWeight: FontWeight.bold,
                                    ),
                              )
                            ]),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
