import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindtunes/core/theme/app_pallet.dart';
import 'package:mindtunes/features/meditation/domain/entities/music.dart';
import 'package:mindtunes/features/meditation/presentation/bloc/playerbloc/player_bloc.dart';
import 'package:mindtunes/features/meditation/presentation/widgets/chart.dart';

class MeditationPlayer extends StatelessWidget {
  final Music music;
  MeditationPlayer({super.key, required this.music});

  //var value = 0.0;
  var current = "00:00";

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        context.read<PlayerBloc>().add(PlayerStopEvent());
      },
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(music.imageurl),
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
                music.name,
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
                      music.duration,
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
                      music: music,
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
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Current Brain Status",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Divider(),
                    Text("Band Power"),
                    CustomLineChart(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Alpha: 10"),
                        Text("Beta: 20"),
                        Text("Gamma: 300"),
                      ],
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
