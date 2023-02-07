import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

import '../General/MovieCard.dart';

Widget animatedSlider(var cupit) => Align(
    alignment: Alignment.center,
    child: SizedBox(
      height: 160,
      child: ScrollSnapList(
        itemBuilder: ((context, index) => movieCard(
            context: context,
            imgLink: cupit.moviesList[index].img!,
            model: cupit.moviesList[index])),
        itemCount:
            (cupit.moviesList.length >= 10) ? 10 : cupit.moviesList.length,
        itemSize: 150,
        onItemFocus: cupit.onItemFocuss,
        dynamicItemSize: true,
        padding: EdgeInsets.zero,
      ),
    ));
