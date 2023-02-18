// ignore_for_file: sized_box_for_whitespace
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moshahda_app/ViewModel/Cupits/HomeCupit/home_cubit.dart';
import '../Components/homeScreenCompo/bottomNavBar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..refresh(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cupit = HomeCubit.get(context);

          return Scaffold(
              backgroundColor: const Color.fromARGB(1000, 11, 10, 28),
              body: ConditionalBuilder(
                  condition: HomeCubit.moviesList.isNotEmpty,
                  builder: (context) => cupit.screens[cupit.currentPage],
                  fallback: (context) => const Center(
                        child: CircularProgressIndicator(
                          color: Colors.deepOrange,
                        ),
                      )),
              bottomNavigationBar: homeBottomeNavBar(cupit));
        },
      ),
    );
  }
}
