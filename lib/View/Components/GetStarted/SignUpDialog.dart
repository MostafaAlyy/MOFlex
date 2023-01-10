import 'package:flutter/material.dart';

import '../General/DefultGridButton.dart';
import '../General/DefultTextFourmField.dart';

Future signUpDialog({
  required BuildContext context,
  required var cupit,
  required TextEditingController emailController,
  required TextEditingController passController,
  required TextEditingController NameController,
  required TextEditingController confirmPasswordController,
}) {
  return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Sign In",
      pageBuilder: (context, animation, secondaryAnimation) => Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              height: 620,
              width: 400,
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
                        Container(
                          height: 100,
                          width: 200,
                          child: Image.asset(
                            'assets/MainLogo.png',
                            scale: 1,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 350,
                          height: 50,
                          child: defaultTextFormFelid(
                              fillColor: Colors.grey,
                              controller: NameController,
                              text: 'Name',
                              prefixIcon: const Icon(
                                Icons.person_outline,
                                color: Colors.black,
                              )),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 350,
                          height: 50,
                          child: defaultTextFormFelid(
                              fillColor: Colors.grey,
                              controller: emailController,
                              text: 'Email Address',
                              prefixIcon: const Icon(
                                Icons.email_sharp,
                                color: Colors.black,
                              )),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 350,
                          height: 50,
                          child: defaultTextFormFelid(
                              fillColor: Colors.grey,
                              controller: passController,
                              text: 'Password',
                              prefixIcon: const Icon(
                                Icons.lock_person,
                                color: Colors.black,
                              )),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 350,
                          height: 50,
                          child: defaultTextFormFelid(
                              fillColor: Colors.grey,
                              controller: confirmPasswordController,
                              text: 'Confirm Password',
                              prefixIcon: const Icon(
                                Icons.lock_person,
                                color: Colors.black,
                              )),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defultGrediantButton(
                            text: "Sign Up",
                            ontab: () {
                              cupit.userRegister(
                                  email: emailController.text,
                                  password: passController.text,
                                  name: NameController.text);
                            })
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ));
}
