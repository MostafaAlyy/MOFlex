import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moshahda_app/View/Pages/SeriesDetailedScr.dart';
import 'package:transition/transition.dart';

import '../../../ViewModel/Cupits/HomeCupit/home_cubit.dart';
import '../../Pages/MovieDetailedScr.dart';

Widget seriesSearchCard(
    {required var context, required var cupit, required var index}) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context,
          Transitiont(
              child: SeriesDetailedScr(HomeCubit.searchListSeries[index]),
              transitionEffect: TransitionEffect.SCALE));
    },
    child: Container(
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.3),
          borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(children: [
          Center(
            child: Container(
              height: MediaQuery.of(context).size.height / 10,
              width: MediaQuery.of(context).size.height / 10,
              clipBehavior: Clip.hardEdge,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(18)),
              child: CachedNetworkImage(
                imageUrl: HomeCubit.searchListSeries[index].img!,
                fit: BoxFit.fill,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          SizedBox(
            width: 200,
            child: Text(
              HomeCubit.searchListSeries[index].name!,
              maxLines: 2,
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ]),
      ),
    ),
  );
}
