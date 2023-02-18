import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:moshahda_app/View/Components/General/MovieCard.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moshahda_app/View/Components/General/SeriesCard.dart';

import '../../../ViewModel/Cupits/HomeCupit/home_cubit.dart';
import '../../../ViewModel/admobAdsManger.dart';
import '../General/appBar.dart';

class Favorite extends StatefulWidget {
  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  BannerAd? banner;

  void createBannerAd() {
    banner = BannerAd(
        size: AdSize.fullBanner,
        adUnitId: AdsManger.bannerAdUnit,
        listener: AdsManger.bannerAdListener,
        request: const AdRequest())
      ..load();
  }

  @override
  void initState() {
    // TODO: implement initState
    createBannerAd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool moviesSelected = true;
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cupit = HomeCubit.get(context);

        cupit.getFavoriteMoviesFromDB();
        cupit.getFavoriteSeriesFromDB();

        return SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            height: (((HomeCubit.favoriteMovies.length / 3) + 4) *
                (MediaQuery.of(context).size.height / 5.2)),
            child: Column(
              children: [
                mAppBar(cupit, context),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 10,
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 12,
                            width: MediaQuery.of(context).size.width / 2.6,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  backgroundColor: (moviesSelected)
                                      ? const Color.fromARGB(255, 3, 41, 72)
                                      : Colors.grey.withOpacity(0.3),
                                ),
                                onPressed: () {
                                  moviesSelected = !moviesSelected;
                                },
                                child: const Text(
                                  "Movies",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ))),
                        const SizedBox(
                          width: 30,
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 12,
                            width: MediaQuery.of(context).size.width / 2.6,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: (!moviesSelected)
                                      ? const Color.fromARGB(255, 3, 41, 72)
                                      : Colors.grey.withOpacity(0.3),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                ),
                                onPressed: () {
                                  moviesSelected = !moviesSelected;
                                },
                                child: const Text(
                                  "Series",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                )))
                      ],
                    ),
                  ),
                ),
                if (moviesSelected)
                  Text("Your Favorite Movies",
                      style: GoogleFonts.bitter(
                          color: Colors.white, fontSize: 36)),
                if (banner != null)
                  SizedBox(
                      height: MediaQuery.of(context).size.height / 10,
                      width: MediaQuery.of(context).size.width,
                      child: AdWidget(ad: banner!)),
                if (moviesSelected)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DynamicHeightGridView(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: HomeCubit.favoriteMovies.length,
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          builder: (ctx, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: Column(
                                children: [
                                  movieCard(
                                      context: context,
                                      imgLink: HomeCubit
                                          .favoriteMovies[HomeCubit
                                              .favoriteMoviesNames[index]]!
                                          .img!,
                                      model: HomeCubit.favoriteMovies[HomeCubit
                                          .favoriteMoviesNames[index]]!),
                                  Text(
                                    HomeCubit
                                        .favoriteMovies[HomeCubit
                                            .favoriteMoviesNames[index]]!
                                        .name!,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.exo2(
                                        color: Colors.white, fontSize: 16),
                                  )
                                ],
                              ),
                            );
                          }),
                    ),
                  ),
                if (!moviesSelected)
                  Text("Your Favorite Series",
                      style: GoogleFonts.bitter(
                          color: Colors.white, fontSize: 36)),
                if (!moviesSelected)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DynamicHeightGridView(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: HomeCubit.favoriteSeries.length,
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          builder: (ctx, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: Column(
                                children: [
                                  seriesCard(
                                      context: context,
                                      imgLink: HomeCubit
                                          .favoriteSeries[HomeCubit
                                              .favoriteSeriesNames[index]]!
                                          .img!,
                                      model: HomeCubit.englishSeriesList
                                          .firstWhere(
                                        (element) {
                                          return element.name ==
                                              HomeCubit
                                                  .favoriteSeriesNames[index];
                                        },
                                        orElse: () {
                                          return HomeCubit.arabicSeriesList
                                              .firstWhere(
                                            (element) {
                                              return element.name ==
                                                  HomeCubit.favoriteSeriesNames[
                                                      index];
                                            },
                                            orElse: () {
                                              return HomeCubit
                                                  .ramadan2022SeriesList
                                                  .firstWhere((element) {
                                                return element.name ==
                                                    HomeCubit
                                                            .favoriteSeriesNames[
                                                        index];
                                              }, orElse: () {
                                                return HomeCubit
                                                    .ramadan2023SeriesList
                                                    .firstWhere((element) {
                                                  return element.name ==
                                                      HomeCubit
                                                              .favoriteSeriesNames[
                                                          index];
                                                });
                                              });
                                            },
                                          );
                                        },
                                      )),
                                  Text(
                                    HomeCubit
                                        .favoriteSeries[HomeCubit
                                            .favoriteSeriesNames[index]]!
                                        .name!,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.exo2(
                                        color: Colors.white, fontSize: 16),
                                  )
                                ],
                              ),
                            );
                          }),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
