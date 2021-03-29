import 'package:flutter/material.dart';
import 'package:ifinepay_police_app/screens/forgot_password/components/body.dart';

class ForgotPasswordScreen extends StatelessWidget {

  static String routeName = "/forgot_password";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text(
        //   "Forgot password",
        // ),
      ),
      body: ForgotPasswordBody(),
    );
  }
}