import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moshahda_app/View/Components/General/SearchDialog.dart';

Widget mAppBar(var cupit, var context) => Column(
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
                        color: Colors.white,
                        fontSize: 20,
                        shadows: const [
                          Shadow(
                            blurRadius: 20.0,
                            color: Colors.black,
                            offset: Offset(6.0, 6.0),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          searchDialog(context: context, cupit: cupit);
                        },
                        icon: const Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 35,
                        ))
                  ],
                ),
              ),
            )),
      ],
    );
