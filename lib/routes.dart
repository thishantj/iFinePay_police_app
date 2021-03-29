import 'package:flutter/widgets.dart';
import 'package:ifinepay_police_app/screens/forgot_password/forgot_password_screen.dart';
import 'package:ifinepay_police_app/screens/login/login_screen.dart';
import 'package:ifinepay_police_app/screens/recovery_otp/recovery_otp_screen.dart';
import 'package:ifinepay_police_app/screens/reset_password/reset_password.dart';



final Map<String, WidgetBuilder> routes = {
  LoginScreen.routeName: (context) => LoginScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  RecoveryOtpScreen.routeName: (context) => RecoveryOtpScreen(),
  ResetPasswordScreen.routeName: (context) => ResetPasswordScreen(),
};