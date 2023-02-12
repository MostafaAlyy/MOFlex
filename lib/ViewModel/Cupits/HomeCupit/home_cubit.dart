// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:collection';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moshahda_app/Models/MovieModel.dart';
import 'package:moshahda_app/Models/SeriesModel.dart';
import 'package:moshahda_app/View/Components/HomeScreens/Home.dart';
import 'package:moshahda_app/View/Components/HomeScreens/Movies.dart';
import 'package:moshahda_app/View/Components/HomeScreens/Series.dart';
import 'package:moshahda_app/View/Components/HomeScreens/favorite.dart';
import 'package:moshahda_app/ViewModel/Database/local/SQFlightHelper.dart';

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

  int moviesLoadedCards = 10, seriesLoadedCards = 10, showAllLoadedCard = 10;

  static Map<String, MovieModel> favoriteMovies = HashMap();
  static List<String> favoriteMoviesNames = [];

  getFavoriteMoviesFromDB() {
    SQLHelper.getFavoritesMovies().then((value) {
      value.forEach((element) {
        if (favoriteMovies.containsKey(element['name']) != true) {
          favoriteMoviesNames.add(element['name']);
          favoriteMovies['${element['name']}'] = MovieModel.fromJson(element);
        }
      });
      emit(GetFavoriteMoviesFromDBSuccessState());
    });
  }

  FavoriteMoviestoDB(MovieModel movie) {
    if (favoriteMovies.containsKey(movie.name) != true) {
      SQLHelper.db();
      SQLHelper.addMovieToFavorites(
        dateTime: movie.dateTime!,
        description: movie.description!,
        img: movie.img!,
        link: movie.link!,
        name: movie.name!,
      );
    } else {
      SQLHelper.deleteMovieFromFavorites(movie.name!).then((value) {
        favoriteMoviesNames.remove(movie.name!);
        favoriteMovies.remove(movie.name!);
      });
    }
    getFavoriteMoviesFromDB();
    emit(MoviesToDBLoadingState());
  }

  static Map<String, SeriesModel> favoriteSeries = HashMap();
  static List<String> favoriteSeriesNames = [];

  getFavoriteSeriesFromDB() {
    SQLHelper.getFavoritesSeries().then((value) {
      value.forEach((element) {
        if (favoriteSeries.containsKey(element['name']) != true) {
          favoriteSeriesNames.add(element['name']);
          favoriteSeries['${element['name']}'] =
              SeriesModel.fromJsonDB(element);
        }
      });
      emit(GetFavoriteSeriesFromDBSuccessState());
    });
  }

  FavoriteSeriestoDB(SeriesModel series) {
    if (favoriteSeries.containsKey(series.name) != true) {
      SQLHelper.db();

      SQLHelper.addSeriesToFavorites(
        dateTime: series.dateTime!,
        description: series.description!,
        img: series.img!,
        name: series.name!,
      ).then((value) {
        print("done");
      }).catchError((onError) {
        print(onError);
      });
    } else {
      SQLHelper.deleteSeriesFromFavorites(series.name!).then((value) {
        favoriteSeriesNames.remove(series.name!);
        favoriteSeries.remove(series.name!);
      });
    }
    getFavoriteSeriesFromDB();
    emit(SeriesToDBLoadingState());
  }

  List<MovieModel> moviesList = [];
  List<MovieModel> arabicMoviesList = [];

  getEnglishMovies() {
    if (!Platform.isWindows) {
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
    } else {
      Firestore.instance
          .collection('movies')
          .document('English Movies')
          .get()
          .then((value) {
        value.map.forEach((key, value) {
          moviesList.add(MovieModel.fromJson(value));
        });

        emit(GetMoviesSuccessState());
      }).catchError((onError) {
        emit(GetMoviesErrorState());
      });
    }
  }

  getArabicMovies() {
    if (!Platform.isWindows) {
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
    } else {
      Firestore.instance
          .collection('movies')
          .document('Arabic Movies')
          .get()
          .then((value) {
        value.map.forEach((key, value) {
          arabicMoviesList.add(MovieModel.fromJson(value));
        });

        emit(GetMoviesSuccessState());
      }).catchError((onError) {
        emit(GetMoviesErrorState());
      });
    }
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

  List<SeriesModel> englishSeriesList = [];
  getEnglishSeries() {
    if (!Platform.isWindows) {
      FirebaseFirestore.instance
          .collection('Series')
          .doc('English Series')
          .get()
          .then((value) {
        value.data()!.forEach((key, value) {
          englishSeriesList.add(SeriesModel.fromJson(value));
        });

        emit(GetMoviesSuccessState());
      }).catchError((onError) {
        print(onError.toString());
        emit(GetMoviesErrorState());
      });
    } else {
      Firestore.instance
          .collection('Series')
          .document('English Series')
          .get()
          .then((value) {
        value.map.forEach((key, value) {
          englishSeriesList.add(SeriesModel.fromJson(value));
        });

        emit(GetMoviesSuccessState());
      }).catchError((onError) {
        print(onError.toString());
        emit(GetMoviesErrorState());
      });
    }
  }

  List<SeriesModel> arabicSeriesList = [];
  getArabicSeries() {
    if (!Platform.isWindows) {
      FirebaseFirestore.instance
          .collection('Series')
          .doc('Arabic Series')
          .get()
          .then((value) {
        value.data()!.forEach((key, value) {
          arabicSeriesList.add(SeriesModel.fromJson(value));
        });

        emit(GetMoviesSuccessState());
      }).catchError((onError) {
        print(onError.toString());
        emit(GetMoviesErrorState());
      });
    } else {
      Firestore.instance
          .collection('Series')
          .document('Arabic Series')
          .get()
          .then((value) {
        value.map.forEach((key, value) {
          arabicSeriesList.add(SeriesModel.fromJson(value));
        });

        emit(GetMoviesSuccessState());
      }).catchError((onError) {
        print(onError.toString());
        emit(GetMoviesErrorState());
      });
    }
  }

  List<SeriesModel> ramadan2022SeriesList = [];
  getRamadan2022Series() {
    if (!Platform.isWindows) {
      FirebaseFirestore.instance
          .collection('Series')
          .doc('Ramadan 2022')
          .get()
          .then((value) {
        value.data()!.forEach((key, value) {
          ramadan2022SeriesList.add(SeriesModel.fromJson(value));
        });

        emit(GetMoviesSuccessState());
      }).catchError((onError) {
        print(onError.toString());
        emit(GetMoviesErrorState());
      });
    } else {
      Firestore.instance
          .collection('Series')
          .document('Ramadan 2022')
          .get()
          .then((value) {
        value.map!.forEach((key, value) {
          ramadan2022SeriesList.add(SeriesModel.fromJson(value));
        });

        emit(GetMoviesSuccessState());
      }).catchError((onError) {
        print(onError.toString());
        emit(GetMoviesErrorState());
      });
    }
  }

  List<SeriesModel> ramadan2023SeriesList = [];
  getRamadan2023Series() {
    if (!Platform.isWindows) {
      FirebaseFirestore.instance
          .collection('Series')
          .doc('Ramadan 2023')
          .get()
          .then((value) {
        value.data()!.forEach((key, value) {
          ramadan2023SeriesList.add(SeriesModel.fromJson(value));
        });

        emit(GetMoviesSuccessState());
      }).catchError((onError) {
        print(onError.toString());
        emit(GetMoviesErrorState());
      });
    } else {
      Firestore.instance
          .collection('Series')
          .document('Ramadan 2023')
          .get()
          .then((value) {
        value.map.forEach((key, value) {
          ramadan2023SeriesList.add(SeriesModel.fromJson(value));
        });

        emit(GetMoviesSuccessState());
      }).catchError((onError) {
        print(onError.toString());
        emit(GetMoviesErrorState());
      });
    }
  }

  Map<String, Map<String, dynamic>> seriessMap = {};
  uploadSeriesMap() {
    FirebaseFirestore.instance
        .collection('Series')
        .doc('Ramadan 2022')
        .set(seriessMap)
        .then((value) {
      emit(UploadMoviesSuccessState());
    }).catchError((onError) {
      emit(UploadMoviesErrorState());
    });
  }
}
