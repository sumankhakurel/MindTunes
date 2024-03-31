import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindtunes/core/common/widgets/loader.dart';
import 'package:mindtunes/core/theme/app_pallet.dart';
import 'package:mindtunes/core/utils/show_snacksbar.dart';
import 'package:mindtunes/features/meditation/presentation/bloc/bloc/mindwave_bloc.dart';
import 'package:mindtunes/features/meditation/presentation/widgets/chart.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    var bluStatus = "Connect To Device";
    var data = 0;
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
                        onTap: () {},
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
                        onTap: () {},
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
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppPallete.backgroundColor,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                            child: BlocConsumer<MindwaveBloc, MindwaveState>(
                              listener: (context, state) {
                                if (state is MindwaveFailure) {
                                  showSnackBar(context, state.message);
                                  bluStatus = "Connect To Device";
                                } else if (state is MindwaveSucess) {
                                  bluStatus = state.message;
                                }
                              },
                              builder: (context, state) {
                                if (state is MindwaveLoading) {
                                  return const Loader();
                                }
                                return GestureDetector(
                                  onTap: () {
                                    if (bluStatus != "connected") {
                                      context
                                          .read<MindwaveBloc>()
                                          .add(Bluconnect());
                                    } else {
                                      //disconnect bloc
                                    }
                                  },
                                  child: Text(
                                    bluStatus,
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 150,
                          child: Image.asset(
                              "lib/core/assets/icons/Meditation.png"),
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
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  const Text("Device Signal"),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    width: 200,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppPallete.borderColor),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: LinearProgressIndicator(
                                        value: 150 /
                                            200, // Convert signal strength to progress value (0-1)
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          _getColor(
                                              90), // Get color based on signal strength
                                        ),
                                        backgroundColor: Colors
                                            .grey[300], // Background color
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Text("150")
                                ],
                              ),
                              Divider(),
                              Text("Band Power"),
                              BlocConsumer<MindwaveBloc, MindwaveState>(
                                listener: (context, state) {
                                  if (state is MindwaveDataSuccess) {
                                    data = state.data;
                                  }
                                },
                                builder: (context, state) {
                                  if (state is MindwaveLoading) {
                                    return const Loader();
                                  }
                                  return GestureDetector(
                                    onTap: () {
                                      context
                                          .read<MindwaveBloc>()
                                          .add(GetRawSignal());
                                    },
                                    child: Text(
                                      data.toString(),
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              CustomLineChart(),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 300,
                        // color: Color.fromARGB(255, 243, 33, 33),
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

  Color _getColor(double strength) {
    if (strength >= 75) {
      return Colors.green; // Strong signal (75-100)
    } else if (strength >= 50) {
      return Colors.yellow; // Moderate signal (50-74)
    } else if (strength >= 25) {
      return Colors.orange; // Weak signal (25-49)
    } else {
      return Colors.red; // Very weak signal (0-24)
    }
  }
}
