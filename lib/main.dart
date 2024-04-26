import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindtunes/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:mindtunes/features/meditation/presentation/bloc/firebasebloc/firebase_bloc.dart';
import 'package:mindtunes/features/meditation/presentation/bloc/firebasedataBloc/bloc/firebasedata_bloc.dart';
import 'package:mindtunes/features/meditation/presentation/bloc/meditationbloc/bloc/meditation_bloc.dart';
import 'package:mindtunes/features/meditation/presentation/bloc/mindwarebloc/mindwave_bloc.dart';
import 'package:mindtunes/features/meditation/presentation/bloc/mindwavedevicebloc/mindwavedevice_bloc.dart';
import 'package:mindtunes/features/meditation/presentation/bloc/playerbloc/player_bloc.dart';
import 'package:mindtunes/features/meditation/presentation/cubit/navbar_cubit.dart';

import 'package:mindtunes/nav_bar.dart';

import 'package:mindtunes/core/theme/theme.dart';
import 'package:mindtunes/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mindtunes/features/auth/presentation/pages/login_page.dart';
import 'package:mindtunes/init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependicies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => serviceLocator<AppUserCubit>()),
      BlocProvider(create: (_) => serviceLocator<AuthBloc>()),
      BlocProvider(create: (_) => serviceLocator<MindwaveBloc>()),
      BlocProvider(create: (_) => serviceLocator<FirebaseBloc>()),
      BlocProvider(create: (_) => serviceLocator<NavbarCubit>()),
      BlocProvider(create: (_) => serviceLocator<PlayerBloc>()),
      BlocProvider(create: (_) => serviceLocator<MindwavedeviceBloc>()),
      BlocProvider(create: (_) => serviceLocator<MeditationBloc>()),
      BlocProvider(create: (_) => serviceLocator<FirebasedataBloc>()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthisUserloggedin());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MindTunes',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkThemeMode,
      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) {
          return state is AppUserLoggedIn;
        },
        builder: (context, isLoggedIn) {
          if (isLoggedIn) {
            print("Hello");
            return const NavBar();
          }
          return const LoginPage();
        },
      ),
    );
  }
}
