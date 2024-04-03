import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindtunes/core/common/widgets/loader.dart';
import 'package:mindtunes/core/theme/app_pallet.dart';
import 'package:mindtunes/core/utils/show_snacksbar.dart';
import 'package:mindtunes/features/meditation/presentation/bloc/bloc/mindwave_bloc.dart';

class BluButton extends StatelessWidget {
  const BluButton({super.key});

  @override
  Widget build(BuildContext context) {
    var bluStatus = "Disconnected";
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: AppPallete.backgroundColor,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
      child: BlocConsumer<MindwaveBloc, MindwaveState>(
        listener: (context, state) {
          if (state is MindwaveFailure) {
            showSnackBar(context, state.message);
            bluStatus = "Disconnected";
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
              HapticFeedback.heavyImpact();
              if (bluStatus != "connected") {
                context.read<MindwaveBloc>().add(Bluconnect());
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
    );
  }
}
