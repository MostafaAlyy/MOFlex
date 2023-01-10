import 'package:flutter/material.dart';

Widget defaultTextFormFelid({
  required TextEditingController controller,
  required String text,
  required Icon prefixIcon,
  required Color fillColor,
}) {
  return TextFormField(
    controller: controller,
    validator: (String? value) {
      if (value!.isEmpty) {
        return "Please enter ${text}";
      }
      return null;
    },
    keyboardType: TextInputType.emailAddress,
    decoration: InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      labelText: "${text}",
      labelStyle: TextStyle(color: fillColor),
      prefixIcon: prefixIcon,
    ),
  );
}
