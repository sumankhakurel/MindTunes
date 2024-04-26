import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mindtunes/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:mindtunes/core/common/widgets/circular_avatar.dart';
import 'package:mindtunes/core/common/widgets/loader.dart';
import 'package:mindtunes/core/theme/app_pallet.dart';
import 'package:mindtunes/core/utils/show_snacksbar.dart';
import 'package:mindtunes/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mindtunes/features/auth/presentation/pages/login_page.dart';
import 'package:mindtunes/features/auth/presentation/pages/reset_password.dart';
import 'package:mindtunes/features/auth/presentation/widgets/auth_field.dart';

import 'package:mindtunes/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:mindtunes/features/meditation/presentation/bloc/firebasedataBloc/bloc/firebasedata_bloc.dart';

class Profile extends StatefulWidget {
  Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final passwordController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String userName =
        (context.read<AppUserCubit>().state as AppUserLoggedIn).user.name;
    final String email =
        (context.read<AppUserCubit>().state as AppUserLoggedIn).user.email;

    return SafeArea(
      bottom: false,
      child: Scaffold(
        body: Column(
          children: [
            Container(
              width: double.infinity,
              height: 140,
              decoration: const BoxDecoration(
                  color: AppPallete.navColour,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  )),
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      backgroundColor: AppPallete.whiteColor,
                      backgroundImage: AssetImage('assets/icons/user.png'),
                    ),
                    const VerticalDivider(
                      indent: 40,
                      endIndent: 40,
                      color: Colors.amber,
                      thickness: 1,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          userName,
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppPallete.whiteColor,
                                  ),
                        ),
                        Text(
                          email,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                  fontStyle: FontStyle.normal,
                                  fontSize: 13,
                                  color: AppPallete.backgroundColor),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("All Meditations"),
                  const SizedBox(
                    height: 15,
                  ),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            const CustomCircularAvatar(
                              imageurl: "assets/icons/hourglass.png",
                              boderColor: AppPallete.whiteColor,
                              insideColor: AppPallete.backgroundColor,
                            ),
                            Text(
                              (context.read<FirebasedataBloc>().state
                                      as FirebasedataSucess)
                                  .totalminutes
                                  .toStringAsFixed(2),
                              style: const TextStyle(fontSize: 30),
                            ),
                            const Text("Total Minutes"),
                          ],
                        ),
                        const VerticalDivider(
                          color: Colors.amber,
                          thickness: 1,
                        ),
                        Column(
                          children: [
                            const CustomCircularAvatar(
                              imageurl: "assets/icons/lotus.png",
                              boderColor: AppPallete.whiteColor,
                              insideColor: AppPallete.backgroundColor,
                            ),
                            Text(
                              (context.read<FirebasedataBloc>().state
                                      as FirebasedataSucess)
                                  .totalsessions
                                  .toString(),
                              style: const TextStyle(fontSize: 30),
                            ),
                            const Text("Total Session"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Container(
                color: AppPallete.borderColor,
                height: 180,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "Contact Us",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.phone,
                            color: AppPallete.errorColor,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          RichText(
                            text: const TextSpan(children: <TextSpan>[
                              TextSpan(text: "Phone Number : "),
                              TextSpan(
                                text: "9803309870",
                                style: TextStyle(
                                  color: AppPallete.greyColor,
                                ),
                              ),
                            ]),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.mail,
                            color: AppPallete.errorColor,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          RichText(
                            text: const TextSpan(children: <TextSpan>[
                              TextSpan(text: "Email : "),
                              TextSpan(
                                text: "sumankhakurel09@gmail.com",
                                style: TextStyle(
                                  color: AppPallete.greyColor,
                                ),
                              ),
                            ]),
                          ),
                        ],
                      ),
                      const Divider(
                        height: 20,
                        thickness: 1,
                      ),
                      GestureDetector(
                        child: const Text(
                          "Delete Account",
                          style: TextStyle(color: AppPallete.errorColor),
                        ),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return BlocConsumer<AuthBloc, AuthState>(
                                listener: (context, state) {
                                  if (state is AuthFailure) {
                                    showSnackBar(context, state.message);
                                  } else if (state is AuthSuccess1) {
                                    showSnackBar(context, state.message,
                                        iserror: false);
                                    Navigator.pushReplacement(
                                        context, LoginPage.route());
                                  }
                                },
                                builder: (context, state) {
                                  if (state is AuthLoading) {
                                    return const Loader();
                                  }
                                  return AlertDialog(
                                      title: const Text(
                                          "Enter Your Password for verification"),
                                      actions: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("Cancel"),
                                            ),
                                            ElevatedButton(
                                                onPressed: () {
                                                  if (formkey.currentState!
                                                      .validate()) {
                                                    context
                                                        .read<AuthBloc>()
                                                        .add(DeleteUser(
                                                            email: email,
                                                            password:
                                                                passwordController
                                                                    .text));
                                                  }
                                                },
                                                child: const Text("Confirm"))
                                          ],
                                        )
                                      ],
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Form(
                                            key: formkey,
                                            child: AuthField(
                                              icon: const Icon(
                                                  CupertinoIcons.lock),
                                              hintText: "Password",
                                              controller: passwordController,
                                              isObsecuteText: true,
                                              action: TextInputAction.done,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Password is missing!";
                                                } else if (value.length < 5) {
                                                  return "Minimum password length is 5";
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                        ],
                                      ));
                                },
                              );
                            },
                          );
                        },
                      ),
                      const Text(
                        "You can delete your account and data permanently",
                        style: TextStyle(
                          color: AppPallete.errorColor,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 15,
                bottom: 10,
              ),
              child: BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthFailure) {
                    showSnackBar(context, state.message);
                  } else if (state is AuthSuccess1) {
                    showSnackBar(context, state.message, iserror: false);
                    Navigator.pushReplacement(context, LoginPage.route());
                  }
                },
                builder: (context, state) {
                  return AuthGradientButton(
                      buttonName: "Logout",
                      onPress: () {
                        context.read<AuthBloc>().add(AuthLogout());
                      });
                },
              ),
            ),
            GestureDetector(
              child: Text(
                "Reset Password",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppPallete.errorColor,
                    ),
              ),
              onTap: () {
                Navigator.push(context, ResetPassword.route());
              },
            ),
          ],
        ),
      ),
    );
  }
}
