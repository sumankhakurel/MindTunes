import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindtunes/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:mindtunes/core/theme/app_pallet.dart';
import 'package:mindtunes/features/meditation/presentation/bloc/mindwarebloc/mindwave_bloc.dart';
import 'package:mindtunes/features/meditation/presentation/cubit/navbar_cubit.dart';
import 'package:mindtunes/features/meditation/presentation/widgets/button.dart';
import 'package:mindtunes/features/meditation/presentation/widgets/meditation_musics.dart';

class Meditation extends StatelessWidget {
  const Meditation({super.key});

  @override
  Widget build(BuildContext context) {
    final String userName =
        (context.read<AppUserCubit>().state as AppUserLoggedIn).user.name;
    return Scaffold(
      backgroundColor: AppPallete.backgroundColor,
      body: SafeArea(
        bottom: false,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.read<MindwaveBloc>().add(Bluconnect());
                        },
                        child: const Icon(CupertinoIcons.add_circled_solid,
                            size: 30, color: AppPallete.navColour),
                      ),
                      Text(
                        "MindTunes",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppPallete.navColour),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.read<NavbarCubit>().updateindex(0);
                        },
                        child: const Icon(
                            CupertinoIcons.person_crop_circle_fill,
                            size: 30,
                            color: AppPallete.navColour),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text("Good Morning $userName"),
                Text(
                  "Connect With Device",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BluButton(),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: Alignment.topCenter,
                    height: 300,
                    decoration: const BoxDecoration(
                      color: AppPallete.borderColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: const MeditationMusics(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Zen Harmony: Embrace the Moment",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Find harmony in each breath, stillness in each pause. In the quiet space within, discover serenity's embrace. Zen Harmony guides the mind to tranquility, where the present moment unfolds with grace. Let go, breathe, and be",
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall
                            ?.copyWith(color: AppPallete.lightColor),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    clipBehavior: Clip.hardEdge,
                    child: Image.asset("assets/images/meditation.jpg"),
                  ),
                ),
                const Divider(),
                const SizedBox(
                  height: 100,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
