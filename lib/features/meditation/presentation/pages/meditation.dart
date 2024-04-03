import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindtunes/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:mindtunes/core/theme/app_pallet.dart';
import 'package:mindtunes/features/meditation/presentation/pages/meditationlive.dart';
import 'package:mindtunes/features/meditation/presentation/widgets/button.dart';

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
                        onTap: () {},
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
                        onTap: () {},
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
                    child: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Select Music to start Meditation",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Embrace the stillness within. Let go of the chaos without. Find peace in the rhythm of your breath.",
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                  color: AppPallete.lightColor,
                                  fontStyle: FontStyle.italic,
                                ),
                          ),
                          SizedBox(
                            height: 210,
                            child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                // shrinkWrap: true,
                                itemCount: 20,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, position) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MeditationLive(
                                                      title: position
                                                          .toString())));
                                    },
                                    child: Card(
                                      clipBehavior: Clip.hardEdge,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            constraints: const BoxConstraints(
                                                minHeight: 150),
                                            height: 150,
                                            width: 200,
                                            color: AppPallete.errorColor,
                                            child: Image.asset(
                                              "assets/images/meditation.jpg",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 200,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                      "Meditation",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                    ),
                                                  ),
                                                  Expanded(
                                                      child: Text(
                                                    "15:00",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelSmall
                                                        ?.copyWith(
                                                            color: AppPallete
                                                                .lightColor),
                                                    textAlign: TextAlign.end,
                                                  )),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
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
