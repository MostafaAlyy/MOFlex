import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moshahda_app/Models/MovieModel.dart';
import 'package:moshahda_app/View/Pages/MovieDetailedScr.dart';
import 'package:transition/transition.dart';

Widget movieCard(
    {required context, required String imgLink, required MovieModel model}) {
  return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            Transitiont(
                child: MovieDetailedScr(model),
                transitionEffect: TransitionEffect.SCALE));
      },
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        )),
        clipBehavior: Clip.hardEdge,
        height: MediaQuery.of(context).size.height / 5.2,
        width: MediaQuery.of(context).size.width / 3,
        child: CachedNetworkImage(
          imageUrl: imgLink,
          fit: BoxFit.fill,
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ));
}
