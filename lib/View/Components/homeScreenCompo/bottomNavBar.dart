import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

Widget homeBottomeNavBar(var cupit) => Container(
      color: const Color.fromARGB(1000, 40, 39, 52),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: GNav(
            color: Colors.white,
            onTabChange: (value) {
              cupit.changePage(value);
            },
            haptic: true, // haptic feedback
            tabBorderRadius: 20,
            // tab button border
            tabBackgroundGradient: const LinearGradient(
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
            ),
            curve: Curves.easeOutExpo, // tab animation curves
            duration:
                const Duration(milliseconds: 400), // tab animation duration
            gap: 10, // the tab button gap between icon and text
            activeColor: Colors.white,
            iconSize: 26,

            padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 12), //

            // ignore: prefer_const_literals_to_create_immutables
            tabs: [
              const GButton(
                icon: CupertinoIcons.home,
                text: 'Home',
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              ),
              const GButton(
                icon: CupertinoIcons.heart,
                text: 'Favorites',
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              ),
              const GButton(
                icon: FontAwesomeIcons.clapperboard,
                text: 'Movies',
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              ),
              const GButton(
                icon: FontAwesomeIcons.photoFilm,
                text: 'Series',
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              )
            ],
          ),
        ),
      ),
    );
