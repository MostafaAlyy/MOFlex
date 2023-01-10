import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:moshahda_app/View/Components/General/DefultGridButton.dart';
import 'package:moshahda_app/View/Components/GetStarted/SignInDialog.dart';
import 'package:moshahda_app/View/Pages/HomePage.dart';
import 'package:moshahda_app/ViewModel/Cupits/AuthCupit/general_cubit.dart';

import '../../ViewModel/Database/local/sharedPreferns.dart';

class GetStart extends StatelessWidget {
  const GetStart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is RegistererUserSuccessState) {
            Navigator.pop(context);
            Fluttertoast.showToast(
                msg: "Register Success",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
          } else if (state is RegistererUserErrorState) {
            Fluttertoast.showToast(
                msg: state.error,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          } else if (state is LogInSuccessState) {
            CashHelper.SaveData(key: 'uId', value: state.uId);
            Fluttertoast.showToast(
                msg: "Sign In Success",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) {
                return HomePage();
              }),
            );
          } else if (state is LogInErrorState) {
            Fluttertoast.showToast(
                msg: state.error,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        },
        builder: (context, state) {
          var cupit = AuthCubit.get(context);
          return Scaffold(
              body: Stack(
            children: [
              Container(
                  child: Image.asset(
                'assets/GetStartedBackrgound.jpeg',
                width: 400,
                fit: BoxFit.fill,
              )),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 700,
                    ),
                    defultGrediantButton(
                        text: "Get Started",
                        ontab: (() => signInDialog(
                              cupit: cupit,
                              context: context,
                              emailController: cupit.emailController,
                              passController: cupit.passwordController,
                              confirmPasswordController:
                                  cupit.confirmPasswordController,
                              NameController: cupit.NameController,
                            )))
                  ],
                ),
              )
            ],
          ));
        },
      ),
    );
  }
}
