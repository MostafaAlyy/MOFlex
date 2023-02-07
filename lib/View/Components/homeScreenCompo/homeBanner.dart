import 'package:flutter/cupertino.dart';
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
          height: 400,
          child: Stack(
            children: [
              SizedBox(
                height: 400,
                width: double.infinity,
                child: Image.network(
                  cupit.moviesList[cupit.focusedIndex].img,
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                  height: 400,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    const Color.fromARGB(1000, 11, 10, 28).withOpacity(0.60),
                    const Color.fromARGB(1000, 11, 10, 28).withOpacity(0.0),
                  ], end: Alignment.topCenter, begin: Alignment.bottomCenter))),
              animatedSlider(cupit),
              homeDotsIndicator(cupit),
              mAppBar(cupit),
            ],
          ),
        );
      },
    );
    ;
  }
}
