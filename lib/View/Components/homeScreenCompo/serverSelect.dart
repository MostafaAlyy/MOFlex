import 'package:flutter/material.dart';
import 'package:moshahda_app/Models/MovieModel.dart';
import 'package:moshahda_app/View/Components/General/DefultGridButton.dart';
import 'package:moshahda_app/View/Components/General/DefultTextFourmField.dart';
import 'package:moshahda_app/View/Components/GetStarted/SignUpDialog.dart';

Future serverSelectDialog(
    {required BuildContext context,
    required MovieModel movie,
    required Function openMovie}) {
  return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Sign In",
      pageBuilder: (context, animation, secondaryAnimation) {
        return Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width / 1.1,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 11, 10, 28),
                borderRadius: BorderRadius.circular(20)),
            child: Scaffold(
              backgroundColor: const Color.fromARGB(255, 11, 10, 28),
              body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        openMovie(movie.link);
                      },
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height / 9,
                        width: MediaQuery.of(context).size.width / 1.1,
                        child: const Center(
                          child: Text(
                            'Server 1',
                            style: TextStyle(color: Colors.white, fontSize: 22),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        openMovie(movie.link2);
                      },
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height / 9,
                        width: MediaQuery.of(context).size.width / 1.1,
                        child: const Center(
                          child: Text(
                            'Server 2',
                            style: TextStyle(color: Colors.white, fontSize: 22),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        openMovie(movie.link3);
                      },
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height / 9,
                        width: MediaQuery.of(context).size.width / 1.1,
                        child: const Center(
                          child: Text(
                            'Server 3',
                            style: TextStyle(color: Colors.white, fontSize: 22),
                          ),
                        ),
                      ),
                    )
                  ]),
            ),
          ),
        );
      });
}
