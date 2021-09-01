import 'package:flutter/material.dart';
import '/constants.dart';
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
                  style: headingStyle,
                ),
                Text(
                  "Reset your password",
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: displayHeight(context) * 0.1,
                ),
                RecoverPasswordForm(args: args),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
