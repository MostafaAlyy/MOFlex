import 'package:flutter/cupertino.dart';
import '../General/appBar.dart';
import 'homeDotsIndicator.dart';
import './animatedSlider.dart';

Widget homeBanner(var cupit) => Container(
      height: 400,
      child: Stack(
        children: [
          Container(
            height: 400,
            width: double.infinity,
            child: Image.network(
              'https://cima4uu.autos/wp-content/uploads/075-3486.jpg',
              fit: BoxFit.fill,
            ),
          ),
          mAppBar(cupit),
          Container(
              height: 400,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                const Color.fromARGB(1000, 11, 10, 28).withOpacity(0.60),
                const Color.fromARGB(1000, 11, 10, 28).withOpacity(0.0),
              ], end: Alignment.topCenter, begin: Alignment.bottomCenter))),
          animatedSlider(cupit),
          homeDotsIndicator(cupit),
        ],
      ),
    );
