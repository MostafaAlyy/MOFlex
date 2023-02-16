import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moshahda_app/View/Components/General/SearchDialog.dart';

Widget mAppBar(var cupit, var context) => Column(
      children: [
        PreferredSize(
            preferredSize:
                Size.fromHeight(MediaQuery.of(context).size.height / 12),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 12,
                width: double.infinity,
                child: Row(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 20,
                      width: MediaQuery.of(context).size.width / 7,
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
                            blurRadius: 90.0,
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
