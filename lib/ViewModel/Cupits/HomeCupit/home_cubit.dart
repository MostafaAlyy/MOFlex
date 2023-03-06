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

  refresh() {
    Future.delayed(const Duration(seconds: 3), () {
      debugPrint("state Refreshed");
      emit(GetMoviesSuccessState());
    });
  }

  TextEditingController searchController = TextEditingController();
  static List<MovieModel> searchListMovies = [];
  static List<SeriesModel> searchListSeries = [];

  SearchFunctionMovies(String s) async {
    for (int i = 0; i < moviesList.length; i++) {
      if (moviesList[i].name!.toUpperCase().contains(s.toUpperCase())) {
        searchListMovies.add(moviesList[i]);
      }
    }
    for (int i = 0; i < arabicMoviesList.length; i++) {
      if (arabicMoviesList[i].name!.toUpperCase().contains(s.toUpperCase())) {
        searchListMovies.add(arabicMoviesList[i]);
      }
    }
    /* for (int i = 0; i < mostWatchedMovies.length; i++) {
      if (mostWatchedMovies[i].name!.toUpperCase().contains(s.toUpperCase())) {
        searchListMovies.add(mostWatchedMovies[i]);
      }
    }*/
    emit(SearchState());
  }

  SearchFunctionSeries(String s) {
    for (int i = 0; i < englishSeriesList.length; i++) {
      if (englishSeriesList[i].name!.toUpperCase().contains(s.toUpperCase())) {
        searchListSeries.add(englishSeriesList[i]);
      }
    }
    for (int i = 0; i < arabicSeriesList.length; i++) {
      if (arabicSeriesList[i].name!.contains(s)) {
        searchListSeries.add(arabicSeriesList[i]);
      }
    }
    for (int i = 0; i < ramadan2022SeriesList.length; i++) {
      if (ramadan2022SeriesList[i].name!.contains(s)) {
        searchListSeries.add(ramadan2022SeriesList[i]);
      }
    }
    for (int i = 0; i < ramadan2023SeriesList.length; i++) {
      if (ramadan2023SeriesList[i].name!.contains(s)) {
        searchListSeries.add(ramadan2023SeriesList[i]);
      }
    }
    emit(SearchState());
  }

  int currentPage = 0, focusedIndex = 0;

  List<Widget> screens = [
    const Home(),
    Favorite(),
    const Movies(),
    const Series()
  ];

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

  getFavoriteMoviesFromDB() async {
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

  FavoriteMoviestoDB(MovieModel movie) async {
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

  getFavoriteSeriesFromDB() async {
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

  FavoriteSeriestoDB(SeriesModel series) async {
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

  static List<MovieModel> moviesList = [];
  static List<MovieModel> arabicMoviesList = [];
  // static List<MovieModel> mostWatchedMovies = [];
  static List<MovieModel> animationMovies = [];

  static getEnglishMovies() async {
    if (!Platform.isWindows) {
      FirebaseFirestore.instance
          .collection('movies')
          .doc('English Movies')
          .get()
          .then((value) {
        value.data()!.forEach((key, value) {
          moviesList.add(MovieModel.fromJson(value));
        });
      }).catchError((onError) {});
    } else {
      Firestore.instance
          .collection('movies')
          .document('English Movies')
          .get()
          .then((value) {
        value.map.forEach((key, value) {
          moviesList.add(MovieModel.fromJson(value));
        });
      }).catchError((onError) {});
    }
  }

  static getArabicMovies() async {
    if (!Platform.isWindows) {
      FirebaseFirestore.instance
          .collection('movies')
          .doc('Arabic Movies')
          .get()
          .then((value) {
        value.data()!.forEach((key, value) {
          arabicMoviesList.add(MovieModel.fromJson(value));
        });
      }).catchError((onError) {});
    } else {
      Firestore.instance
          .collection('movies')
          .document('Arabic Movies')
          .get()
          .then((value) {
        value.map.forEach((key, value) {
          arabicMoviesList.add(MovieModel.fromJson(value));
        });
      }).catchError((onError) {});
    }
  }

  static getMostWatchedMovies() async {
    if (!Platform.isWindows) {
      FirebaseFirestore.instance
          .collection('movies')
          .doc('Most Watched Movies')
          .get()
          .then((value) {
        value.data()!.forEach((key, value) {
          moviesList.add(MovieModel.fromJson(value));
        });
      }).catchError((onError) {});
    } else {
      Firestore.instance
          .collection('movies')
          .document('Most Watched Movies')
          .get()
          .then((value) {
        value.map.forEach((key, value) {
          moviesList.add(MovieModel.fromJson(value));
        });
      }).catchError((onError) {});
    }
  }

  static getAnimationMovies() async {
    if (!Platform.isWindows) {
      FirebaseFirestore.instance
          .collection('movies')
          .doc('Animation Movies')
          .get()
          .then((value) {
        value.data()!.forEach((key, value) {
          animationMovies.add(MovieModel.fromJson(value));
        });
      }).catchError((onError) {});
    } else {
      Firestore.instance
          .collection('movies')
          .document('Animation Movies')
          .get()
          .then((value) {
        value.map.forEach((key, value) {
          animationMovies.add(MovieModel.fromJson(value));
        });
      }).catchError((onError) {});
    }
  }

  Map<String, Map<String, dynamic>> moviesMap = {};
  uploadMoviesMap() async {
    FirebaseFirestore.instance
        .collection('movies')
        .doc('Animation Movies')
        .set(moviesMap)
        .then((value) {
      emit(UploadMoviesSuccessState());
    }).catchError((onError) {
      emit(UploadMoviesErrorState());
    });
  }

  static List<SeriesModel> englishSeriesList = [];
  static getEnglishSeries() async {
    if (!Platform.isWindows) {
      FirebaseFirestore.instance
          .collection('Series')
          .doc('English Series')
          .get()
          .then((value) {
        value.data()!.forEach((key, value) {
          englishSeriesList.add(SeriesModel.fromJson(value));
        });
      }).catchError((onError) {
        print(onError.toString());
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
      }).catchError((onError) {
        print(onError.toString());
      });
    }
  }

  static List<SeriesModel> arabicSeriesList = [];
  static getArabicSeries() async {
    if (!Platform.isWindows) {
      FirebaseFirestore.instance
          .collection('Series')
          .doc('Arabic Series')
          .get()
          .then((value) {
        value.data()!.forEach((key, value) {
          arabicSeriesList.add(SeriesModel.fromJson(value));
        });
      }).catchError((onError) {
        print(onError.toString());
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
      }).catchError((onError) {
        print(onError.toString());
      });
    }
  }

  static List<SeriesModel> ramadan2022SeriesList = [];
  static getRamadan2022Series() async {
    if (!Platform.isWindows) {
      FirebaseFirestore.instance
          .collection('Series')
          .doc('Ramadan 2022')
          .get()
          .then((value) {
        value.data()!.forEach((key, value) {
          ramadan2022SeriesList.add(SeriesModel.fromJson(value));
        });
      }).catchError((onError) {
        print(onError.toString());
      });
    } else {
      Firestore.instance
          .collection('Series')
          .document('Ramadan 2022')
          .get()
          .then((value) {
        value.map.forEach((key, value) {
          ramadan2022SeriesList.add(SeriesModel.fromJson(value));
        });
      }).catchError((onError) {
        print(onError.toString());
      });
    }
  }

  static List<SeriesModel> ramadan2023SeriesList = [];
  static getRamadan2023Series() async {
    if (!Platform.isWindows) {
      FirebaseFirestore.instance
          .collection('Series')
          .doc('Ramadan 2023')
          .get()
          .then((value) {
        value.data()!.forEach((key, value) {
          ramadan2023SeriesList.add(SeriesModel.fromJson(value));
        });
      }).catchError((onError) {
        print(onError.toString());
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
      }).catchError((onError) {
        print(onError.toString());
      });
    }
  }

  Map<String, Map<String, dynamic>> seriessMap = {};
  uploadSeriesMap() async {
    FirebaseFirestore.instance
        .collection('Series')
        .doc('Arabic Series')
        .set(seriessMap)
        .then((value) {
      emit(UploadMoviesSuccessState());
    }).catchError((onError) {
      emit(UploadMoviesErrorState());
    });
  }
}
