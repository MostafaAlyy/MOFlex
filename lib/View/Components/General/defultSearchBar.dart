import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'DefultTextFourmField.dart';

Widget defaultSearchBar(var cupit) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: const Color.fromARGB(1000, 40, 39, 52),
            borderRadius: BorderRadius.circular(20)),
        height: 50,
        width: double.infinity,
        child: defaultTextFormFelid(
            fillColor: Colors.white,
            controller: cupit.searchController,
            text: "Search",
            prefixIcon: const Icon(CupertinoIcons.search, color: Colors.white)),
      ),
    );
