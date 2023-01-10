import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../Models/UserModel.dart';
part 'general_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  static AuthCubit get(BuildContext context) => BlocProvider.of(context);

  TextEditingController emailController = TextEditingController(),
      passwordController = TextEditingController(),
      NameController = TextEditingController(),
      confirmPasswordController = TextEditingController();
  UserModel? user;

  void userRegister(
      {required String email,
      required String password,
      required String name}) async {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(RegistererUserSuccessState());
      userCreate(
          emailAddress: email,
          password: password,
          uId: value.user!.uid,
          name: name);
    }).catchError((onError) {
      emit(RegistererUserErrorState(onError.toString()));
    });
  }

  userCreate({
    required String emailAddress,
    required String password,
    required String name,
    required String uId,
  }) async {
    user = UserModel(
        email: emailAddress, name: name, password: password, uId: uId);
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(user!.toMap())
        .then((value) {
      emit(CreateUserSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(CreateUserErrorState());
    });
  }

  void userLogin({required String email, required String password}) {
    emit(LogInLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(LogInSuccessState(value.user!.uid));
    }).catchError((onError) {
      print(onError.toString());

      emit(LogInErrorState(onError.toString()));
    });
  }
}
