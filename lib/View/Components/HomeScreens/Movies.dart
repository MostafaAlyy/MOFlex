import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moshahda_app/View/Components/General/MovieCard.dart';

import '../../../ViewModel/Cupits/HomeCupit/home_cubit.dart';

class Movies extends StatelessWidget {
  const Movies({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cupit = HomeCubit.get(context);
    return Container(
      width: double.infinity,
      height: (cupit.moviesList.length * 100) + 100,
      decoration: BoxDecoration(
        // color: Colors.grey,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Text("Movies",
              style: GoogleFonts.bitter(color: Colors.white, fontSize: 48)),
          Expanded(
            child: DynamicHeightGridView(
                physics: NeverScrollableScrollPhysics(),
                itemCount: cupit.moviesList.length,
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
    );
  }
}
