import 'package:flutter/material.dart';

Widget defaultSearchBar(
        {required var cupit, required Function(String)? onchange}) =>
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          decoration: BoxDecoration(
              color: const Color.fromARGB(1000, 40, 39, 52),
              borderRadius: BorderRadius.circular(20)),
          height: 50,
          width: 300,
          child: TextFormField(
            style: const TextStyle(color: Colors.white),
            controller: cupit.searchController,
            validator: (String? value) {
              if (value!.isEmpty) {
                return "this filed cant be empty";
              }
              return null;
            },
            onChanged: onchange,
            onFieldSubmitted: onchange,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              fillColor: const Color.fromARGB(255, 11, 10, 28),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              labelText: "Search",
              labelStyle: const TextStyle(color: Colors.white),
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
          )),
    );
