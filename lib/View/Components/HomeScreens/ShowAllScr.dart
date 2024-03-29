import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:moshahda_app/Models/MovieModel.dart';
import 'package:moshahda_app/View/Components/General/MovieCard.dart';

import '../../../ViewModel/Cupits/HomeCupit/home_cubit.dart';
import '../../../ViewModel/admobAdsManger.dart';
import '../General/appBar.dart';

class ShowAll extends StatefulWidget {
  List<MovieModel> movies;
  String title;
  var cupit;
  ShowAll(this.movies, this.title, this.cupit, {super.key});
  @override
  State<ShowAll> createState() => _ShowAllState(movies, title);
}

class _ShowAllState extends State<ShowAll> {
  List<MovieModel> movies;
  String title;

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

  _ShowAllState(this.movies, this.title);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cupit = HomeCubit.get(context);

          cupit.showAllController.addListener(
            () {
              if (cupit.showAllController.position.pixels ==
                  cupit.showAllController.position.maxScrollExtent) {
                setState(() {
                  if (cupit.showAllLoadedCard + 10 <= movies.length) {
                    cupit.showAllLoadedCard += 10;
                    print("MoviesLoadedCards=${cupit.showAllLoadedCard}");
                  } else {
                    cupit.showAllLoadedCard = movies.length;
                  }
                });
              }
            },
          );

          return Scaffold(
            backgroundColor: const Color.fromARGB(1000, 11, 10, 28),
            body: SingleChildScrollView(
              controller: cupit.showAllController,
              child: Container(
                decoration: BoxDecoration(
                  //  color: Colors.grey,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  children: [
                    mAppBar(cupit, context),
                    Text(title,
                        style: GoogleFonts.bitter(
                            color: Colors.white, fontSize: 48)),
                    if (banner != null)
                      SizedBox(
                          height: MediaQuery.of(context).size.height / 10,
                          width: MediaQuery.of(context).size.width,
                          child: AdWidget(ad: banner!)),
                    SizedBox(
                      width: double.infinity,
                      height: ((cupit.showAllLoadedCard / 2.4) *
                              (MediaQuery.of(context).size.height / 5)) +
                          (MediaQuery.of(context).size.height / 2),
                      child: DynamicHeightGridView(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: cupit.showAllLoadedCard,
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
                                      imgLink: movies[index].img!,
                                      model: movies[index]),
                                  Text(
                                    movies[index].name!,
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
            ),
          );
        },
      ),
    );
  }
}
