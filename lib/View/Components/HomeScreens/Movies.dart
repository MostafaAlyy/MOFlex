import 'package:flutter/material.dart';

class Movies extends StatelessWidget {
  const Movies({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 800,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(18),
      ),
    );
  }
}
