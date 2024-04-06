part of 'navbar_cubit.dart';

@immutable
sealed class NavbarState {}

final class NavbarInitial extends NavbarState {}

final class NavbarIndexhange extends NavbarState {
  final int index;

  NavbarIndexhange({required this.index});
}
