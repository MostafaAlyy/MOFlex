import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moshahda_app/View/Components/General/MovieCard.dart';
import 'package:moshahda_app/View/Components/General/SeriesCard.dart';
import 'package:moshahda_app/View/Components/HomeScreens/ShowAllScr.dart';
import 'package:moshahda_app/ViewModel/Cupits/HomeCupit/home_cubit.dart';
import 'package:transition/transition.dart';

import '../General/defultSearchBar.dart';
import '../homeScreenCompo/homeBanner.dart';
import 'ShowAllSeriesScr.dart';

class Home extends StatelessWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cupit = HomeCubit.get(context);
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              homeBanner(cupit),
              const SizedBox(
                height: 10,
              ),
              defaultSearchBar(cupit),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "English Movies",
                          style: GoogleFonts.roboto(
                              color: Colors.white, fontSize: 20),
                        ),
                        const Spacer(),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  Transition(
                                      child: ShowAll(cupit.moviesList,
                                          "English Movies", cupit),
                                      transitionEffect:
                                          TransitionEffect.SCALE));
                            },
                            child: const Text(
                              "Show All ",
                              style: TextStyle(fontSize: 16),
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 160,
                      child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: ((context, index) => movieCard(
                              context: context,
                              imgLink: cupit.moviesList[index].img!,
                              model: cupit.moviesList[index])),
                          separatorBuilder: ((context, index) => const SizedBox(
                                width: 10,
                              )),
                          itemCount: (cupit.moviesList.length >= 10)
                              ? 10
                              : cupit.moviesList.length),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          "Arabic Movies",
                          style: GoogleFonts.roboto(
                              color: Colors.white, fontSize: 20),
                        ),
                        const Spacer(),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  Transition(
                                      child: ShowAll(cupit.arabicMoviesList,
                                          "Arabic Movies", cupit),
                                      transitionEffect:
                                          TransitionEffect.SCALE));
                            },
                            child: const Text(
                              "Show All ",
                              style: TextStyle(fontSize: 16),
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 160,
                      child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: ((context, index) => movieCard(
                              context: context,
                              imgLink: cupit.arabicMoviesList[index].img!,
                              model: cupit.arabicMoviesList[index])),
                          separatorBuilder: ((context, index) => const SizedBox(
                                width: 10,
                              )),
                          itemCount: (cupit.arabicMoviesList.length >= 10)
                              ? 10
                              : cupit.arabicMoviesList.length),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          "English Series",
                          style: GoogleFonts.roboto(
                              color: Colors.white, fontSize: 20),
                        ),
                        const Spacer(),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  Transition(
                                      child: ShowAllSeries(
                                          cupit.englishSeriesList,
                                          "English Series",
                                          cupit),
                                      transitionEffect:
                                          TransitionEffect.SCALE));
                            },
                            child: const Text(
                              "Show All ",
                              style: TextStyle(fontSize: 16),
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 160,
                      child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: ((context, index) => seriesCard(
                              context: context,
                              imgLink: cupit.englishSeriesList[index].img!,
                              model: cupit.englishSeriesList[index])),
                          separatorBuilder: ((context, index) => const SizedBox(
                                width: 10,
                              )),
                          itemCount: (cupit.englishSeriesList.length >= 10)
                              ? 10
                              : cupit.englishSeriesList.length),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}
