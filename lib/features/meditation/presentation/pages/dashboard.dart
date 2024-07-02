import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mindwave_mobile_2_plugin/flutter_mindwave_mobile_2.dart';
import 'package:mindtunes/core/theme/app_pallet.dart';
import 'package:mindtunes/core/utils/show_snacksbar.dart';
import 'package:mindtunes/features/meditation/presentation/bloc/mindwavedevicebloc/mindwavedevice_bloc.dart';
import 'package:mindtunes/features/meditation/presentation/cubit/navbar_cubit.dart';
import 'package:mindtunes/features/meditation/presentation/widgets/button.dart';
import 'package:mindtunes/features/meditation/presentation/widgets/chart.dart';
import 'package:mindtunes/features/meditation/presentation/widgets/empty_chart.dart';
import 'package:mindtunes/features/meditation/presentation/widgets/meditation_history.dart';
import 'package:mindtunes/features/meditation/presentation/widgets/signal_bar.dart';
import 'package:mindtunes/features/meditation/presentation/widgets/test.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.navColour,
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context
                              .read<MindwavedeviceBloc>()
                              .add(MindwavedeviceScanEvent());
                          //context.read<MindwaveBloc>().add(Bluconnect());
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => const TestWeidget()));
                        },
                        child: const Icon(
                          CupertinoIcons.add_circled_solid,
                          size: 30,
                        ),
                      ),
                      Text(
                        "MindTunes",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.read<NavbarCubit>().updateindex(0);
                        },
                        child: const Icon(
                          CupertinoIcons.person_crop_circle_fill,
                          size: 30,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "DASHBOARD",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          BlocConsumer<MindwavedeviceBloc, MindwavedeviceState>(
                            listener: (context, state) {
                              if (state is MindwavedeviceScanFail) {
                                showSnackBar(context, state.message);
                              }
                            },
                            builder: (context, state) {
                              if (state is MindwavedeviceLoadingState) {
                                return const BluButton(
                                  bluStatus: "Connecting",
                                );
                              } else if (state is MindwavedeviceSucess) {
                                return BluButton(
                                  bluStatus: state.status,
                                );
                              } else {
                                return const BluButton(
                                  bluStatus: "Disconnected",
                                );
                              }
                            },
                          ),
                        ],
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 150,
                          child: Image.asset("assets/icons/Meditation.png"),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                clipBehavior: Clip.antiAlias,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: AppPallete.backgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    )),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Visibility(
                        visible: true,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Current Brain Status",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              BlocBuilder<MindwavedeviceBloc,
                                  MindwavedeviceState>(
                                builder: (context, state) {
                                  if (state is MindwavedeviceSucess) {
                                    return StreamBuilder<dynamic>(
                                        stream: state.signal,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return SignalBar(
                                              data: snapshot.data,
                                            );
                                          } else {
                                            return const SignalBar(
                                              data: 200,
                                            );
                                          }
                                        });
                                  } else {
                                    return const SignalBar(
                                      data: 200,
                                    );
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Divider(),
                              const Text("Band Power"),
                              BlocBuilder<MindwavedeviceBloc,
                                  MindwavedeviceState>(
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
                              BlocBuilder<MindwavedeviceBloc,
                                  MindwavedeviceState>(
                                builder: (context, state) {
                                  if (state is MindwavedeviceSucess) {
                                    return StreamBuilder<dynamic>(
                                        stream: state.bandpower,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            var bandPower =
                                                snapshot.data as BandPower;
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
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
                              BlocBuilder<MindwavedeviceBloc,
                                  MindwavedeviceState>(
                                builder: (context, state) {
                                  if (state is MindwavedeviceSucess) {
                                    return CustomLineChart(data: state.attdata);
                                  } else {
                                    return CustomEmptyLineChart();
                                  }
                                },
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  BlocBuilder<MindwavedeviceBloc,
                                      MindwavedeviceState>(
                                    builder: (context, state) {
                                      if (state is MindwavedeviceSucess) {
                                        return StreamBuilder<dynamic>(
                                            stream: state.attdata,
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                return Text(
                                                    "Current Attentation: ${snapshot.data}");
                                              } else {
                                                return const Text(
                                                    "Current Attentation: 0");
                                              }
                                            });
                                      } else {
                                        return const Text(
                                            "Current Attentation: 0");
                                      }
                                    },
                                  ),
                                ],
                              ),
                              const Divider(),
                              const Text("Meditation"),
                              BlocBuilder<MindwavedeviceBloc,
                                  MindwavedeviceState>(
                                builder: (context, state) {
                                  if (state is MindwavedeviceSucess) {
                                    return CustomLineChart(data: state.meddata);
                                  } else {
                                    return CustomEmptyLineChart();
                                  }
                                },
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  BlocBuilder<MindwavedeviceBloc,
                                      MindwavedeviceState>(
                                    builder: (context, state) {
                                      if (state is MindwavedeviceSucess) {
                                        return StreamBuilder<dynamic>(
                                            stream: state.meddata,
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                return Text(
                                                    "Current Meditation: ${snapshot.data}");
                                              } else {
                                                return const Text(
                                                    "Current Meditation: 0");
                                              }
                                            });
                                      } else {
                                        return const Text(
                                            "Current Meditation: 0");
                                      }
                                    },
                                  ),
                                ],
                              ),
                              const MeditationHistory(),
                              const SizedBox(
                                height: 100,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
