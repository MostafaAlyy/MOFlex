// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'GetStarted.dart';

class SplashScr extends StatefulWidget {
  Widget widget;
  SplashScr({
    super.key,
    required this.widget,
  });

  @override
  State<SplashScr> createState() => _SplashScrState(this.widget);
}

class _SplashScrState extends State<SplashScr>
    with SingleTickerProviderStateMixin {
  Widget wid;
  _SplashScrState(this.wid);
  AnimationController? animationController;
  @override
  void initState() {
    // TODO: implement initState

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    animationController!.addListener(() {
      setState(() {
        if (animationController!.value >= 1)
          // ignore: curly_braces_in_flow_control_structures
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => wid),
          );
      });
    });
    animationController!.forward();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final percentage = animationController!.value * 100;

    return Scaffold(
      backgroundColor: const Color.fromARGB(1000, 11, 10, 28),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                height: 300,
                width: 300,
                child: Image.asset('assets/MainLogo.png')),
            Container(
              height: 20,
              width: 350,
              child: LiquidLinearProgressIndicator(
                valueColor: const AlwaysStoppedAnimation(Colors.deepOrange),
                borderRadius: 20,
                value: animationController!.value,
                center: Text(
                  '${percentage.toStringAsFixed(0)}%',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Colors.black,
                  ),
                ),
                borderColor: Colors.black,
                borderWidth: 1.0,
                direction: Axis.horizontal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
