import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../ViewModel/Cupits/HomeCupit/home_cubit.dart';

Widget homeDotsIndicator(var cupit) => Align(
    alignment: Alignment.bottomCenter,
    child: DotsIndicator(
      dotsCount:
          (HomeCubit.moviesList.length >= 10) ? 10 : cupit.moviesList.length,
      position: cupit.focusedIndex.toDouble(),
      decorator: DotsDecorator(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.0)),
        color: const Color.fromARGB(221, 255, 255, 255), // Inactive color
        activeColor: const Color.fromARGB(255, 140, 137, 137),
      ),
    ));
