import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:mindtunes/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:mindtunes/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:mindtunes/features/auth/data/data_sources/auth_remote_data_source_impl.dart';
import 'package:mindtunes/features/auth/data/repository/auth_repository_impl.dart';
import 'package:mindtunes/features/auth/domain/repository/auth_repository.dart';
import 'package:mindtunes/features/auth/domain/usecases/current_user.dart';
import 'package:mindtunes/features/auth/domain/usecases/logout.dart';
import 'package:mindtunes/features/auth/domain/usecases/user_login.dart';
import 'package:mindtunes/features/auth/domain/usecases/user_sign_up.dart';
import 'package:mindtunes/features/auth/presentation/bloc/auth_bloc.dart';
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
    ..registerLazySingleton(
      () => AuthBloc(
        userSignup: serviceLocator(),
        userLogin: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator(),
        logout: serviceLocator(),
      ),
    );
}
