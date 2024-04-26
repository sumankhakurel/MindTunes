import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindtunes/core/common/widgets/loader.dart';
import 'package:mindtunes/core/theme/app_pallet.dart';
import 'package:mindtunes/features/meditation/presentation/bloc/firebasedataBloc/bloc/firebasedata_bloc.dart';

class MeditationHistory extends StatefulWidget {
  const MeditationHistory({
    super.key,
  });

  @override
  State<MeditationHistory> createState() => _MeditationHistoryState();
}

class _MeditationHistoryState extends State<MeditationHistory> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<FirebasedataBloc>(context).add(Firebasedatagetevent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FirebasedataBloc, FirebasedataState>(
      builder: (context, state) {
        if (state is FirebasedataLoading) {
          return const Loader();
        } else if (state is FirebasedataSucess) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Meditation History",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                "Here is your meditation session history of all time",
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppPallete.lightColor,
                      fontStyle: FontStyle.italic,
                    ),
              ),
              SizedBox(
                height: 230,
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    // shrinkWrap: true,
                    itemCount: state.meditation.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, position) {
                      return Card(
                        clipBehavior: Clip.hardEdge,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 250,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Attentation",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: AppPallete.gradient1),
                                    ),
                                    Text(
                                      textAlign: TextAlign.end,
                                      "${state.meditation[position].starttime.year}-${state.meditation[position].starttime.month}-${state.meditation[position].starttime.day}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall
                                          ?.copyWith(
                                            color: AppPallete.lightColor,
                                            fontStyle: FontStyle.italic,
                                          ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "Min: ${state.meditation[position].minAttentation}"),
                                      const VerticalDivider(
                                        color: AppPallete.whiteColor,
                                        thickness: 1,
                                      ),
                                      Text(
                                          "Avg: ${state.meditation[position].avgAttentation.toStringAsFixed(2)}"),
                                      const VerticalDivider(
                                        color: AppPallete.whiteColor,
                                        thickness: 1,
                                      ),
                                      Text(
                                          "Max: ${state.meditation[position].maxAttentation}"),
                                    ],
                                  ),
                                ),
                                const Divider(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Meditation",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: AppPallete.gradient1),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "Min: ${state.meditation[position].maxMeditation}"),
                                      const VerticalDivider(
                                        color: AppPallete.whiteColor,
                                        thickness: 1,
                                      ),
                                      Text(
                                          "Avg: ${state.meditation[position].avgMeditation.toStringAsFixed(2)}"),
                                      const VerticalDivider(
                                        color: AppPallete.whiteColor,
                                        thickness: 1,
                                      ),
                                      Text(
                                          "Max: ${state.meditation[position].minMeditation}"),
                                    ],
                                  ),
                                ),
                                const Divider(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Start Time : ${state.meditation[position].starttime.hour}:${state.meditation[position].starttime.minute}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall
                                          ?.copyWith(
                                            color: AppPallete.lightColor,
                                            fontStyle: FontStyle.italic,
                                          ),
                                    ),
                                    const VerticalDivider(),
                                    Text(
                                      "End Time: ${state.meditation[position].endtime.hour}:${state.meditation[position].endtime.minute}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall
                                          ?.copyWith(
                                            color: AppPallete.lightColor,
                                            fontStyle: FontStyle.italic,
                                          ),
                                    ),
                                    const Divider()
                                  ],
                                ),
                                const Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Text("Total Session Duration"),
                                        Text(
                                          "${state.meditation[position].duration.toInt()} Minute: ${((state.meditation[position].duration - state.meditation[position].duration.toInt()) * 60).round()} Second",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: AppPallete.gradient1),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          );
        } else {
          return const Text("Fail to get data");
        }
      },
    );
  }
}
