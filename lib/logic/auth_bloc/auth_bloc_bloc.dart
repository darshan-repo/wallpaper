import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walper/libs.dart';

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
    on<ResendOtp>(_resendOtp);
    on<Logout>(_logout);
    on<LoginWithGoogle>(_loginWithGoogle);
    on<LoginWithGoogleOtpSend>(_loginWithGoogleOtpVerify);
    on<LoginWithGoogleResendOtp>(_loginWithGoogleResendOtp);
  }

  _userSignUp(UserSignUp event, Emitter<AuthBlocState> emit) async {
    emit(AuthBlocLoading());
    try {
      Map<String, dynamic> data = await BaseApi.postRequest("signup", data: {
        "username": event.name,
        "email": event.email,
        "password": event.passWord
      });
      if (data["message"] == "User created") {
        Get.to(const LoginScreen());
        emit(AuthBlocLoaded());
      } else {
        errorSnackbar(data["message"]);
        emit(AuthBlocLoaded());
      }
    } catch (e) {
      emit(AuthBlocError());
    }
  }

  _loginWithOtp(LoginWithOtp event, Emitter<AuthBlocState> emit) async {
    emit(AuthBlocLoading());
    try {
      Map<String, dynamic> data = await BaseApi.postRequest("signin", data: {
        "email": event.email,
        "password": event.passWord,
        "deviceId": event.fcmToken
      });

      if (data["message"] != null) {
        UserPreferences().setUserId(data["user"]["id"]);
        UserPreferences().setUserEmail(data["user"]["email"]);
        UserPreferences().setDeviceToken(event.fcmToken);
        UserPreferences()
            .setNotificationStatus(data["user"]["notification_enable"] ?? true);

        if (data["user"]["isverified"] == true) {
          Get.offAll(() => const BottomNavigationBarScreen());
        } else {
          Get.to(OTPVarificationScreen(
            isForgot: false,
            email: event.email,
            passWord: event.passWord,
            isGoogle: false,
          ));
        }
        emit(AuthBlocLoaded());
      } else {
        emit(AuthBlocLoaded());
      }
    } catch (e) {
      emit(AuthBlocError());
    }
  }

  _verifyOtp(VerifyOtp event, Emitter<AuthBlocState> emit) async {
    emit(AuthBlocLoading());
    try {
      Map<String, dynamic> data = await BaseApi.postRequest("otpSignin", data: {
        "email": event.email,
        "Otp": event.otp,
        "deviceId": event.fcmToken
      });

      if (data["message"] == "user login successfully") {
        UserPreferences().setUserId(data["user"]["id"]);
        UserPreferences().setUserEmail(data["user"]["email"]);
        UserPreferences().setDeviceToken(event.fcmToken);
        Get.off(const BottomNavigationBarScreen());
        emit(AuthBlocLoaded());
      } else {
        emit(AuthBlocLoaded());
      }
    } catch (e) {
      emit(AuthBlocError());
    }
  }

  _forgotOtpSend(ForgotOtpSend event, Emitter<AuthBlocState> emit) async {
    emit(AuthBlocLoading());
    try {
      Map<String, dynamic> data = await BaseApi.postRequest("forgetotpsent",
          data: {"email": event.email});
      if (data["message"] == "otp sent successfully") {
        Get.to(OTPVarificationScreen(isForgot: true, email: event.email));
        emit(AuthBlocLoaded());
      } else {
        // ignore: use_build_context_synchronously
        showDialog(
          context: event.context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: ColorManager.primaryColor,
            iconPadding: padding(
              paddingType: PaddingType.LTRB,
              left: 0.04.sw,
              right: 0.04.sw,
            ),
            icon: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  ImageAssetManager.emailError,
                  scale: 0.009.sh,
                ),
                horizontalSpace(0.16.sw),
                Container(
                  height: 0.05.sh,
                  width: 0.1.sw,
                  margin: margin(
                    marginType: MarginType.top,
                    marginValue: 0.01.sh,
                  ),
                  decoration: BoxDecoration(
                    color: ColorManager.secondaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.close,
                      color: ColorManager.white,
                    ),
                  ),
                ),
              ],
            ),
            actionsPadding: padding(
              paddingType: PaddingType.all,
              paddingValue: 0.02.sh,
            ),
            content: Text(
              'No Account found registered with your email address',
              textAlign: TextAlign.center,
              style: myTheme.textTheme.labelMedium,
            ),
            elevation: 2,
            shadowColor: ColorManager.white,
            actions: [
              materialButton(
                onPressed: () {
                  Navigator.pop(context);
                  Get.to(() => const RegistrationScreen());
                },
                buttonColor: const Color.fromRGBO(160, 152, 250, 1),
                buttonText: AppString.signUp,
              ),
            ],
          ),
        );
        emit(AuthBlocLoaded());
      }
    } catch (e) {
      emit(AuthBlocError());
    }
  }

  _verifyForgotOtp(ForgotOtpVerify event, Emitter<AuthBlocState> emit) async {
    emit(AuthBlocLoading());
    try {
      Map<String, dynamic> data = await BaseApi.postRequest("forgetotp",
          data: {"email": event.email, "forgetOtp": event.otp});
      if (data["message"] == "otp match") {
        Get.to(SetPasswordScreen(email: event.email));
        emit(AuthBlocLoaded());
      } else {
        errorSnackbar(data["message"]);
        emit(AuthBlocLoaded());
      }
    } catch (e) {
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
      if (data["message"] == "password change successfully") {
        Get.off(const ChangePasswordScreen());
        emit(AuthBlocLoaded());
      } else {
        errorSnackbar(data["message"]);
        emit(AuthBlocLoaded());
      }
    } catch (e) {
      emit(AuthBlocError());
    }
  }

  _resendOtp(ResendOtp event, Emitter<AuthBlocState> emit) async {
    emit(AuthBlocLoading());
    try {
      Map<String, dynamic> data = await BaseApi.postRequest("sentotp",
          data: {"email": event.email, 'password': event.password});
      if (data["message"] == "otp sent successfully") {
        successSnackbar('OTP Resend Successfully.');
        emit(AuthBlocLoaded());
      } else {
        errorSnackbar(data["message"]);
        emit(AuthBlocLoaded());
      }
    } catch (e) {
      emit(AuthBlocError());
    }
  }

  _logout(Logout event, Emitter<AuthBlocState> emit) async {
    emit(AuthBlocLoading());
    try {
      Map<String, dynamic> data =
          await BaseApi.postRequest("singout", data: {"email": event.email});
      if (data["message"] == "user logout successfully") {
        emit(AuthBlocLoaded());
      } else {
        errorSnackbar(data["message"]);
        emit(AuthBlocLoaded());
      }
    } catch (e) {
      emit(AuthBlocError());
    }
  }

  _loginWithGoogle(LoginWithGoogle event, Emitter<AuthBlocState> emit) async {
    emit(AuthBlocLoading());
    try {
      Map<String, dynamic> data =
          await BaseApi.postRequest("socialVerification", data: {
        "email": event.email,
        "username": event.username,
        "deviceId": event.fcmToken
      });
      if (data["message"] != null) {
        if (data["user"]["isverified"] == true) {
          UserPreferences().setUserId(data["user"]["id"]);
          UserPreferences().setUserEmail(data["user"]["email"]);
          UserPreferences().setDeviceToken(event.fcmToken);
          Get.offAll(() => const BottomNavigationBarScreen());
        } else {
          Get.to(() => OTPVarificationScreen(
              isGoogle: true,
              isForgot: false,
              email: event.email,
              username: event.username,
              fcmToken: event.fcmToken));
        }
        emit(AuthBlocLoaded());
      } else {
        emit(AuthBlocLoaded());
      }
    } catch (e, s) {
      log(s.toString());
      emit(AuthBlocError());
    }
  }

  _loginWithGoogleOtpVerify(
      LoginWithGoogleOtpSend event, Emitter<AuthBlocState> emit) async {
    emit(AuthBlocLoading());
    try {
      Map<String, dynamic> data = await BaseApi.postRequest("socialLogin",
          data: {
            "email": event.email,
            "Otp": event.otp,
            "deviceId": event.fcmToken
          });
      if (data["message"] != null) {
        UserPreferences().setUserId(data["user"]["id"]);
        UserPreferences().setUserEmail(data["user"]["email"]);
        UserPreferences()
            .setNotificationStatus(data["user"]["notification_enable"] ?? true);
        UserPreferences().setDeviceToken(event.fcmToken);
        log('=====================>> ${UserPreferences().getDeviceToken()}');
        Get.offAll(const BottomNavigationBarScreen());
        emit(AuthBlocLoaded());
      } else {
        emit(AuthBlocLoaded());
      }
    } catch (e) {
      emit(AuthBlocError());
    }
  }

  _loginWithGoogleResendOtp(
      LoginWithGoogleResendOtp event, Emitter<AuthBlocState> emit) async {
    emit(AuthBlocLoading());
    try {
      Map<String, dynamic> data =
          await BaseApi.postRequest("socialVerification", data: {
        "email": event.email,
        "username": event.username,
        "deviceId": event.fcmToken
      });

      if (data["message"] != null) {
        successSnackbar('OTP Resend Successfully.');
      }
    } catch (e, s) {
      log(s.toString());
      emit(AuthBlocError());
    }
  }
}
