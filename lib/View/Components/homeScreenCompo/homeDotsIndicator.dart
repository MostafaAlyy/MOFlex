import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget homeDotsIndicator(var cupit) => Align(
    alignment: Alignment.bottomCenter,
    child: DotsIndicator(
      dotsCount: 10,
      position: cupit.focusedIndex.toDouble(),
      decorator: DotsDecorator(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.0)),
        color: Color.fromARGB(221, 255, 255, 255), // Inactive color
        activeColor: Color.fromARGB(255, 140, 137, 137),
      ),
    ));
