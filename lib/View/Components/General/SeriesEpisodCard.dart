import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moshahda_app/Models/SeriesModel.dart';
import 'package:moshahda_app/View/Pages/desktopWebView.dart';

import '../../Pages/viedioPlyerScr.dart';

Widget SeriesEpisodCard(
    {required SeriesModel Series,
    required int index,
    required var context,
    required Function onPlay}) {
  return Container(
    height: MediaQuery.of(context).size.height / 8,
    decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(18)),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 10,
            width: MediaQuery.of(context).size.height / 10,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(18)),
            child: CachedNetworkImage(
              imageUrl: Series.img!,
              fit: BoxFit.fill,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          const SizedBox(
            width: 60,
          ),
          Text(
            "Episode  ${index + 1}  \n ${index + 1} الحلقة ",
            style: const TextStyle(fontSize: 20, color: Colors.white),
          ),
          const Spacer(),
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                gradient: const LinearGradient(
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
                )),
            child: Center(
              child: IconButton(
                icon: const Icon(
                  FontAwesomeIcons.play,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () {
                  if (!Platform.isWindows) {
                    onPlay.call();
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DesktopWebView(Series.links!["${index + 1}"]!)),
                    );
                  }
                },
              ),
            ),
          )
        ],
      ),
    ),
  );
}
