import 'package:flutter/material.dart';
import 'package:ifinepay_police_app/sizes_helpers.dart';

import 'recovery_otp_form.dart';

class RecovetyotpBody extends StatelessWidget {

  const RecovetyotpBody({
    Key key,
    @required this.args,
  }) : super(key: key);

  final args;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
                  child: Column(
            children: [
              SizedBox(
                height: displayHeight(context) * 0.04,
              ),
              Text(
                "Recovery OTP",
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Please enter the recovery code received",
                textAlign: TextAlign.center,
              ),
              buildTimer(),
              SizedBox(
                height: displayHeight(context) * 0.15,
              ),
              RecoveryOtpForm(args: args),
              SizedBox(
                height: displayHeight(context) * 0.1,
              ),
              GestureDetector(
                onTap: () {
                  //resend OTP
                },
                child: Text(
                  "Resend OTP code",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "This code will expire in ",
        ),
        TweenAnimationBuilder(
          tween: Tween(begin: 60.0, end: 0),
          duration: Duration(seconds: 60),
          builder: (context, value, child) => Text(
            "00:${value.toInt()}",
            style: TextStyle(
              color: Colors.red[400],
            ),
          ),
          onEnd: () {},
        ),
      ],
    );
  }
}

