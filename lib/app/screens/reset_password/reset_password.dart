import 'package:flutter/material.dart';
import 'components/body.dart';

class ResetPasswordScreen extends StatelessWidget {

  static String routeName = "/reset_password";

  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Reset password",
          textAlign: TextAlign.center,
        ),
      ),
      body: ResetPasswordBody(args: args),
    );
  }
}