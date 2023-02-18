import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:moshahda_app/View/Components/General/MovieCard.dart';

import '../../../ViewModel/Cupits/HomeCupit/home_cubit.dart';
import '../../../ViewModel/admobAdsManger.dart';
import '../General/appBar.dart';

class Movies extends StatefulWidget {
  const Movies({Key? key}) : super(key: key);

  @override
  State<Movies> createState() => _MoviesState();
}

class _MoviesState extends State<Movies> {
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
    var cupit = HomeCubit.get(context);

    cupit.moviesScrollController.addListener(
      () {
        if (cupit.moviesScrollController.position.pixels ==
            cupit.moviesScrollController.position.maxScrollExtent) {
          setState(() {
            if (cupit.moviesLoadedCards + 10 <= HomeCubit.moviesList.length) {
              cupit.moviesLoadedCards += 10;
              print("MoviesLoadedCards=${cupit.moviesLoadedCards}");
            } else {
              cupit.moviesLoadedCards = HomeCubit.moviesList.length;
            }
          });
        }
      },
    );

    return SingleChildScrollView(
      controller: cupit.moviesScrollController,
      child: Container(
        width: double.infinity,
        height: ((cupit.moviesLoadedCards / 3) *
                (MediaQuery.of(context).size.height / 5.2)) +
            (MediaQuery.of(context).size.height / 3),
        decoration: BoxDecoration(
          //  color: Colors.grey,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          children: [
            mAppBar(cupit, context),
            Text("Movies",
                style: GoogleFonts.bitter(color: Colors.white, fontSize: 48)),
            if (banner != null)
              SizedBox(
                  height: MediaQuery.of(context).size.height / 10,
                  width: MediaQuery.of(context).size.width,
                  child: AdWidget(ad: banner!)),
            Expanded(
              child: DynamicHeightGridView(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: cupit.moviesLoadedCards,
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
                              imgLink: HomeCubit.moviesList[index].img!,
                              model: HomeCubit.moviesList[index]),
                          Text(
                            HomeCubit.moviesList[index].name!,
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
