import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindtunes/core/common/widgets/loader.dart';
import 'package:mindtunes/core/theme/app_pallet.dart';
import 'package:mindtunes/features/meditation/presentation/bloc/firebasebloc/firebase_bloc.dart';
import 'package:mindtunes/features/meditation/presentation/bloc/playerbloc/player_bloc.dart';
import 'package:mindtunes/features/meditation/presentation/pages/meditation_Player.dart';

class MeditationMusics extends StatefulWidget {
  const MeditationMusics({
    super.key,
  });

  @override
  State<MeditationMusics> createState() => _MeditationMusicsState();
}

class _MeditationMusicsState extends State<MeditationMusics> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<FirebaseBloc>(context).add(FirebaseGetMusic());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FirebaseBloc, FirebaseState>(
      builder: (context, state) {
        if (state is FirebaseLoading) {
          return const Loader();
        } else if (state is FirebaseSucess) {
          return Padding(
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
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppPallete.lightColor,
                        fontStyle: FontStyle.italic,
                      ),
                ),
                SizedBox(
                  height: 210,
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      // shrinkWrap: true,
                      itemCount: state.musics.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, position) {
                        return GestureDetector(
                          onTap: () {
                            context.read<PlayerBloc>().add(
                                  PlayEvent(
                                    music: state.musics[position],
                                  ),
                                );
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MeditationPlayer(
                                          music: state.musics[position],
                                        )));
                          },
                          child: Card(
                            clipBehavior: Clip.hardEdge,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  constraints:
                                      const BoxConstraints(minHeight: 150),
                                  height: 150,
                                  width: 200,
                                  color: AppPallete.greyColor,
                                  child: Image.network(
                                    state.musics[position].imageurl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                  width: 200,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Text(
                                            state.musics[position].name,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                        ),
                                        Expanded(
                                            child: Text(
                                          state.musics[position].duration,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall
                                              ?.copyWith(
                                                  color: AppPallete.lightColor),
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
          );
        } else {
          return const Text("Fail to get data");
        }
      },
    );
  }
}
