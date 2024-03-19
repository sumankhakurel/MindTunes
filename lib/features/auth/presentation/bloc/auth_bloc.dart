import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindtunes/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:mindtunes/core/usecase/usecase.dart';
import 'package:mindtunes/core/common/entities/user.dart';
import 'package:mindtunes/features/auth/domain/usecases/current_user.dart';
import 'package:mindtunes/features/auth/domain/usecases/logout.dart';
import 'package:mindtunes/features/auth/domain/usecases/user_login.dart';
import 'package:mindtunes/features/auth/domain/usecases/user_sign_up.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;
  final Logout _logout;
  AuthBloc({
    required UserSignUp userSignup,
    required UserLogin userLogin,
    required CurrentUser currentUser,
    required AppUserCubit appUserCubit,
    required Logout logout,
  })  : _userSignUp = userSignup,
        _userLogin = userLogin,
        _currentUser = currentUser,
        _appUserCubit = appUserCubit,
        _logout = logout,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));

    on<AuthLogout>((event, emit) async {
      final res = await _logout(NoParams());
      res.fold(
        (l) => emit(AuthFailure(l.message)),
        (user) => emit(AuthSuccess(user)),
      );
    });

    on<AuthisUserloggedin>((event, emit) async {
      final res = await _currentUser(NoParams());
      res.fold(
        (l) => emit(AuthFailure(l.message)),
        (user) => _emitAuthSuccess(user, emit),
      );
    });

    on<AuthSignUp>(
      (event, emit) async {
        final res = await _userSignUp(UserSignupParms(
          email: event.email,
          password: event.password,
          name: event.name,
        ));
        res.fold(
          (l) => emit(AuthFailure(l.message)),
          (user) => _emitAuthSuccess(user, emit),
        );
      },
    );
    on<AuthLogin>(
      (event, emit) async {
        final res = await _userLogin(UserLoginParms(
          email: event.email,
          password: event.password,
        ));
        res.fold(
          (l) => emit(AuthFailure(l.message)),
          (user) => _emitAuthSuccess(user, emit),
        );
      },
    );
  }

  void _emitAuthSuccess(User user, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(user);

    emit(AuthSuccess(user));
  }
}
