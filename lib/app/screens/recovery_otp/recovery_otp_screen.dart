import 'package:flutter/material.dart';
import 'components/body.dart';

class RecoveryOtpScreen extends StatelessWidget {
  
  static String routeName = "/recovery_otp";

  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context).settings.arguments;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Recovery OTP",
          textAlign: TextAlign.center,
        ),
      ),
      body: RecovetyotpBody(args: args),
    );
  }
}