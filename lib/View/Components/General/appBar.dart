import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

Widget mAppBar(var cupit) => Column(
      children: [
        PreferredSize(
            preferredSize: const Size.fromHeight(80.0),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                height: 80,
                width: double.infinity,
                child: Row(
                  children: [
                    Container(
                      height: 45,
                      width: 60,
                      child: Image.asset(
                        'assets/MainLogo.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Moshahda",
                      style: GoogleFonts.prostoOne(
                          color: Colors.white, fontSize: 20),
                    ),
                    Spacer(),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.notifications_none,
                          color: Colors.white,
                          size: 35,
                        ))
                  ],
                ),
              ),
            )),
      ],
    );
