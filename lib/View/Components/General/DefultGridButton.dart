import 'package:flutter/material.dart';

Widget defultGrediantButton({
  required String text,
  required Function() ontab,
}) {
  return InkWell(
    onTap: ontab,
    child: Container(
      height: 50,
      width: 350,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [
              0.1,
              0.4,
              0.6,
              0.9,
            ],
            colors: [
              Colors.yellow,
              Colors.red,
              Colors.indigo,
              Colors.teal,
            ],
          )),
      child: Center(
          child: Text(
        "${text}",
        style: const TextStyle(
            color: Color.fromARGB(255, 210, 240, 255),
            fontSize: 20,
            fontWeight: FontWeight.bold),
      )),
    ),
  );
}
