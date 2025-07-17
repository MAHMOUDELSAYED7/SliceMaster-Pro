part of 'auth_cubit.dart';

@immutable
abstract class AuthStatusState {}

class LogoutInitial extends AuthStatusState {}

class Logout extends AuthStatusState {}

class Login extends AuthStatusState {}

class LogoutFailure extends AuthStatusState {}
