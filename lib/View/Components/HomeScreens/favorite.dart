import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moshahda_app/View/Components/General/MovieCard.dart';

import '../../../ViewModel/Cupits/HomeCupit/home_cubit.dart';
import '../General/appBar.dart';

class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    var cupit = HomeCubit.get(context);
    cupit.favoriteScrollController.addListener(
      () {
        if (cupit.favoriteScrollController.position.pixels ==
            cupit.favoriteScrollController.position.maxScrollExtent) {
          setState(() {
            if (cupit.favoriteLoadedCards + 10 <= cupit.moviesList.length) {
              cupit.favoriteLoadedCards += 10;
              print("favoriteLoadedCards=${cupit.favoriteLoadedCards}");
            } else {
              cupit.favoriteLoadedCards = cupit.moviesList.length;
            }
          });
        }
      },
    );

    return SingleChildScrollView(
      controller: cupit.favoriteScrollController,
      child: Container(
        width: double.infinity,
        height: ((cupit.favoriteLoadedCards / 3) * 220) + 300,
        decoration: BoxDecoration(
          //  color: Colors.grey,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          children: [
            mAppBar(cupit),
            Text("Your Favorites",
                style: GoogleFonts.bitter(color: Colors.white, fontSize: 48)),
            Expanded(
              child: DynamicHeightGridView(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: cupit.favoriteLoadedCards,
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  builder: (ctx, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Column(
                        children: [
                          movieCard(
                              context: context,
                              imgLink: cupit.moviesList[index].img!,
                              model: cupit.moviesList[index]),
                          Text(
                            cupit.moviesList[index].name!,
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
          ],
        ),
      ),
    );
  }
}
