import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moshahda_app/View/Components/HomeScreens/Home.dart';
import 'package:moshahda_app/View/Components/HomeScreens/Movies.dart';
import 'package:moshahda_app/View/Components/HomeScreens/Series.dart';
import 'package:moshahda_app/View/Components/HomeScreens/favorite.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(BuildContext context) => BlocProvider.of(context);
  TextEditingController searchController = TextEditingController();

  int currentPage = 0;

  List<Widget> screens = [Home(), Favorite(), Movies(), Series()];

  void changePage(int index) {
    currentPage = index;
    emit(ChangePageSuccessState());
  }
}
