import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:moshahda_app/View/Components/General/movieSearchCard.dart';
import 'package:moshahda_app/View/Components/General/seriesSearchCard.dart';
import 'package:transition/transition.dart';

import '../../../ViewModel/Cupits/HomeCupit/home_cubit.dart';
import '../../Pages/MovieDetailedScr.dart';

Future searchDialog({required BuildContext context, required var cupit}) {
  return showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Sign In",
    pageBuilder: (context, animation, secondaryAnimation) {
      bool moviesSelected = true;
      return StatefulBuilder(
        builder: (context, setState) => Center(
            child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                height: 700,
                width: 400,
                clipBehavior: Clip.hardEdge,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: Scaffold(
                    backgroundColor: Color.fromARGB(255, 11, 10, 28),
                    body: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SingleChildScrollView(
                        child: SizedBox(
                            height: 670,
                            width: 400,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 35,
                                    ),
                                    AnimSearchBar(
                                      width: 300,
                                      textController: cupit.searchController,
                                      onSuffixTap: () {
                                        setState(() {
                                          HomeCubit.searchListMovies.clear();
                                          HomeCubit.searchListSeries.clear();
                                          cupit.searchController.clear();
                                        });
                                      },
                                      onSubmitted: (p0) {
                                        setState(() {
                                          if (moviesSelected) {
                                            HomeCubit.searchListMovies.clear();
                                            cupit.SearchFunctionMovies(p0);
                                            print(HomeCubit
                                                .searchListMovies.length);
                                          } else {
                                            HomeCubit.searchListSeries.clear();
                                            cupit.SearchFunctionSeries(p0);
                                            print(HomeCubit
                                                .searchListSeries.length);
                                          }
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    SizedBox(
                                        height: 40,
                                        width: 120,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
                                              backgroundColor: (moviesSelected)
                                                  ? Color.fromARGB(
                                                      255, 3, 41, 72)
                                                  : Colors.grey
                                                      .withOpacity(0.3),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                moviesSelected =
                                                    !moviesSelected;
                                              });
                                            },
                                            child: const Text(
                                              "Movies",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ))),
                                    const SizedBox(
                                      width: 40,
                                    ),
                                    SizedBox(
                                        height: 40,
                                        width: 120,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: (!moviesSelected)
                                                  ? Color.fromARGB(
                                                      255, 3, 41, 72)
                                                  : Colors.grey
                                                      .withOpacity(0.3),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                moviesSelected =
                                                    !moviesSelected;
                                              });
                                            },
                                            child: const Text(
                                              "Series",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            )))
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                if (moviesSelected)
                                  SizedBox(
                                    height: 500,
                                    width: 400,
                                    child: ListView.separated(
                                        itemBuilder: (context, index) {
                                          return movieSearchCard(
                                              context: context,
                                              cupit: cupit,
                                              index: index);
                                        },
                                        separatorBuilder: (context, index) {
                                          return const SizedBox(
                                            height: 15,
                                          );
                                        },
                                        itemCount:
                                            HomeCubit.searchListMovies.length),
                                  )
                                else
                                  SizedBox(
                                    height: 500,
                                    width: 400,
                                    child: ListView.separated(
                                        itemBuilder: (context, index) {
                                          return seriesSearchCard(
                                              context: context,
                                              cupit: cupit,
                                              index: index);
                                        },
                                        separatorBuilder: (context, index) {
                                          return const SizedBox(
                                            height: 15,
                                          );
                                        },
                                        itemCount:
                                            HomeCubit.searchListSeries.length),
                                  )
                              ],
                            )),
                      ),
                    )))),
      );
    },
  );
}
