import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:moshahda_app/View/Components/General/DefultGridButton.dart';
import 'package:moshahda_app/View/Components/General/DefultTextFourmField.dart';
import 'package:moshahda_app/View/Components/GetStarted/SignUpDialog.dart';

Future signInDialog({
  required BuildContext context,
  required TextEditingController emailController,
  required var cupit,
  required TextEditingController passController,
  required TextEditingController NameController,
  required TextEditingController confirmPasswordController,
}) {
  return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Sign In",
      pageBuilder: (context, animation, secondaryAnimation) {
        return Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            height: MediaQuery.of(context).size.height / 1.2,
            width: MediaQuery.of(context).size.width / 1.1,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 5.5,
                        width: MediaQuery.of(context).size.width / 1.7,
                        child: Image.asset(
                          'assets/MainLogo.png',
                          scale: 1,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.2,
                        height: MediaQuery.of(context).size.height / 16,
                        child: defaultTextFormFelid(
                            fillColor: Colors.grey,
                            controller: emailController,
                            text: 'Email Address',
                            prefixIcon: const Icon(
                              Icons.email_sharp,
                              color: Colors.black,
                            )),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.2,
                        height: MediaQuery.of(context).size.height / 16,
                        child: defaultTextFormFelid(
                            fillColor: Colors.grey,
                            controller: passController,
                            text: 'Password',
                            prefixIcon: const Icon(
                              Icons.lock_person,
                              color: Colors.black,
                            )),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 50,
                          ),
                          const Text(
                            "Don't have an account? ",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          TextButton(
                              onPressed: () {
                                signUpDialog(
                                    context: context,
                                    emailController: emailController,
                                    passController: passController,
                                    confirmPasswordController:
                                        confirmPasswordController,
                                    NameController: NameController,
                                    cupit: cupit);
                              },
                              child: const Text("Sign Up")),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      defultGrediantButton(
                          context: context,
                          text: "Sign In",
                          ontab: () {
                            cupit.userLogin(
                                email: emailController.text,
                                password: passController.text);
                          })
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      });
}
