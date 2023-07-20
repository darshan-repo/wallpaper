part of 'auth_bloc_bloc.dart';

@immutable
abstract class AuthBlocEvent {}

class UserSignUp extends AuthBlocEvent {
  final String name;
  final String email;
  final String passWord;

  UserSignUp({required this.name, required this.email, required this.passWord});
}

class LoginWithOtp extends AuthBlocEvent {
  final String email;
  final String passWord;
  final BuildContext context;

  LoginWithOtp(
      {required this.email, required this.passWord, required this.context});
}

class VerifyOtp extends AuthBlocEvent {
  final String email;
  final String passWord;
  final int otp;

  VerifyOtp({required this.email, required this.passWord, required this.otp});
}

class ForgotOtpSend extends AuthBlocEvent {
  final String email;
  final BuildContext context;

  ForgotOtpSend({required this.email, required this.context});
}

class ForgotOtpVerify extends AuthBlocEvent {
  final String email;
  final int otp;

  ForgotOtpVerify({required this.email, required this.otp});
}

class ResetPassWord extends AuthBlocEvent {
  final String email;
  final String password;
  final String confirmPassword;

  ResetPassWord(
      {required this.email,
      required this.password,
      required this.confirmPassword});
}