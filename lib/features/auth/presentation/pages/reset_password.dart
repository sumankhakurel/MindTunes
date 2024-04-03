import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindtunes/core/common/widgets/loader.dart';
import 'package:mindtunes/core/utils/show_snacksbar.dart';
import 'package:mindtunes/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mindtunes/features/auth/presentation/pages/login_page.dart';
import 'package:mindtunes/features/auth/presentation/widgets/auth_field.dart';
import 'package:mindtunes/features/auth/presentation/widgets/auth_gradient_button.dart';

class ResetPassword extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const ResetPassword());
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final emailController = TextEditingController();

  final formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              showSnackBar(context, state.message);
            } else if (state is AuthSuccess1) {
              showSnackBar(context, state.message, iserror: false);
              Navigator.pushAndRemoveUntil(
                  context, LoginPage.route(), (route) => false);
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Loader();
            }
            return Form(
              key: formkey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "Reset Password through Email",
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),
                    AuthField(
                      icon: const Icon(CupertinoIcons.mail),
                      hintText: "Email",
                      controller: emailController,
                      action: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter Email to reset password";
                        } else if (!RegExp(
                                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                            .hasMatch(value)) {
                          return "Please enter valid email";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    const SizedBox(height: 20),
                    AuthGradientButton(
                      buttonName: "Reset Password",
                      onPress: () {
                        if (formkey.currentState!.validate()) {
                          context.read<AuthBloc>().add(
                                AuthResetPassword(
                                    email: emailController.text.trim()),
                              );
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
