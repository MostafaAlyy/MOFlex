import 'package:flutter/cupertino.dart';

Widget movieCard() {
  return GestureDetector(
      child: Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
      topLeft: Radius.circular(20),
      bottomRight: Radius.circular(20),
    )),
    clipBehavior: Clip.hardEdge,
    height: 160,
    width: 142,
    child: Image(
      image: NetworkImage(
        'https://cima4uu.autos/wp-content/uploads/55-117.jpg',
      ),
      fit: BoxFit.fill,
    ),
  ));
}
