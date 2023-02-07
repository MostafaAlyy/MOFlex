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

  getEnglishMovies() async {
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
    "مشاهدة فيلم Blueback 2022 مدبلج": {
      "name": "مشاهدة فيلم Blueback 2022 مدبلج",
      "link": "https://myviid.com/embed-1q2l0uwxmwek.html",
      "description":
          "في إطار درامي، يتبع العمل قصة آبي، والتي تنشأ بينها وبين سمكة زرقاء صداقة قوية، ولكن حينما تكتشف آبي أن صديقتها معرضة للخطر، تخوض مغامرة كبيرة لحمايتها.",
      "img": "https://cimaaa4u.skin/wp-content/uploads/0-10921.jpg",
      "dateTime": "2022",
    },
    "مشاهدة فيلم The Locksmith 2023 مترجم": {
      "name": "مشاهدة فيلم The Locksmith 2023 مترجم",
      "link": "https://myviid.com/embed-lgak03growpv.html",
      "description":
          "لص خرج حديثاً من السجن، يحاول العودة إلى حياة ابنته وخطيبته السابقة. عاقدة العزم ، إنه مجبر على استخدام المهارات التي يمتلكها كصانع أقفال موهوب. تأخذ الأمور منعطفًا صاخبًا بعد اختفاء غير متوقع.",
      "img": "https://cimaaa4u.skin/wp-content/uploads/075-3906.jpg",
      "dateTime": "2023",
    },
    "مشاهدة فيلم Little Dixie 2023 مترجم": {
      "name": "مشاهدة فيلم Little Dixie 2023 مترجم",
      "link": "https://myviid.com/embed-5awos3rwk1x2.html",
      "description":
          "يسهل دوك هدنة هشة بين الحاكم والأحتكار ويقايض التساهل من النيابة مقابل التمويل مع عدم وجود المزيد من الهدنة يترك دوك ليدافع عن نفسه ويحمي الشيء الوحيد غير الملوث في حياته ابنته ليتل ديكسي.",
      "img": "https://cimaaa4u.skin/wp-content/uploads/075-3904.jpg",
      "dateTime": "2023",
    },
    "مشاهدة فيلم Baby Ruby 2022 مترجم": {
      "name": "مشاهدة فيلم Baby Ruby 2022 مترجم",
      "link": "https://myviid.com/embed-a5o9ophydvpm.html",
      "description":
          "“جو” والدة فرنسية الأصل تحظى بطفلة تدعى “روبي” وتبدأ بعدها معاناة الأم مع الطفلة من الصراخ والبكاء المستمر، الأمر الذي يدفع بها للجنون.",
      "img": "https://cimaaa4u.skin/wp-content/uploads/075-3903.jpg",
      "dateTime": "2022",
    },
    "مشاهدة فيلم Plane 2023 مدبلج": {
      "name": "مشاهدة فيلم Plane 2023 مدبلج",
      "link": "https://myviid.com/embed-p0igu65uv6f6.html",
      "description":
          "في إطار من الحركة والتشويق، تدور أحداث العمل حول طيار يجد نفسه محاصرًا وسط حربًا مميتة حينما تجبره الظروف على الهبوط بطائرة تجارية خلال عاصفة شديدة.",
      "img": "https://cimaaa4u.skin/wp-content/uploads/0-10920.jpg",
      "dateTime": "2023",
    },
    "مشاهدة فيلم Streetwalker 2022 مترجم": {
      "name": "مشاهدة فيلم Streetwalker 2022 مترجم",
      "link": "https://myviid.com/embed-qq234rtkyvx6.html",
      "description":
          "تنجو امرأة من ليلة صادمة لتجد نفسها في واقع مرعب عندما تنجذب عن غير قصد إلى خطط كائنات متعددة الأبعاد.",
      "img": "https://cimaaa4u.skin/wp-content/uploads/000-315.jpg",
      "dateTime": "2022",
    },
    "مشاهدة فيلم In the Heart of the Machine 2022 مترجم": {
      "name": "مشاهدة فيلم In the Heart of the Machine 2022 مترجم",
      "link": "https://myviid.com/embed-5e4fu27xg6sg.html",
      "description":
          "يجدون شيئًا غير عادي داخل إحدى الآلات ، وموجة غير متوقعة من التعاطف تجعل السجناء يأخذون رهائن ويغلقون مدخل الورشة ويخاطرون بحياتهم ، لأن الرغبة في أن تكون إنسانًا في بعض الأحيان تكون أقوى من غريزة البقاء.",
      "img": "https://cimaaa4u.skin/wp-content/uploads/0-10942.jpg",
      "dateTime": "2022",
    },
    "مشاهدة فيلم Blood 2022 مترجم": {
      "name": "مشاهدة فيلم Blood 2022 مترجم",
      "link": "https://myviid.com/embed-3mruepra8yqo.html",
      "description":
          "في إطار من الرعب والتشويق، تنقل الممرضة جيس رفقة ابنتها وابنها الصغر إلى منزلها القديم، وبعد فترة وجيزة يتعرض ابنها أوين إلى عضة من كلب تُسفر عن أشياء غامضة.",
      "img": "https://cimaaa4u.skin/wp-content/uploads/000-316.jpg",
      "dateTime": "2022",
    },
    "مشاهدة فيلم Kompromat 2022 مترجم": {
      "name": "مشاهدة فيلم Kompromat 2022 مترجم",
      "link": "https://myviid.com/embed-icvfln256teq.html",
      "description":
          "في إطار من الدراما والتشويق، تدور الأحداث حول دبلوماسي فرنسي يجد نفسه مطاردًا من قبل جهاز الأمن الفيدرالي في سيبيريا.",
      "img": "https://cimaaa4u.skin/wp-content/uploads/0-10943.jpg",
      "dateTime": "2022",
    },
    "مشاهدة فيلم Taurus 2022 مترجم": {
      "name": "مشاهدة فيلم Taurus 2022 مترجم",
      "link": "https://myviid.com/embed-rfsn18ui5h7x.html",
      "description":
          "في إطار من الدراما والموسيقى، بينما يسعى مغني واعد ومستهتر للعثور على الإلهام لأغنيته الجديدة، يجد نفسه سريعًا يسير إلى الهاوية نحو الإدمان ومساوء الشهرة.",
      "img": "https://cimaaa4u.skin/wp-content/uploads/0-10944.jpg",
      "dateTime": "2022",
    },
    "مشاهدة فيلم Skinamarink 2022 مترجم": {
      "name": "مشاهدة فيلم Skinamarink 2022 مترجم",
      "link": "https://myviid.com/embed-mag7s3htxp9h.html",
      "description": "",
      "img": "https://cimaaa4u.skin/wp-content/uploads/075-3896.jpg",
      "dateTime": "2022",
    },
    "مشاهدة فيلم R.M.N. 2022 مترجم": {
      "name": "مشاهدة فيلم R.M.N. 2022 مترجم",
      "link": "https://myviid.com/embed-ij7nfy9uc73s.html",
      "description": "",
      "img": "https://cimaaa4u.skin/wp-content/uploads/075-3895.jpg",
      "dateTime": "2022",
    },
    "مشاهدة فيلم Viking Wolf 2023 مترجم": {
      "name": "مشاهدة فيلم Viking Wolf 2023 مترجم",
      "link": "https://myviid.com/embed-7q9qpfti2oqt.html",
      "description":
          "بعدما تشهد مراهقة جريمة قتل مُفزعة أثناء حفل في البلدة التي انتقلت إليها حديثًا، تراودها رؤًى عجيبة وتنتابها رغبات غريبة.",
      "img": "https://cimaaa4u.skin/wp-content/uploads/075-3893.jpg",
      "dateTime": "2022",
    },
    "مشاهدة فيلم True Spirit 2023 مترجم": {
      "name": "مشاهدة فيلم True Spirit 2023 مترجم",
      "link": "https://myviid.com/embed-cut1syijeg2k.html",
      "description":
          "تحقق مراهقة أسترالية عنيدة أحلامها... وتواجه مخاوفها... عندما تنطلق لتصبح أصغر شخص يُبحر وحده حول العالم.",
      "img": "https://cimaaa4u.skin/wp-content/uploads/075-3892.jpg",
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
