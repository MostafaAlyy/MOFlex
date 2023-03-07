import 'package:flutter/material.dart';

class NotFoundScr extends StatelessWidget {
  const NotFoundScr({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(
          "Trailer Not Available Now",
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.08,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
