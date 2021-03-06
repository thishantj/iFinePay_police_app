import 'package:flutter/material.dart';
import '/sizes_helpers.dart';

import 'login_form.dart';

class LoginBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: displayHeight(context) * 0.08),
                  Text(
                    "Welcome",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: displayWidth(context) * 0.1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Sign in with your username and password",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: displayWidth(context) * 0.03,
                    ),
                  ),
                  SizedBox(height: displayHeight(context) * 0.13),
                  LoginForm(),
                  SizedBox(height: displayHeight(context) * 0.1),
                  // NoAccountText(),
                ],
              ),
            ),
          )),
    );
  }
}

