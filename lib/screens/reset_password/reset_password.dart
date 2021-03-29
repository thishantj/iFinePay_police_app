import 'package:flutter/material.dart';
import 'package:ifinepay_police_app/screens/reset_password/components/body.dart';

class ResetPasswordScreen extends StatelessWidget {

  static String routeName = "/reset_password";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Reset password",
          textAlign: TextAlign.center,
        ),
      ),
      body: ResetPasswordBody(),
    );
  }
}