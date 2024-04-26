import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mindtunes/core/theme/app_pallet.dart';

void showSnackBar(BuildContext context, String content, {bool iserror = true}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        backgroundColor: AppPallete.transparentColor,
        content: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              height: 90,
              decoration: BoxDecoration(
                  color:
                      iserror ? AppPallete.errorColor : AppPallete.greenColor,
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    iserror
                        ? CupertinoIcons.exclamationmark_bubble_fill
                        : CupertinoIcons.check_mark_circled_solid,
                    weight: 40,
                    size: 50,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          iserror ? "Error Occur" : "Successful",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  color: AppPallete.whiteColor,
                                  fontWeight: FontWeight.bold),
                        ),
                        Text(
                          content,
                          style: const TextStyle(
                              fontSize: 18, color: Colors.white),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Positioned(
              top: -10,
              left: 0,
              child: Icon(
                CupertinoIcons.clear_circled_solid,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
}
