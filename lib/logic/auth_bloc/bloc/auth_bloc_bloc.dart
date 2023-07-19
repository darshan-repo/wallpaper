import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:wallpaper/base_api/base_api.dart';
import 'package:wallpaper/navigation/app_navigation.dart';
import 'package:wallpaper/presentation/common/comman_snackbar.dart';
import 'package:wallpaper/presentation/common/shared_prefs.dart';
import 'package:wallpaper/presentation/modules/otp/view/change_password.dart';
import 'package:wallpaper/presentation/modules/otp/view/email_varification.dart';
import 'package:wallpaper/presentation/modules/otp/view/otp_varification.dart';
import 'package:wallpaper/presentation/modules/otp/view/set_password.dart';

part 'auth_bloc_event.dart';

part 'auth_bloc_state.dart';

class AuthBlocBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  AuthBlocBloc() : super(AuthBlocInitial()) {
    on<UserSignUp>(_userSignUp);
    on<LoginWithOtp>(_loginWithOtp);
    on<VerifyOtp>(_verifyOtp);
    on<ForgotOtpSend>(_forgotOtpSend);
    on<ForgotOtpVerify>(_verifyForgotOtp);
    on<ResetPassWord>(_resetPassword);
  }

  _userSignUp(UserSignUp event, Emitter<AuthBlocState> emit) async {
    emit(AuthBlocLoading());
    try {
      Map<String, dynamic> data = await BaseApi.postRequest("signup", data: {
        "username": event.name,
        "email": event.email,
        "password": event.passWord
      });
      log("REASONABLE ::$data");
      if (data["message"] == "User created") {
        AppNavigation.shared.moveToLoginScreen();

        emit(AuthBlocLoaded());
      } else {
        errorSnackbar(data["message"]);
        emit(AuthBlocLoaded());
      }
    } catch (e) {
      errorSnackbar(e.toString());

      log(e.toString());
      emit(AuthBlocError());
    }
  }

  _loginWithOtp(LoginWithOtp event, Emitter<AuthBlocState> emit) async {
    emit(AuthBlocLoading());
    try {
      Map<String, dynamic> data = await BaseApi.postRequest("sentotp",
          data: {"email": event.email, "password": event.passWord});
      log("REASONABLE ::$data");
      if (data["message"] == "otp sent successfully") {
        Get.to(OTPVarificationScreen(
          isForgot: false,
          email: event.email,
          passWord: event.passWord,
        ));
        emit(AuthBlocLoaded());
      } else {
        errorSnackbar(data["message"]);
        emit(AuthBlocLoaded());
      }
    } catch (e) {
      errorSnackbar(e.toString());
      log(e.toString());
      emit(AuthBlocError());
    }
  }

  _verifyOtp(VerifyOtp event, Emitter<AuthBlocState> emit) async {
    emit(AuthBlocLoading());
    try {
      Map<String, dynamic> data = await BaseApi.postRequest("signin", data: {
        "email": event.email,
        "password": event.passWord,
        "Otp": event.otp
      });
      log("REASONABLE ::$data");
      if (data["message"] == "login successfully") {
        log("USER ID::: ${data["user"]["id"]}");
        log("TOKEN::::${data["token"]}");
        UserPreferences().setUserId(data["user"]["id"]);
        UserPreferences().setToken(data["token"]);
        AppNavigation.shared.moveToBottomNavigationBarScreen();
        emit(AuthBlocLoaded());
      } else {
        errorSnackbar(data["message"]);
        emit(AuthBlocLoaded());
      }
    } catch (e) {
      errorSnackbar(e.toString());
      log(e.toString());
      emit(AuthBlocError());
    }
  }

  _forgotOtpSend(ForgotOtpSend event, Emitter<AuthBlocState> emit) async {
    emit(AuthBlocLoading());
    try {
      Map<String, dynamic> data = await BaseApi.postRequest("forgetotpsent",
          data: {"email": event.email});
      log("REASONABLE ::$data");
      if (data["message"] == "otp sent successfully") {
        Get.to(OTPVarificationScreen(isForgot: true, email: event.email));
        emit(AuthBlocLoaded());
      } else {
        showDialog(
          context: event.context,
          barrierDismissible: false,
          builder: (context) => alertDialog(
            context,
            onPressed: () {
              Navigator.pop(context);
              AppNavigation.shared.moveToRegistrationScreen();
            },
          ),
        );
        emit(AuthBlocLoaded());
      }
    } catch (e) {
      errorSnackbar(e.toString());
      log(e.toString());
      emit(AuthBlocError());
    }
  }

  _verifyForgotOtp(ForgotOtpVerify event, Emitter<AuthBlocState> emit) async {
    emit(AuthBlocLoading());
    try {
      Map<String, dynamic> data = await BaseApi.postRequest("forgetotp",
          data: {"email": event.email, "forgetOtp": event.otp});
      log("REASONABLE ::$data");
      if (data["message"] == "otp match") {
        Get.to(SetPasswordScreen(email: event.email));
        emit(AuthBlocLoaded());
      } else {
        errorSnackbar(data["message"]);
        emit(AuthBlocLoaded());
      }
    } catch (e) {
      errorSnackbar(e.toString());
      log(e.toString());
      emit(AuthBlocError());
    }
  }

  _resetPassword(ResetPassWord event, Emitter<AuthBlocState> emit) async {
    emit(AuthBlocLoading());
    try {
      Map<String, dynamic> data =
          await BaseApi.postRequest("forgetpassword", data: {
        "email": event.email,
        "password": event.password,
        "confirmPassword": event.confirmPassword
      });
      log("REASONABLE ::$data");
      if (data["message"] == "password change successfully") {
        Get.off(const ChangePasswordScreen());
        emit(AuthBlocLoaded());
      } else {
        errorSnackbar(data["message"]);
        emit(AuthBlocLoaded());
      }
    } catch (e) {
      errorSnackbar(e.toString());
      log(e.toString());
      emit(AuthBlocError());
    }
  }
}
