import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moshahda_app/View/Components/General/MovieCard.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moshahda_app/View/Components/General/SeriesCard.dart';

import '../../../ViewModel/Cupits/HomeCupit/home_cubit.dart';
import '../General/appBar.dart';

class Favorite extends StatelessWidget {
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
          child: Container(
            width: double.infinity,
            height: ((HomeCubit.favoriteMovies.length / 3) * 230) +
                800 +
                ((HomeCubit.favoriteSeries.length / 3) * 230),
            decoration: BoxDecoration(
              //  color: Colors.grey,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              children: [
                mAppBar(cupit),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 100,
                    width: double.infinity,
                    child: Row(
                      children: [
                        SizedBox(
                            height: 170,
                            width: 170,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  backgroundColor: (moviesSelected)
                                      ? Color.fromARGB(255, 3, 41, 72)
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
                            height: 170,
                            width: 170,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: (!moviesSelected)
                                      ? Color.fromARGB(255, 3, 41, 72)
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
                if (moviesSelected)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DynamicHeightGridView(
                          physics: NeverScrollableScrollPhysics(),
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
                          physics: NeverScrollableScrollPhysics(),
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
                                      model: cupit.englishSeriesList
                                          .firstWhere((element) {
                                        return element.name ==
                                            HomeCubit
                                                .favoriteSeriesNames[index];
                                      })),
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
