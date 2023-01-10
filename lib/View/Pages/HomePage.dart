// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:moshahda_app/View/Components/General/MovieCard.dart';
import 'package:moshahda_app/View/Components/HomeScreens/Home.dart';
import 'package:moshahda_app/ViewModel/Cupits/HomeCupit/home_cubit.dart';

import '../Components/General/DefultTextFourmField.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cupit = HomeCubit.get(context);
          return Scaffold(
              backgroundColor: const Color.fromARGB(1000, 11, 10, 28),
              body: SingleChildScrollView(
                // physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      height: 400,
                      child: Stack(
                        children: [
                          if (cupit.screens[cupit.currentPage] is Home)
                            Container(
                              height: 400,
                              width: double.infinity,
                              child: Image.network(
                                'https://cima4uu.autos/wp-content/uploads/075-3486.jpg',
                                fit: BoxFit.fill,
                              ),
                            ),
                          Column(
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
                                                fontSize: 20),
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
                          ),
                          if (cupit.screens[cupit.currentPage] is Home)
                            Align(
                              alignment: Alignment.center,
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                    height: 100,
                                    width: 80,
                                    child: movieCard(),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                    height: 160,
                                    width: 142,
                                    child: movieCard(),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                    height: 100,
                                    width: 80,
                                    child: movieCard(),
                                  )
                                ],
                              ),
                            ),
                          if (cupit.screens[cupit.currentPage] is Home)
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Icon(
                                FontAwesomeIcons.ellipsis,
                                size: 50,
                                //  color: Colors.grey.withOpacity(1),
                              ),
                            ),
                          if (cupit.screens[cupit.currentPage] is Home)
                            Container(
                                height: 400,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: [
                                      const Color.fromARGB(1000, 11, 10, 28)
                                          .withOpacity(0.60),
                                      const Color.fromARGB(1000, 11, 10, 28)
                                          .withOpacity(0.0),
                                    ],
                                        end: Alignment.topCenter,
                                        begin: Alignment.bottomCenter))),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (cupit.screens[cupit.currentPage] is Home)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(1000, 40, 39, 52),
                              borderRadius: BorderRadius.circular(20)),
                          height: 50,
                          width: double.infinity,
                          child: defaultTextFormFelid(
                              fillColor: Colors.white,
                              controller: cupit.searchController,
                              text: "Search",
                              prefixIcon: Icon(CupertinoIcons.search,
                                  color: Colors.white)),
                        ),
                      ),
                    cupit.screens[cupit.currentPage],
                  ],
                ),
              ),
              bottomNavigationBar: Container(
                color: const Color.fromARGB(1000, 40, 39, 52),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 8),
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
                      duration: const Duration(
                          milliseconds: 400), // tab animation duration
                      gap: 10, // the tab button gap between icon and text
                      activeColor: Colors.white,
                      iconSize: 26,

                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12), //

                      // ignore: prefer_const_literals_to_create_immutables
                      tabs: [
                        const GButton(
                          icon: CupertinoIcons.home,
                          text: 'Home',
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                        ),
                        const GButton(
                          icon: CupertinoIcons.heart,
                          text: 'Favorites',
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                        ),
                        const GButton(
                          icon: FontAwesomeIcons.clapperboard,
                          text: 'Movies',
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                        ),
                        const GButton(
                          icon: FontAwesomeIcons.photoFilm,
                          text: 'Series',
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                        )
                      ],
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }
}
