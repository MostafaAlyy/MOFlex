// ignore_for_file: sized_box_for_whitespace
import 'package:moshahda_app/View/Components/General/appBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:moshahda_app/View/Components/HomeScreens/Home.dart';
import 'package:moshahda_app/ViewModel/Cupits/HomeCupit/home_cubit.dart';
import '../Components/General/defultSearchBar.dart';
import '../Components/homeScreenCompo/bottomNavBar.dart';
import '../Components/homeScreenCompo/homeBanner.dart';

class UploadScr extends StatelessWidget {
  const UploadScr({super.key});

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
              body: Center(
                child: ElevatedButton(
                  child: const Text(
                    'Upload',
                    style: TextStyle(color: Colors.deepOrange, fontSize: 30),
                  ),
                  onPressed: () {
                    cupit.getEnglishMovies();
                    //cupit.addToMovieList();
                  },
                ),
              ));
        },
      ),
    );
  }
}
