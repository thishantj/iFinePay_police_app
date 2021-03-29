import 'package:flutter/material.dart';
import 'package:ifinepay_police_app/screens/recovery_otp/components/body.dart';

class RecoveryOtpScreen extends StatelessWidget {
  
  static String routeName = "/recovery_otp";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Recovery OTP",
          textAlign: TextAlign.center,
        ),
      ),
      body: RecovetyotpBody(),
    );
  }
}