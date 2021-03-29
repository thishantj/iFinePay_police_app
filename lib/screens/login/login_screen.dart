import 'package:flutter/material.dart';
import 'package:ifinepay_police_app/screens/login/components/body.dart';

class LoginScreen extends StatelessWidget {
  static String routeName = "/login";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: LoginBody(),
      ),
    );
  }
}


