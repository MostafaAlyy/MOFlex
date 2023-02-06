import 'package:flutter/cupertino.dart';
import '../General/appBar.dart';
import 'homeDotsIndicator.dart';
import './animatedSlider.dart';

Widget homeBanner(var cupit) => SizedBox(
      height: 400,
      child: Stack(
        children: [
          SizedBox(
            height: 400,
            width: double.infinity,
            child: Image.network(
              cupit.moviesList[cupit.focusedIndex].img,
              fit: BoxFit.fill,
            ),
          ),
          Container(
              height: 400,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                const Color.fromARGB(1000, 11, 10, 28).withOpacity(0.60),
                const Color.fromARGB(1000, 11, 10, 28).withOpacity(0.0),
              ], end: Alignment.topCenter, begin: Alignment.bottomCenter))),
          animatedSlider(cupit),
          homeDotsIndicator(cupit),
          mAppBar(cupit),
        ],
      ),
    );
