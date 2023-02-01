// ignore_for_file: sized_box_for_whitespace
import 'package:moshahda_app/View/Components/General/appBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:moshahda_app/View/Components/HomeScreens/Home.dart';
import 'package:moshahda_app/ViewModel/Cupits/HomeCupit/home_cubit.dart';
import '../Components/General/defultSearchBar.dart';
import '../Components/homeScreenCompo/bottomNavBar.dart';
import '../Components/homeScreenCompo/homeBanner.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cupit = HomeCubit.get(context);
          return Scaffold(
              backgroundColor: const Color.fromARGB(1000, 11, 10, 28),
              body: SingleChildScrollView(
                // physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    if (cupit.screens[cupit.currentPage] is Home)
                      homeBanner(cupit),
                    const SizedBox(
                      height: 10,
                    ),
                    if (cupit.screens[cupit.currentPage] is Home)
                      defaultSearchBar(cupit),
                    if (cupit.screens[cupit.currentPage] is! Home)
                      mAppBar(cupit),
                    cupit.screens[cupit.currentPage],
                  ],
                ),
              ),
              bottomNavigationBar: homeBottomeNavBar(cupit));
        },
      ),
    );
  }

  animatedSlider(HomeCubit cupit) {}
}
