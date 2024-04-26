import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindtunes/core/theme/app_pallet.dart';
import 'package:mindtunes/features/meditation/presentation/bloc/mindwavedevicebloc/mindwavedevice_bloc.dart';

class BluButton extends StatelessWidget {
  final String bluStatus;
  const BluButton({super.key, required this.bluStatus});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        HapticFeedback.heavyImpact();
        if (bluStatus != "Connected") {
          context.read<MindwavedeviceBloc>().add(MindwavedeviceScanEvent());
        } else {
          context
              .read<MindwavedeviceBloc>()
              .add(MindwavedeviceDisconnectEvent());
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppPallete.backgroundColor,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
      child: Text(
        bluStatus,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
