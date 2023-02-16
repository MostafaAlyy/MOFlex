import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

import '../../../ViewModel/Cupits/HomeCupit/home_cubit.dart';
import '../General/MovieCard.dart';

Widget animatedSlider(var cupit, var context) => Align(
    alignment: Alignment.center,
    child: SizedBox(
      height: MediaQuery.of(context).size.height / 4.5,
      child: ScrollSnapList(
        itemBuilder: ((context, index) => movieCard(
            context: context,
            imgLink: HomeCubit.moviesList[index].img!,
            model: HomeCubit.moviesList[index])),
        itemCount:
            (HomeCubit.moviesList.length >= 10) ? 10 : cupit.moviesList.length,
        itemSize: MediaQuery.of(context).size.width / 2.98,
        onItemFocus: cupit.onItemFocuss,
        dynamicItemSize: true,
        padding: EdgeInsets.zero,
      ),
    ));
