import 'package:flutter/material.dart';

const kPrimaryColor = Colors.black;
const kPrimaryLightColor = Colors.white;
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color(0xff418CD1),
    Color(0xff67B6FF),
    Color(0xff8FC2F0),
    Color(0xffFBFDFF)
  ],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Colors.black;

const kAnimationDuration = Duration(milliseconds: 200);

// Form Error
const String kUsernameNullError = "Please enter your username";
const String kInvalidUsernameError = "Username not valid";

const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";

const String kNamelNullError = "Please Enter your name";

const String kPhoneNumberNullError = "Please enter your phone number";

const String kAddressNullError = "Please Enter your address";

final headingStyle = TextStyle(
  color: Colors.black,
  fontSize: 32,
  fontWeight: FontWeight.bold,
);

final otpInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(
    vertical: 15,
  ),
  enabledBorder: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  border: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide(
      color: Colors.grey[300],
    ),
  );
}