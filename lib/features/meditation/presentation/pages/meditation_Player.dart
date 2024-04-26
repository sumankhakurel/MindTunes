import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mindwave_mobile_2_plugin/flutter_mindwave_mobile_2.dart';
import 'package:mindtunes/core/theme/app_pallet.dart';
import 'package:mindtunes/features/meditation/domain/entities/music.dart';
import 'package:mindtunes/features/meditation/presentation/bloc/meditationbloc/bloc/meditation_bloc.dart';
import 'package:mindtunes/features/meditation/presentation/bloc/mindwavedevicebloc/mindwavedevice_bloc.dart';
import 'package:mindtunes/features/meditation/presentation/bloc/playerbloc/player_bloc.dart';
import 'package:mindtunes/features/meditation/presentation/widgets/chart.dart';
import 'package:mindtunes/features/meditation/presentation/widgets/empty_chart.dart';

class MeditationPlayer extends StatefulWidget {
  final Music music;
  const MeditationPlayer({super.key, required this.music});

  @override
  State<MeditationPlayer> createState() => _MeditationPlayerState();
}

class _MeditationPlayerState extends State<MeditationPlayer> {
  @override
  Widget build(BuildContext context) {
    int minAttentation = (context.read<MeditationBloc>().state).minAttentation;
    int maxAttentation = (context.read<MeditationBloc>().state).maxAttentation;
    double avgAttentation =
        (context.read<MeditationBloc>().state).avgAttentation;
    int minMeditation = (context.read<MeditationBloc>().state).minMeditation;
    int maxMeditation = (context.read<MeditationBloc>().state).maxAttentation;
    double avgMeditation = (context.read<MeditationBloc>().state).avgMeditation;
    int totalMeditation = 0;
    int totalAttentation = 0;
    int meditationCounter = 0;
    int attentationCounter = 0;

    return PopScope(
      onPopInvoked: (didPop) {
        context.read<MeditationBloc>().add(MeditationEndEvent());
        context.read<PlayerBloc>().add(PlayerStopEvent());
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppPallete.errorColor,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "End Session",
                  style: TextStyle(color: AppPallete.whiteColor),
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(widget.music.imageurl),
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter),
                ),
                child: Container(
                  height: 200,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppPallete.transparentColor,
                        AppPallete.backgroundColor,
                      ],
                    ),
                  ),
                ),
              ),
              Text(
                widget.music.name,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                "Meditation Music",
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppPallete.gradient1,
                    ),
              ),
              BlocBuilder<PlayerBloc, PlayerState>(
                builder: (context, state) {
                  return Slider(
                    value: state.progress,
                    min: 0,
                    max: 1,
                    activeColor: AppPallete.gradient2,
                    onChanged: (nvalue) {
                      context
                          .read<PlayerBloc>()
                          .add(ProgressSeekEvent(progress: nvalue));
                    },
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocBuilder<PlayerBloc, PlayerState>(
                      builder: (context, state) {
                        if (state.duration == widget.music.duration) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if (Navigator.canPop(context)) {
                              Navigator.of(context).pop();
                            }
                          });
                        }
                        return Text(
                          state.duration,
                          style:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                    color: AppPallete.greyColor,
                                  ),
                        );
                      },
                    ),
                    Text(
                      widget.music.duration,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: AppPallete.greyColor,
                          ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  context.read<PlayerBloc>().add(PlayPauseEvent(
                      music: widget.music,
                      isPlaying: !context.read<PlayerBloc>().isPlaying));
                },
                child: BlocBuilder<PlayerBloc, PlayerState>(
                  builder: (context, state) {
                    return Icon(
                      context.read<PlayerBloc>().isPlaying
                          ? CupertinoIcons.pause_circle_fill
                          : CupertinoIcons.play_circle_fill,
                      size: 60,
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        BlocBuilder<MeditationBloc, MeditationState>(
                          builder: (context, state) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Attentation",
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                                Text("Min: ${state.minAttentation}"),
                                Text(
                                    "Average: ${state.avgAttentation.toStringAsFixed(2)}"),
                                Text("Max: ${state.maxAttentation}"),
                              ],
                            );
                          },
                        ),
                        const VerticalDivider(),
                        BlocBuilder<MeditationBloc, MeditationState>(
                          builder: (context, state) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Meditation",
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                                Text("Min: ${state.minMeditation}"),
                                Text(
                                    "Average: ${state.avgAttentation.toStringAsFixed(2)}"),
                                Text("Max: ${state.maxMeditation}"),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                    // const Divider(),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     const Text("Total Eye blink: 20"),
                    //   ],
                    // ),
                    const Divider(),
                    Text(
                      "Current Brain Status",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Divider(),
                    const Text("Band Power"),
                    BlocBuilder<MindwavedeviceBloc, MindwavedeviceState>(
                      builder: (context, state) {
                        if (state is MindwavedeviceSucess) {
                          return CustomLineChart(
                            data: state.bandpower,
                            isbandpower: true,
                          );
                        } else {
                          return CustomEmptyLineChart();
                        }
                      },
                    ),
                    BlocBuilder<MindwavedeviceBloc, MindwavedeviceState>(
                      builder: (context, state) {
                        if (state is MindwavedeviceSucess) {
                          return StreamBuilder<dynamic>(
                              stream: state.bandpower,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  var bandPower = snapshot.data as BandPower;
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                          "Alpha: ${bandPower.alpha.toStringAsFixed(2)}"),
                                      Text(
                                          "Beta: ${bandPower.beta.toStringAsFixed(2)}"),
                                      Text(
                                          "Gamma: ${bandPower.gamma.toStringAsFixed(2)}"),
                                    ],
                                  );
                                } else {
                                  return const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text("Alpha: 0"),
                                      Text("Beta: 0"),
                                      Text("Gamma: 0"),
                                    ],
                                  );
                                }
                              });
                        } else {
                          return const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("Alpha: 0"),
                              Text("Beta: 0"),
                              Text("Gamma: 0"),
                            ],
                          );
                        }
                      },
                    ),
                    const Divider(),
                    const Text("Attentation"),
                    BlocBuilder<MindwavedeviceBloc, MindwavedeviceState>(
                      builder: (context, state) {
                        if (state is MindwavedeviceSucess) {
                          return CustomLineChart(data: state.attdata);
                        } else {
                          return CustomEmptyLineChart();
                        }
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        BlocBuilder<MindwavedeviceBloc, MindwavedeviceState>(
                          builder: (context, state) {
                            if (state is MindwavedeviceSucess) {
                              return StreamBuilder<dynamic>(
                                  stream: state.attdata,
                                  builder: (context, snapshot) {
                                    context
                                        .read<MeditationBloc>()
                                        .add(MeditationUpdateEvent(
                                          minAttentation: minAttentation,
                                          maxAttentation: maxAttentation,
                                          avgAttentation: avgAttentation,
                                          minMeditation: minMeditation,
                                          maxMeditation: maxMeditation,
                                          avgMeditation: avgMeditation,
                                        ));
                                    if (snapshot.hasData) {
                                      totalAttentation = totalAttentation +
                                          snapshot.data as int;
                                      attentationCounter++;
                                      avgAttentation =
                                          totalAttentation / attentationCounter;
                                      if (snapshot.data < minAttentation ||
                                          minAttentation == 0) {
                                        minAttentation = snapshot.data;
                                      } else if (snapshot.data >
                                          maxAttentation) {
                                        maxAttentation = snapshot.data;
                                      }
                                      return Text(
                                          "Current Attentation: ${snapshot.data}");
                                    } else {
                                      return const Text(
                                          "Current Attentation: 0");
                                    }
                                  });
                            } else {
                              return const Text("Current Attentation: 0");
                            }
                          },
                        ),
                      ],
                    ),
                    const Divider(),
                    const Text("Meditation"),
                    BlocBuilder<MindwavedeviceBloc, MindwavedeviceState>(
                      builder: (context, state) {
                        if (state is MindwavedeviceSucess) {
                          return CustomLineChart(data: state.meddata);
                        } else {
                          return CustomEmptyLineChart();
                        }
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        BlocBuilder<MindwavedeviceBloc, MindwavedeviceState>(
                          builder: (context, state) {
                            if (state is MindwavedeviceSucess) {
                              return StreamBuilder<dynamic>(
                                  stream: state.meddata,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      totalMeditation = totalMeditation +
                                          snapshot.data as int;
                                      meditationCounter++;
                                      avgMeditation =
                                          totalMeditation / meditationCounter;

                                      if (snapshot.hasData) {
                                        if (snapshot.data < minMeditation ||
                                            minMeditation == 0) {
                                          minMeditation = snapshot.data;
                                        } else if (snapshot.data >
                                            maxMeditation) {
                                          maxMeditation = snapshot.data;
                                        }
                                      }
                                      return Text(
                                          "Current Meditation: ${snapshot.data}");
                                    } else {
                                      return const Text(
                                          "Current Meditation: 0");
                                    }
                                  });
                            } else {
                              return const Text("Current Meditation: 0");
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
