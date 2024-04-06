import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindtunes/core/theme/app_pallet.dart';
import 'package:mindtunes/features/auth/presentation/pages/profile.dart';
import 'package:mindtunes/features/meditation/presentation/cubit/navbar_cubit.dart';
import 'package:mindtunes/features/meditation/presentation/pages/dashboard.dart';
import 'package:mindtunes/features/meditation/presentation/pages/meditation.dart';

class NavBar extends StatelessWidget {
  static PageRoute route() {
    return MaterialPageRoute(builder: (_) => const NavBar());
  }

  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    int index = 1;
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: BlocBuilder<NavbarCubit, NavbarState>(
        builder: (context, state) {
          if (state is NavbarIndexhange) {
            index = state.index;
          }
          return CurvedNavigationBar(
            items: const [
              Icon(CupertinoIcons.profile_circled),
              Icon(CupertinoIcons.house_fill),
              Icon(CupertinoIcons.smiley_fill),
            ],
            backgroundColor: AppPallete.transparentColor,
            color: AppPallete.navColour,
            animationDuration: const Duration(milliseconds: 500),
            index: index,
            onTap: (selectedindex) {
              context.read<NavbarCubit>().updateindex(selectedindex);
            },
          );
        },
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: BlocBuilder<NavbarCubit, NavbarState>(
          builder: (context, state) {
            if (state is NavbarIndexhange) {
              return getSelectedwidget(index: state.index);
            } else {
              return getSelectedwidget(index: 1);
            }
          },
        ),
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
