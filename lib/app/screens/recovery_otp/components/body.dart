import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import '../../../components/customDialog.dart';
import '../../../components/dbConnection.dart';
import '/sizes_helpers.dart';

import 'recovery_otp_form.dart';
import 'package:http/http.dart' as http;

int numberEnd;

class RecovetyotpBody extends StatefulWidget {
  const RecovetyotpBody({
    Key key,
    @required this.args,
  }) : super(key: key);

  final args;

  @override
  _RecovetyotpBodyState createState() => _RecovetyotpBodyState();
}

class _RecovetyotpBodyState extends State<RecovetyotpBody> {
  @override
  void initState() {
    super.initState();
    getDriverPhoneNumber();
  }

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
                  fontSize: displayWidth(context) * 0.08,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: displayHeight(context) * 0.03,
              ),
              Text(
                "Please enter the recovery code received to your number ending with *******" +
                    numberEnd.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: displayWidth(context) * 0.035,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(
                height: displayHeight(context) * 0.05,
              ),
              buildTimer(context),
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
                child: RecoveryOtpForm(args: widget.args),
              ),
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
                    fontSize: displayWidth(context) * 0.04,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future getDriverPhoneNumber() async {
    try {
      var url = DBConnect().conn + "/readPolicePhoneNumber.php";
      var response = await http.post(Uri.parse(url), body: {
        "username": widget.args,
      });

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print("data: " +data);
        getNumberEnd(data);
        
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return CustomAlertDialog(
              alertHeading: "Warning !",
              alertBody: "Server error. Please try again !",
              alertButtonColour: Colors.red,
              alertButtonText: "Ok",
              alertAvatarBgColour: Colors.redAccent,
              alertAvatarColour: Colors.white,
              alertAvatarIcon: Icons.error,
              buttonPress: () => {Navigator.of(context).pop()},
            );
          },
        );
      }
    } on SocketException catch (e) {
      print('Socket Error: $e');
      showDialog(
        context: context,
        builder: (context) {
          return CustomAlertDialog(
            alertHeading: "Warning !",
            alertBody: "No internet. Please check your connectivity !",
            alertButtonColour: Colors.red,
            alertButtonText: "Ok",
            alertAvatarBgColour: Colors.redAccent,
            alertAvatarColour: Colors.white,
            alertAvatarIcon: Icons.error,
            buttonPress: () => {Navigator.of(context).pop()},
          );
        },
      );
    } 
  }

  void getNumberEnd(var data)
  {
    setState(() {
      numberEnd = int.parse(data.substring(data.length - 3));
    });
    
  }
}

Row buildTimer(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        "This code will expire in ",
        style: TextStyle(
          fontSize: displayWidth(context) * 0.04,
          color: Colors.black45,
        ),
      ),
      TweenAnimationBuilder(
        tween: Tween(begin: 60.0, end: 0),
        duration: Duration(seconds: 60),
        builder: (context, value, child) => Text(
          "00:${value.toInt()}",
          style: TextStyle(
            color: Colors.red[400],
            fontSize: displayWidth(context) * 0.045,
          ),
        ),
        onEnd: () {},
      ),
    ],
  );
}
