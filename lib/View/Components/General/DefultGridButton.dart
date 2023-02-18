import 'package:flutter/material.dart';

Widget defultGrediantButton(
    {required String text, required Function() ontab, required var context}) {
  return InkWell(
    onTap: ontab,
    child: Container(
      height: MediaQuery.of(context).size.height / 15,
      width: MediaQuery.of(context).size.width / 1.1,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
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
          )),
      child: Center(
          child: Text(
        text,
        style: const TextStyle(
            color: Color.fromARGB(255, 210, 240, 255),
            fontSize: 20,
            fontWeight: FontWeight.bold),
      )),
    ),
  );
}
