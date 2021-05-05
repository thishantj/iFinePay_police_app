import 'package:flutter/material.dart';
import 'package:ifinepay_police_app/app/components/default_button.dart';
import 'package:ifinepay_police_app/app/components/form_error.dart';
import 'package:ifinepay_police_app/app/screens/forgot_password/forgot_password_screen.dart';
import 'package:ifinepay_police_app/app/screens/scan_license/scan_license.dart';
import 'package:ifinepay_police_app/constants.dart';

import '../../../../sizes_helpers.dart';
import 'custom_suffix_icon.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String username;
  String password;
  bool remember = false;
  final List<String> errors = [];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildUsernameFormField(),
          SizedBox(
            height: displayHeight(context) * 0.04,
          ),
          buildPasswordFormField(),
          SizedBox(
            height: displayHeight(context) * 0.04,
          ),
          Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: kPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    remember = value;
                  });
                },
              ),
              Text("Remember me"),
              Spacer(),
              GestureDetector(
                onTap: () => Navigator.popAndPushNamed(
                  context,
                  ForgotPasswordScreen.routeName,
                ),
                child: Text(
                  "Forgot password",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
          SizedBox(
            height: displayHeight(context) * 0.03,
          ),
          FormError(errors: errors),
          SizedBox(
            height: displayHeight(context) * 0.02,
          ),
          DefaultButton(
            text: "Login",
            press: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();

                Navigator.pushNamed(context, ScanLicenseScreen.routeName);
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kPassNullError)) {
          setState(() {
            errors.remove(kPassNullError);
          });
        } else if (errors.contains(kShortPassError)) {
          setState(() {
            errors.remove(kShortPassError);
          });
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty && !errors.contains(kPassNullError)) {
          setState(() {
            errors.add(kPassNullError);
          });
          return "";
        }
        else if (value.isEmpty && errors.contains(kPassNullError)) {
          setState(() {
            errors.remove(kShortPassError);
          });
          return "";
        }
        else {
          if (!errors.contains(kShortPassError)) {
            setState(() {
              errors.add(kShortPassError);
            });
            return "";
          }
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        labelStyle: TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
        hintText: "Enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          svgIcon: "assets/icons/password.svg",
        ),
      ),
    );
  }

  TextFormField buildUsernameFormField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      onSaved: (newValue) => username = newValue,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kUsernameNullError)) {
          setState(() {
            errors.remove(kUsernameNullError);
          });
        } else if (errors.contains(kInvalidUsernameError)) {
          setState(() {
            errors.remove(kInvalidUsernameError);
          });
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty && !errors.contains(kUsernameNullError)) {
          setState(() {
            errors.add(kUsernameNullError);
          });
          return "";
        } 
        else if (value.isEmpty && errors.contains(kUsernameNullError)) {
          setState(() {
            errors.remove(kInvalidUsernameError);
          });
          return "";
        }
        else {
          if (!errors.contains(kInvalidUsernameError)) { 
            setState(() {
              errors.add(kInvalidUsernameError);
            });
            return "";
          }
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Username",
        labelStyle: TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
        hintText: "Enter your username",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          svgIcon: "assets/icons/username.svg",
        ),
      ),
    );
  }
}
