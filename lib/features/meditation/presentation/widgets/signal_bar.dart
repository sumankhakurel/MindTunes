import 'package:flutter/material.dart';
import 'package:mindtunes/core/theme/app_pallet.dart';

class SignalBar extends StatelessWidget {
  final int data;
  const SignalBar({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text("Device Signal"),
        const SizedBox(
          width: 10,
        ),
        Container(
          width: 200,
          height: 20,
          decoration: BoxDecoration(
            border: Border.all(color: AppPallete.borderColor),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: 1 -
                  (data /
                      200), // Convert signal strength to progress value (0-1)
              valueColor: AlwaysStoppedAnimation<Color>(
                _getColor(
                    100 - (data / 2)), // Get color based on signal strength
              ),
              backgroundColor: Colors.grey[300], // Background color
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Text((200 - data).toString())
      ],
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
