// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moshahda_app/Models/MovieModel.dart';
import 'package:moshahda_app/View/Components/HomeScreens/Home.dart';
import 'package:moshahda_app/View/Components/HomeScreens/Movies.dart';
import 'package:moshahda_app/View/Components/HomeScreens/Series.dart';
import 'package:moshahda_app/View/Components/HomeScreens/favorite.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(BuildContext context) => BlocProvider.of(context);
  TextEditingController searchController = TextEditingController();

  int currentPage = 0, focusedIndex = 0;

  List<Widget> screens = [Home(), Favorite(), Movies(), Series()];

  void changePage(int index) {
    currentPage = index;
    emit(ChangePageSuccessState());
  }

  void onItemFocuss(int index) {
    focusedIndex = index;
    emit(ChangeOnFocusInHomeSliderSuccessState());
  }

  ScrollController favoriteScrollController = ScrollController();
  ScrollController moviesScrollController = ScrollController();
  ScrollController seriesScrollController = ScrollController();
      ScrollController showAllController = ScrollController();


  int favoriteLoadedCards = 30, moviesLoadedCards = 30, seriesLoadedCards = 30,showAllLoadedCard=30;

  List<MovieModel> moviesList = [];
  List<MovieModel> arabicMoviesList = [];

  getEnglishMovies() {
    FirebaseFirestore.instance
        .collection('movies')
        .doc('English Movies')
        .get()
        .then((value) {
      value.data()!.forEach((key, value) {
        moviesList.add(MovieModel.fromJson(value));
      });

      emit(GetMoviesSuccessState());
    }).catchError((onError) {
      emit(GetMoviesErrorState());
    });
  }

  getArabicMovies() {
    FirebaseFirestore.instance
        .collection('movies')
        .doc('Arabic Movies')
        .get()
        .then((value) {
      value.data()!.forEach((key, value) {
        arabicMoviesList.add(MovieModel.fromJson(value));
      });

      emit(GetMoviesSuccessState());
    }).catchError((onError) {
      emit(GetMoviesErrorState());
    });
  }

  Map<String, Map<String, dynamic>> moviesMap = {};
  uploadMoviesMap() {
    FirebaseFirestore.instance
        .collection('movies')
        .doc('Arabic Movies')
        .set(moviesMap)
        .then((value) {
      emit(UploadMoviesSuccessState());
    }).catchError((onError) {
      emit(UploadMoviesErrorState());
    });
  }
}
