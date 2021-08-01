import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ifinepay_police_app/app/components/default_button.dart';
import 'package:ifinepay_police_app/app/components/form_error.dart';
import 'package:ifinepay_police_app/app/screens/login/components/custom_suffix_icon.dart';
import 'package:ifinepay_police_app/app/screens/login/login_screen.dart';
import 'package:ifinepay_police_app/constants.dart';

import 'package:http/http.dart' as http;

class RecoverPasswordForm extends StatefulWidget {

  const RecoverPasswordForm({
    Key key,
    @required this.args,
  }) : super(key: key);

  final args;

  @override
  _RecoverPasswordFormState createState() => _RecoverPasswordFormState();
}

class _RecoverPasswordFormState extends State<RecoverPasswordForm> {
  TextEditingController pass = TextEditingController();
  TextEditingController retypePass = TextEditingController();

  Future resetPassword() async {
    if (pass.text == retypePass.text) {
      var url = "http://192.168.26.1:444/flutter-crud/resetPassword.php";
      var response = await http.post(Uri.parse(url), body: {
        "username": widget.args,
        "password": pass.text,
      });

      var data = json.decode(response.body);

      if (data == "Success") {

        Navigator.pushNamed(context, LoginScreen.routeName);
      } else {
        Fluttertoast.showToast(
          msg: "Unable to reset password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 12,
        );


      }
    }
    else
    {
      pass.clear();
      retypePass.clear();

      Fluttertoast.showToast(
          msg: "Passwords do not match",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 12,
        );
    }
  }

  final _formKey = GlobalKey<FormState>();
  String retypePassword;
  String password;
  final List<String> errors = [];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildPasswordFormField(),
          SizedBox(
            height: 40,
          ),
          buildRetypePasswordFormField(),
          SizedBox(
            height: 40,
          ),
          FormError(errors: errors),
          SizedBox(
            height: 40,
          ),
          DefaultButton(
            text: "Reset",
            press: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();

                resetPassword();
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      controller: pass,
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kPassNullError)) {
          setState(() {
            errors.remove(kPassNullError);
          });
        }
        // else if (errors.contains(kShortPassError)) {
        //   setState(() {
        //     errors.remove(kShortPassError);
        //   });
        // }
        return null;
      },
      validator: (value) {
        if (value.isEmpty && !errors.contains(kPassNullError)) {
          setState(() {
            errors.add(kPassNullError);
          });
          return "";
        }
        // else if (!errors.contains(kShortPassError)) {
        //   setState(() {
        //     errors.add(kShortPassError);
        //   });
        //   return "";
        // }
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

  TextFormField buildRetypePasswordFormField() {
    return TextFormField(
      controller: retypePass,
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kPassNullError)) {
          setState(() {
            errors.remove(kPassNullError);
          });
        }
        // else if (errors.contains(kShortPassError)) {
        //   setState(() {
        //     errors.remove(kShortPassError);
        //   });
        // }
        return null;
      },
      validator: (value) {
        if (value.isEmpty && !errors.contains(kPassNullError)) {
          setState(() {
            errors.add(kPassNullError);
          });
          return "";
        }
        // else if (!errors.contains(kShortPassError)) {
        //   setState(() {
        //     errors.add(kShortPassError);
        //   });
        //   return "";
        // }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Retype password",
        labelStyle: TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
        hintText: "Re-enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          svgIcon: "assets/icons/password.svg",
        ),
      ),
    );
  }
}
