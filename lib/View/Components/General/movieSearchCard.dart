import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:transition/transition.dart';

import '../../../ViewModel/Cupits/HomeCupit/home_cubit.dart';
import '../../Pages/MovieDetailedScr.dart';

Widget movieSearchCard(
    {required var context, required var cupit, required var index}) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context,
          Transitiont(
              child: MovieDetailedScr(HomeCubit.searchListMovies[index]),
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
              height: 90,
              width: 90,
              clipBehavior: Clip.hardEdge,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(18)),
              child: CachedNetworkImage(
                imageUrl: HomeCubit.searchListMovies[index].img!,
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
              HomeCubit.searchListMovies[index].name!,
              maxLines: 2,
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ]),
      ),
    ),
  );
}
