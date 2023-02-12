import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moshahda_app/Models/SeriesModel.dart';
import 'package:moshahda_app/View/Pages/desktopWebView.dart';
import 'package:moshahda_app/View/Pages/viedioPlyerScr.dart';

import '../../ViewModel/Cupits/HomeCupit/home_cubit.dart';
import '../Components/General/SeriesEpisodCard.dart';

class SeriesDetailedScr extends StatelessWidget {
  SeriesModel Series;
  SeriesDetailedScr(this.Series);

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

          return Scaffold(
            backgroundColor: const Color.fromARGB(1000, 11, 10, 28),
            body: BlocProvider(
              create: (context) => HomeCubit(),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 400,
                          width: double.infinity,
                          child: CachedNetworkImage(
                            imageUrl: Series.img!,
                            fit: BoxFit.fill,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                        Container(
                            height: 500,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                  const Color.fromARGB(1000, 11, 10, 28)
                                      .withOpacity(0.60),
                                  const Color.fromARGB(1000, 11, 10, 28)
                                      .withOpacity(0.0),
                                ],
                                    end: Alignment.topCenter,
                                    begin: Alignment.bottomCenter))),
                        //back button
                        Positioned(
                            top: 20,
                            child: IconButton(
                              icon: const Icon(
                                FontAwesomeIcons.chevronLeft,
                                color: Color.fromARGB(1000, 11, 10, 28),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )),
                        //play button
                        Positioned(
                            top: 370,
                            left: 310,
                            child: Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  gradient: const LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: [
                                      Color(0xff1f005c),
                                      Color(0xff5b0060),
                                      Color(0xff870160),
                                      Color(0xffac255e),
                                      Color(0xffca485c),
                                      Color(0xffe16b5c),
                                      Color(0xfff39060),
                                      Color(0xffffb56b),
                                    ],
                                  )),
                              child: Center(
                                child: IconButton(
                                  icon: const Icon(
                                    FontAwesomeIcons.play,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    if (!Platform.isWindows) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                VideoPlayerScr(
                                                    Series.links!["1"]!)),
                                      );
                                    } else {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DesktopWebView(
                                                    Series.links!["1"]!)),
                                      );
                                    }
                                  },
                                ),
                              ),
                            )),
                        Positioned(
                          left: 10,
                          top: 410,
                          child: SizedBox(
                            width: 300,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  Series.name!,
                                  style: GoogleFonts.roboto(
                                      color: Colors.white, fontSize: 24),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  "Date: ${Series.dateTime} ",
                                  style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: Series.links!.length * 140,
                        child: ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: Series.links!.length,
                          itemBuilder: (context, index) => SeriesEpisodCard(
                              Series: Series, context: context, index: index),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 20),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
                onPressed: () {
                  cupit.FavoriteSeriestoDB(Series);
                },
                backgroundColor: Colors.grey.withOpacity(0.2),
                child: Icon(
                  Icons.favorite,
                  size: 40,
                  color:
                      (HomeCubit.favoriteSeries.containsKey('${Series.name}'))
                          ? Colors.redAccent
                          : Colors.grey[300]!.withOpacity(0.2),
                )),
          );
        },
      ),
    );
  }
}
