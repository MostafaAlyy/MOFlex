import 'package:flutter/material.dart';

import 'package:moshahda_app/View/Components/General/defultSearchBar.dart';
import 'package:moshahda_app/View/Components/General/movieSearchCard.dart';
import 'package:moshahda_app/View/Components/General/seriesSearchCard.dart';

import '../../../ViewModel/Cupits/HomeCupit/home_cubit.dart';

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
                margin: const EdgeInsets.symmetric(horizontal: 16),
                height: MediaQuery.of(context).size.height / 1.2,
                width: MediaQuery.of(context).size.width / 1.1,
                clipBehavior: Clip.hardEdge,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: Scaffold(
                    backgroundColor: const Color.fromARGB(255, 11, 10, 28),
                    body: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SingleChildScrollView(
                        child: SizedBox(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 15,
                                ),
                                defaultSearchBar(
                                  cupit: cupit,
                                  onchange: (String? p0) {
                                    setState(() {
                                      if (moviesSelected) {
                                        HomeCubit.searchListMovies.clear();
                                        cupit.SearchFunctionMovies(p0!);
                                      } else {
                                        HomeCubit.searchListSeries.clear();
                                        cupit.SearchFunctionSeries(p0!);
                                      }
                                    });
                                  },
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                22,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
                                              backgroundColor: (moviesSelected)
                                                  ? const Color.fromARGB(
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
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                12),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                22,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: (!moviesSelected)
                                                  ? const Color.fromARGB(
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
                                  height: 10,
                                ),
                                if (moviesSelected)
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        1.25,
                                    width:
                                        MediaQuery.of(context).size.width / 1.1,
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
                                    height: MediaQuery.of(context).size.height /
                                        1.25,
                                    width:
                                        MediaQuery.of(context).size.width / 1.1,
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
