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
    focusedIndex = index % 10;
    emit(ChangeOnFocusInHomeSliderSuccessState());
  }

  List<MovieModel> moviesList = [];

  getEnglishMovies() {
    emit(GetMoviesLoadingState());
    FirebaseFirestore.instance
        .collection('movies')
        .doc('English Movies')
        .get()
        .then((value) {
      value.data()!.forEach((key, value) {
        moviesList.add(MovieModel.fromJson(value));
        print(value.toString() + "\n");
      });
      emit(GetMoviesSuccessState());
    }).catchError((onError) {
      emit(GetMoviesErrorState());
    });
  }

  Map<String, Map<String, dynamic>> moviesMap = {
    "sss": {
      "name": "مشاهدة فيلم To Russia with Love 2022 مترجم",
      "link":
          "https://snv202.myviid.com/sn3kpxizg46nuyc5wlfodtibq2jhopb4hnmpgjzc6rherojsawv3qvzg7csa/v.mp4",
      "description": "",
      "img": "https://cimaaa4u.yachts/wp-content/uploads/075-3623.jpg",
      "dateTime": "2022",
    },
    "ssddds": {
      "name": "مشاهدة فيلم To Russia with Love 2022 مترجم",
      "link":
          "https://snv202.myviid.com/sn3kpxizg46nuyc5wlfodtibq2jhopb4hnmpgjzc6rherojsawv3qvzg7csa/v.mp4",
      "description": "",
      "img": "https://cimaaa4u.yachts/wp-content/uploads/075-3623.jpg",
      "dateTime": "2022",
    },
    "ssjjjs": {
      "name": "مشاهدة فيلم To Russia with Love 2022 مترجم",
      "link":
          "https://snv202.myviid.com/sn3kpxizg46nuyc5wlfodtibq2jhopb4hnmpgjzc6rherojsawv3qvzg7csa/v.mp4",
      "description": "",
      "img": "https://cimaaa4u.yachts/wp-content/uploads/075-3623.jpg",
      "dateTime": "2022",
    },
    "مشاهدة فيلم The Locksmith 2023 مترجم": {
      "name": "مشاهدة فيلم The Locksmith 2023 مترجم",
      "link":
          "https://mst98.myviid.com/sn3kopjvg46nuyc5wlkodgaw2zanmhyq4sd3s6ba6exoofi45uwcw2h7y52a/v.mp4",
      "description":
          "لص خرج حديثاً من السجن، يحاول العودة إلى حياة ابنته وخطيبته السابقة. عاقدة العزم ، إنه مجبر على استخدام المهارات التي يمتلكها كصانع أقفال موهوب. تأخذ الأمور منعطفًا صاخبًا بعد اختفاء غير متوقع.",
      "img": "https://cimaaa4u.skin/wp-content/uploads/075-3906.jpg",
      "dateTime": "2023",
    },
    "مشاهدة فيلم Little Dixie 2023 مترجم": {
      "name": "مشاهدة فيلم Little Dixie 2023 مترجم",
      "link":
          "https://snv209.myviid.com/sn3koorvg46nuyc5wlkodqiqyci56ggp3ubtmounmkizyeygc3axhahdh3ta/v.mp4",
      "description":
          "يسهل دوك هدنة هشة بين الحاكم والأحتكار ويقايض التساهل من النيابة مقابل التمويل مع عدم وجود المزيد من الهدنة يترك دوك ليدافع عن نفسه ويحمي الشيء الوحيد غير الملوث في حياته ابنته ليتل ديكسي.",
      "img": "https://cimaaa4u.skin/wp-content/uploads/075-3904.jpg",
      "dateTime": "2023",
    },
  };
  uploadMoviesMap() {
    FirebaseFirestore.instance
        .collection('movies')
        .doc('English Movies')
        .set(moviesMap)
        .then((value) async {
      emit(UploadMoviesSuccessState());
    }).catchError((onError) {
      emit(UploadMoviesErrorState());
    });
  }
}
