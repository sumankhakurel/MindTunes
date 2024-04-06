import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'navbar_state.dart';

class NavbarCubit extends Cubit<NavbarState> {
  NavbarCubit() : super(NavbarInitial());

  void updateindex(int index) {
    emit(NavbarIndexhange(index: index));
  }
}
