import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mindtunes/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:mindtunes/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:mindtunes/features/auth/data/data_sources/auth_remote_data_source_impl.dart';
import 'package:mindtunes/features/auth/data/repository/auth_repository_impl.dart';
import 'package:mindtunes/features/auth/domain/repository/auth_repository.dart';
import 'package:mindtunes/features/auth/domain/usecases/current_user.dart';
import 'package:mindtunes/features/auth/domain/usecases/delete_account.dart';
import 'package:mindtunes/features/auth/domain/usecases/logout.dart';
import 'package:mindtunes/features/auth/domain/usecases/reset_password.dart';
import 'package:mindtunes/features/auth/domain/usecases/user_login.dart';
import 'package:mindtunes/features/auth/domain/usecases/user_sign_up.dart';
import 'package:mindtunes/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mindtunes/features/meditation/data/data_sources/firebase_data_source.dart';
import 'package:mindtunes/features/meditation/data/data_sources/firebase_data_source_impl.dart';
import 'package:mindtunes/features/meditation/data/data_sources/mindwave_device_data_source.dart';
import 'package:mindtunes/features/meditation/data/data_sources/mindwave_device_data_source_impl.dart';
import 'package:mindtunes/features/meditation/data/repository/firebase_repository_impl.dart';
import 'package:mindtunes/features/meditation/data/repository/mindwave_device_repository_impl.dart';
import 'package:mindtunes/features/meditation/domain/repository/firebase_repository.dart';
import 'package:mindtunes/features/meditation/domain/repository/mindwave_device_repository.dart';
import 'package:mindtunes/features/meditation/domain/usecases/get_meditation_history.dart';
import 'package:mindtunes/features/meditation/domain/usecases/get_music.dart';
import 'package:mindtunes/features/meditation/domain/usecases/mindwave_device_disconnect.dart';
import 'package:mindtunes/features/meditation/domain/usecases/scan_mindwave_device.dart';
import 'package:mindtunes/features/meditation/domain/usecases/update_meditation_session.dart';
import 'package:mindtunes/features/meditation/presentation/bloc/firebasebloc/firebase_bloc.dart';
import 'package:mindtunes/features/meditation/presentation/bloc/firebasedataBloc/bloc/firebasedata_bloc.dart';
import 'package:mindtunes/features/meditation/presentation/bloc/meditationbloc/bloc/meditation_bloc.dart';
import 'package:mindtunes/features/meditation/presentation/bloc/mindwavedevicebloc/mindwavedevice_bloc.dart';
import 'package:mindtunes/features/meditation/presentation/bloc/playerbloc/player_bloc.dart';
import 'package:mindtunes/features/meditation/presentation/cubit/navbar_cubit.dart';

import 'package:mindtunes/firebase_options.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependicies() async {
  _initAuth();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  //core
  serviceLocator.registerLazySingleton(() => AppUserCubit());
  serviceLocator.registerLazySingleton(() => NavbarCubit());
}

void _initAuth() {
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteSourceImpl(
        FirebaseAuth.instance,
        FirebaseFirestore.instance,
      ),
    )
    ..registerFactory<AuthRepository>(
      () => AuthReposotoriesImpl(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserSignUp(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserLogin(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => CurrentUser(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => Logout(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => DeleteAccount(
        serviceLocator(),
      ),
    )
    ..registerFactory(() => ResetPassword(
          serviceLocator(),
        ))
    ..registerFactory<FirebaseDataSource>(() => FirebaseDataSourceImpl(
          FirebaseFirestore.instance,
          FirebaseAuth.instance,
        ))
    ..registerFactory<FirebaseRepository>(() => FirebaseRepositoryImpl(
          serviceLocator(),
        ))
    ..registerFactory(() => GetMusic(
          serviceLocator(),
        ))
    ..registerFactory<MindwaveDeviceDataSource>(
        () => MindwaveDeviceDataSourceImpl(
              FlutterBlue.instance,
            ))
    ..registerFactory<MindwaveDeviceRepository>(
        () => MindwaveDeviceRepositoryImpl(
              serviceLocator(),
            ))
    ..registerFactory(() => ScanMindwaveDevice(
          serviceLocator(),
        ))
    ..registerFactory(() => UpdateMeditationSession(
          serviceLocator(),
        ))
    ..registerFactory(() => MindwaveDeviceDisconnect(
          serviceLocator(),
        ))
    ..registerFactory(() => GetMeditationHistory(
          serviceLocator(),
        ))
    ..registerLazySingleton(() => MindwavedeviceBloc(
          mindwaveDevice: serviceLocator(),
          mindwaveDeviceDisconnect: serviceLocator(),
        ))
    ..registerLazySingleton(
      () => AuthBloc(
        userSignup: serviceLocator(),
        userLogin: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator(),
        logout: serviceLocator(),
        deleteAccount: serviceLocator(),
        resetPassword: serviceLocator(),
      ),
    )
    ..registerLazySingleton(() => MeditationBloc(
          meditationSession: serviceLocator(),
        ))
    ..registerLazySingleton(() => FirebaseBloc(
          getMusic: serviceLocator(),
        ))
    ..registerLazySingleton(() => PlayerBloc(
          AudioPlayer(),
        ))
    ..registerLazySingleton(() => FirebasedataBloc(
          getMeditationHistory: serviceLocator(),
        ));
}
