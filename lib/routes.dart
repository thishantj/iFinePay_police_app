import 'package:flutter/widgets.dart';
import 'app/screens/fine_summary/fine_summary_screen.dart';
import 'app/screens/forgot_password/forgot_password_screen.dart';
import 'app/screens/license_status/license_status_screen.dart';
import 'app/screens/login/login_screen.dart';
import 'app/screens/recovery_otp/recovery_otp_screen.dart';
import 'app/screens/reset_password/reset_password.dart';
import 'app/screens/scan_license/scan_license.dart';
import 'app/screens/scan_number_plate/scan_number_plate.dart';



final Map<String, WidgetBuilder> routes = {
  LoginScreen.routeName: (context) => LoginScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  RecoveryOtpScreen.routeName: (context) => RecoveryOtpScreen(),
  ResetPasswordScreen.routeName: (context) => ResetPasswordScreen(),
  ScanLicenseScreen.routeName: (context) => ScanLicenseScreen(),
  LicenseStatusScreen.routeName: (context) => LicenseStatusScreen(),
  ScanNumberPlateScreen.routeName: (context) => ScanNumberPlateScreen(),
  FineSummary.routeName: (context) => FineSummary(),
};