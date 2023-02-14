import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moshahda_app/View/Components/General/MovieCard.dart';

import '../../../ViewModel/Cupits/HomeCupit/home_cubit.dart';
import '../General/SeriesCard.dart';
import '../General/appBar.dart';

class Series extends StatefulWidget {
  const Series({Key? key}) : super(key: key);

  @override
  State<Series> createState() => _SeriesState();
}

class _SeriesState extends State<Series> {
  @override
  Widget build(BuildContext context) {
    var cupit = HomeCubit.get(context);

    cupit.seriesScrollController.addListener(
      () {
        if (cupit.seriesScrollController.position.pixels ==
            cupit.seriesScrollController.position.maxScrollExtent) {
          setState(() {
            if (cupit.seriesLoadedCards + 10 <=
                cupit.englishSeriesList.length) {
              cupit.seriesLoadedCards += 10;
              print("SeriesLoadedCards=${cupit.seriesLoadedCards}");
            } else {
              cupit.seriesLoadedCards = cupit.englishSeriesList.length;
              print("SeriesLoadedCards=${cupit.seriesLoadedCards}");
            }
          });
        }
      },
    );

    return SingleChildScrollView(
      controller: cupit.seriesScrollController,
      child: Container(
        width: double.infinity,
        height: ((cupit.seriesLoadedCards / 3) * 220) + 300,
        decoration: BoxDecoration(
          //  color: Colors.grey,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          children: [
            mAppBar(cupit, context),
            Text("Series",
                style: GoogleFonts.bitter(color: Colors.white, fontSize: 48)),
            Expanded(
              child: DynamicHeightGridView(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: cupit.seriesLoadedCards,
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  builder: (ctx, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Column(
                        children: [
                          seriesCard(
                              context: context,
                              imgLink: cupit.englishSeriesList[index].img!,
                              model: cupit.englishSeriesList[index]),
                          Text(
                            cupit.englishSeriesList[index].name!,
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
