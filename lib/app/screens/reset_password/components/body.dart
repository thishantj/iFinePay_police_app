import 'package:flutter/material.dart';
import '/sizes_helpers.dart';

import 'reset_password_form.dart';

class ResetPasswordBody extends StatelessWidget {
  const ResetPasswordBody({
    Key key,
    @required this.args,
  }) : super(key: key);

  final args;

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
                SizedBox(
                  height: displayHeight(context) * 0.05,
                ),
                Text(
                  "Reset password",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: displayWidth(context) * 0.08,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: displayHeight(context) * 0.02,
                ),
                Text(
                  "Reset your password",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: displayWidth(context) * 0.04,
                  ),
                ),
                SizedBox(
                  height: displayHeight(context) * 0.1,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    displayWidth(context) * 0.05,
                    0,
                    displayWidth(context) * 0.05,
                    0,
                  ),
                  child: RecoverPasswordForm(args: args),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
