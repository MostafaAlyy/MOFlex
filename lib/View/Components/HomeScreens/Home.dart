import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                homeBanner(cupit),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Most Watched Movies",
                            style: GoogleFonts.roboto(
                                color: Colors.white, fontSize: 20),
                          ),
                          const Spacer(),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    Transitiont(
                                        child: ShowAll(
                                            HomeCubit.mostWatchedMovies,
                                            "Most Watched",
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
                        height: 10,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 5.2,
                        child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: ((context, index) => movieCard(
                                context: context,
                                imgLink:
                                    HomeCubit.mostWatchedMovies[index].img!,
                                model: HomeCubit.mostWatchedMovies[index])),
                            separatorBuilder: ((context, index) =>
                                const SizedBox(
                                  width: 10,
                                )),
                            itemCount:
                                (HomeCubit.mostWatchedMovies.length >= 10)
                                    ? 10
                                    : HomeCubit.mostWatchedMovies.length),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
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
                                    Transitiont(
                                        child: ShowAll(HomeCubit.moviesList,
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
                        height: MediaQuery.of(context).size.height / 5.2,
                        child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: ((context, index) => movieCard(
                                context: context,
                                imgLink: HomeCubit.moviesList[index].img!,
                                model: HomeCubit.moviesList[index])),
                            separatorBuilder: ((context, index) =>
                                const SizedBox(
                                  width: 10,
                                )),
                            itemCount: (HomeCubit.moviesList.length >= 10)
                                ? 10
                                : HomeCubit.moviesList.length),
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
                                    Transitiont(
                                        child: ShowAll(
                                            HomeCubit.arabicMoviesList,
                                            "Arabic Movies",
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
                        height: MediaQuery.of(context).size.height / 5.2,
                        child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: ((context, index) => movieCard(
                                context: context,
                                imgLink: HomeCubit.arabicMoviesList[index].img!,
                                model: HomeCubit.arabicMoviesList[index])),
                            separatorBuilder: ((context, index) =>
                                const SizedBox(
                                  width: 10,
                                )),
                            itemCount: (HomeCubit.arabicMoviesList.length >= 10)
                                ? 10
                                : HomeCubit.arabicMoviesList.length),
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
                                    Transitiont(
                                        child: ShowAllSeries(
                                            HomeCubit.englishSeriesList,
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
                        height: MediaQuery.of(context).size.height / 5.2,
                        child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: ((context, index) => seriesCard(
                                context: context,
                                imgLink:
                                    HomeCubit.englishSeriesList[index].img!,
                                model: HomeCubit.englishSeriesList[index])),
                            separatorBuilder: ((context, index) =>
                                const SizedBox(
                                  width: 10,
                                )),
                            itemCount:
                                (HomeCubit.englishSeriesList.length >= 10)
                                    ? 10
                                    : HomeCubit.englishSeriesList.length),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text(
                            "Arabic Series",
                            style: GoogleFonts.roboto(
                                color: Colors.white, fontSize: 20),
                          ),
                          const Spacer(),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    Transitiont(
                                        child: ShowAllSeries(
                                            HomeCubit.arabicSeriesList,
                                            "Arabic Series",
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
                                imgLink: HomeCubit.arabicSeriesList[index].img!,
                                model: HomeCubit.arabicSeriesList[index])),
                            separatorBuilder: ((context, index) =>
                                const SizedBox(
                                  width: 10,
                                )),
                            itemCount: (HomeCubit.arabicSeriesList.length >= 10)
                                ? 10
                                : HomeCubit.arabicSeriesList.length),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text(
                            "Ramadan 2022",
                            style: GoogleFonts.roboto(
                                color: Colors.white, fontSize: 20),
                          ),
                          const Spacer(),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    Transitiont(
                                        child: ShowAllSeries(
                                            HomeCubit.ramadan2022SeriesList,
                                            "Ramadan 2022",
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
                        height: MediaQuery.of(context).size.height / 5.2,
                        child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: ((context, index) => seriesCard(
                                context: context,
                                imgLink:
                                    HomeCubit.ramadan2022SeriesList[index].img!,
                                model: HomeCubit.ramadan2022SeriesList[index])),
                            separatorBuilder: ((context, index) =>
                                const SizedBox(
                                  width: 10,
                                )),
                            itemCount:
                                (HomeCubit.ramadan2022SeriesList.length >= 10)
                                    ? 10
                                    : HomeCubit.ramadan2022SeriesList.length),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text(
                            "Ramadan 2023",
                            style: GoogleFonts.roboto(
                                color: Colors.white, fontSize: 20),
                          ),
                          const Spacer(),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    Transitiont(
                                        child: ShowAllSeries(
                                            HomeCubit.ramadan2023SeriesList,
                                            "Ramadan 2023",
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
                        height: MediaQuery.of(context).size.height / 5.2,
                        child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: ((context, index) => seriesCard(
                                context: context,
                                imgLink:
                                    HomeCubit.ramadan2023SeriesList[index].img!,
                                model: HomeCubit.ramadan2023SeriesList[index])),
                            separatorBuilder: ((context, index) =>
                                const SizedBox(
                                  width: 10,
                                )),
                            itemCount:
                                (HomeCubit.ramadan2023SeriesList.length >= 10)
                                    ? 10
                                    : HomeCubit.ramadan2023SeriesList.length),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ]),
        );
      },
    );
  }
}
