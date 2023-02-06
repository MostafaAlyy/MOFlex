import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moshahda_app/View/Components/General/MovieCard.dart';
import 'package:moshahda_app/ViewModel/Cupits/HomeCupit/home_cubit.dart';

class Home extends StatelessWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cupit = HomeCubit.get(context);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: double.infinity,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Popular Movies",
                style: GoogleFonts.roboto(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 160,
                child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: ((context, index) => movieCard(
                        context: context,
                        imgLink: cupit.moviesList[index].img!,
                        model: cupit.moviesList[index])),
                    separatorBuilder: ((context, index) => const SizedBox(
                          width: 10,
                        )),
                    itemCount: cupit.moviesList.length),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Popular Series",
                style: GoogleFonts.roboto(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 160,
                child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: ((context, index) => movieCard(
                        context: context,
                        imgLink: cupit.moviesList[index].img!,
                        model: cupit.moviesList[index])),
                    separatorBuilder: ((context, index) => const SizedBox(
                          width: 10,
                        )),
                    itemCount: cupit.moviesList.length),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Lastest Movies",
                style: GoogleFonts.roboto(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 160,
                child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: ((context, index) => movieCard(
                        context: context,
                        imgLink: cupit.moviesList[index].img!,
                        model: cupit.moviesList[index])),
                    separatorBuilder: ((context, index) => const SizedBox(
                          width: 10,
                        )),
                    itemCount: cupit.moviesList.length),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Lastest Series",
                style: GoogleFonts.roboto(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 160,
                child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: ((context, index) => movieCard(
                        context: context,
                        imgLink: cupit.moviesList[index].img!,
                        model: cupit.moviesList[index])),
                    separatorBuilder: ((context, index) => const SizedBox(
                          width: 10,
                        )),
                    itemCount: cupit.moviesList.length),
              )
            ]),
      ),
    );
  }
}
