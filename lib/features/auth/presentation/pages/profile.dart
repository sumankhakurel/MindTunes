import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mindtunes/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:mindtunes/core/common/widgets/circular_avatar.dart';
import 'package:mindtunes/core/theme/app_pallet.dart';
import 'package:mindtunes/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mindtunes/features/auth/presentation/pages/login_page.dart';

import 'package:mindtunes/features/auth/presentation/widgets/auth_gradient_button.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final String userName =
        (context.read<AppUserCubit>().state as AppUserLoggedIn).user.name;
    final String email =
        (context.read<AppUserCubit>().state as AppUserLoggedIn).user.email;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              width: double.infinity,
              height: 150,
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
                      backgroundImage:
                          AssetImage('lib/core/assets/icons/user.png'),
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
            const Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("All Meditations"),
                  SizedBox(
                    height: 15,
                  ),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            CustomCircularAvatar(
                              imageurl: "lib/core/assets/icons/hourglass.png",
                              boderColor: AppPallete.whiteColor,
                              insideColor: AppPallete.backgroundColor,
                            ),
                            Text(
                              "0",
                              style: TextStyle(fontSize: 30),
                            ),
                            Text("Total Minutes"),
                          ],
                        ),
                        VerticalDivider(
                          color: Colors.amber,
                          thickness: 1,
                        ),
                        Column(
                          children: [
                            CustomCircularAvatar(
                              imageurl: "lib/core/assets/icons/lotus.png",
                              boderColor: AppPallete.whiteColor,
                              insideColor: AppPallete.backgroundColor,
                            ),
                            Text(
                              "0",
                              style: TextStyle(fontSize: 30),
                            ),
                            Text("Total Session"),
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
                height: 200,
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
                        height: 40,
                        thickness: 1,
                      ),
                      const Text(
                        "Delete Account",
                        style: TextStyle(color: AppPallete.errorColor),
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
            Padding(
              padding: const EdgeInsets.all(20),
              child: AuthGradientButton(
                  buttonName: "Logout",
                  onPress: () {
                    context.read<AuthBloc>().add(AuthLogout());
                    Navigator.pushReplacement(context, LoginPage.route());
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
