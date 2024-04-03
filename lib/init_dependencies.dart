import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_mindwave_mobile_2_plugin/flutter_mindwave_mobile_2.dart';
import 'package:get_it/get_it.dart';
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
import 'package:mindtunes/features/meditation/data/data_sources/mindwave_data_source.dart';
import 'package:mindtunes/features/meditation/data/data_sources/mindwave_data_source_impl.dart';
import 'package:mindtunes/features/meditation/data/repository/mindwave_repository_impl.dart';
import 'package:mindtunes/features/meditation/domain/repository/mindwave_repository.dart';
import 'package:mindtunes/features/meditation/domain/usecases/bluetooth_connect.dart';
import 'package:mindtunes/features/meditation/domain/usecases/get_raw_eeg_data.dart';
import 'package:mindtunes/features/meditation/presentation/bloc/bloc/mindwave_bloc.dart';

import 'package:mindtunes/firebase_options.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependicies() async {
  _initAuth();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  //core
  serviceLocator.registerLazySingleton(() => AppUserCubit());
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
    ..registerFactory<MindwaveDataSource>(
      () => MindwaveDataSourceImpl(
        FlutterBlue.instance,
        FlutterMindWaveMobile2(),
        MWMConnectionState.disconnected,
        null,
      ),
    )
    ..registerFactory<MindwaveRepository>(
      () => MindwaveRepositoryImpl(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => BluetoothConnect(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetRaweegData(
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
    ..registerLazySingleton(
      () => MindwaveBloc(
        bluetoothConnect: serviceLocator(),
        getRaweegData: serviceLocator(),
      ),
    );
}
