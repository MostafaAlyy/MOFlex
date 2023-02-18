import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moshahda_app/ViewModel/Cupits/HomeCupit/home_cubit.dart';
import '../General/appBar.dart';
import 'homeDotsIndicator.dart';
import './animatedSlider.dart';

class homeBanner extends StatelessWidget {
  var cupit;
  homeBanner(this.cupit);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return SizedBox(
          height: MediaQuery.of(context).size.height / 2,
          width: double.infinity,
          child: Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                width: double.infinity,
                child: CachedNetworkImage(
                  imageUrl: HomeCubit.moviesList[cupit.focusedIndex].img!,
                  fit: BoxFit.fill,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              Container(
                  height: MediaQuery.of(context).size.height / 2,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    const Color.fromARGB(1000, 11, 10, 28).withOpacity(0.60),
                    const Color.fromARGB(1000, 11, 10, 28).withOpacity(0.0),
                  ], end: Alignment.topCenter, begin: Alignment.bottomCenter))),
              animatedSlider(cupit, context),
              homeDotsIndicator(cupit),
              mAppBar(cupit, context),
            ],
          ),
        );
      },
    );
    ;
  }
}
