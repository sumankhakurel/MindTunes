import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mindtunes/core/theme/app_pallet.dart';
import 'package:mindtunes/features/auth/presentation/pages/profile.dart';
import 'package:mindtunes/features/meditation/presentation/pages/dashboard.dart';
import 'package:mindtunes/features/meditation/presentation/pages/meditation.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int index = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: CurvedNavigationBar(
        items: const [
          Icon(CupertinoIcons.profile_circled),
          Icon(CupertinoIcons.house_fill),
          Icon(CupertinoIcons.smiley_fill),
        ],
        backgroundColor: AppPallete.transparentColor,
        color: AppPallete.navColour,
        animationDuration: const Duration(milliseconds: 500),
        index: 1,
        onTap: (selectedindex) {
          setState(() {
            index = selectedindex;
          });
        },
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: getSelectedwidget(index: index),
      ),
    );
  }

  Widget getSelectedwidget({required int index}) {
    Widget widget;
    switch (index) {
      case 0:
        widget = Profile();
        break;
      case 1:
        widget = Dashboard();
        break;
      case 2:
        widget = Meditation();
        break;
      default:
        widget = Dashboard();
    }
    return widget;
  }
}
