import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moshahda_app/Models/MovieModel.dart';
import 'package:moshahda_app/Models/SeriesModel.dart';
import 'package:moshahda_app/View/Pages/MovieDetailedScr.dart';
import 'package:transition/transition.dart';

import '../../Pages/SeriesDetailedScr.dart';

Widget seriesCard(
    {required context, required String imgLink, required SeriesModel model}) {
  return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            Transition(
                child: SeriesDetailedScr(model),
                transitionEffect: TransitionEffect.SCALE));
      },
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        )),
        clipBehavior: Clip.hardEdge,
        height: 160,
        width: 142,
        child: CachedNetworkImage(
          imageUrl: imgLink,
          fit: BoxFit.fill,
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ));
}
