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
            Transition(
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
        height: 160,
        width: 142,
        child: Image(
          image: NetworkImage(
            imgLink,
          ),
          fit: BoxFit.fill,
        ),
      ));
}
