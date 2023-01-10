part of 'general_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

//add user to database
class CreateUserSuccessState extends AuthState {}

class CreateUserErrorState extends AuthState {}

//register
class RegistererUserSuccessState extends AuthState {}

class RegistererUserErrorState extends AuthState {
  final String error;
  RegistererUserErrorState(this.error);
}

//sign in
class LogInSuccessState extends AuthState {
  final String uId;
  LogInSuccessState(this.uId);
}

class LogInLoadingState extends AuthState {}

class LogInErrorState extends AuthState {
  final String error;
  LogInErrorState(this.error);
}
