part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class ChangePageSuccessState extends HomeState {}

class ChangeOnFocusInHomeSliderSuccessState extends HomeState {}
