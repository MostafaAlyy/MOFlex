part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class ChangePageSuccessState extends HomeState {}

class ChangeOnFocusInHomeSliderSuccessState extends HomeState {}

//upload movies state
class UploadMoviesSuccessState extends HomeState {}

class UploadMoviesErrorState extends HomeState {}

//Get movies state
class GetMoviesSuccessState extends HomeState {}

class GetMoviesErrorState extends HomeState {}

class GetMoviesLoadingState extends HomeState {}

//load more cards on screen states
class LoadMoreCardsMoviesSuccessState extends HomeState {}

class LoadMoreCardsSeriesSuccessState extends HomeState {}

class LoadMoreCardsFavoriteSuccessState extends HomeState {}
