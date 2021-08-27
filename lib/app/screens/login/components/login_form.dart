import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ifinepay_police_app/app/components/dbConnection.dart';
import 'package:ifinepay_police_app/app/components/default_button.dart';
import 'package:ifinepay_police_app/app/components/form_error.dart';
import 'package:ifinepay_police_app/app/components/loginArguments.dart';
import 'package:ifinepay_police_app/app/screens/forgot_password/forgot_password_screen.dart';
import 'package:ifinepay_police_app/app/screens/home_screen/home_screen.dart';
import 'package:ifinepay_police_app/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../sizes_helpers.dart';
import 'custom_suffix_icon.dart';
import 'package:http/http.dart' as http;

int finalUser;

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();

  Future login() async {
    var url = DBConnect().conn+"/login.php";
    var response = await http.post(Uri.parse(url), body: {
      "username": user.text,
      "password": pass.text,
    });

    print(response.body);
    var data = json.decode(response.body);

    if (data == "Success") {
      
      if (remember == true) {
        final SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setInt("user", int.parse(username));

        LoginArguments la = new LoginArguments(username);

        Navigator.pushNamed(context, HomeScreen.routeName, arguments: la);
      } else {
        LoginArguments la = new LoginArguments(username);

        Navigator.pushNamed(context, HomeScreen.routeName, arguments: la);
      }
    } else {
      Fluttertoast.showToast(
        msg: "Incorrect username or password",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 12,
      );
    }
  }

  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedUser = sharedPreferences.getInt("user");

    setState(() {
      finalUser = obtainedUser;
    });
  }

  final _formKey = GlobalKey<FormState>();
  String username;
  String password;
  bool remember = false;
  final List<String> errors = [];

  @override
  void initState() {
    super.initState();
    getValidationData().whenComplete(() async {
      if (finalUser != null) {
        LoginArguments la = new LoginArguments(finalUser.toString());

        Navigator.pushNamed(context, HomeScreen.routeName, arguments: la);
      }
    });
  }

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

                login();
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
      controller: pass,
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
        } else if (value.isEmpty && errors.contains(kPassNullError)) {
          setState(() {
            errors.remove(kShortPassError);
          });
          return "";
        }
        // else {
        //   if (!errors.contains(kShortPassError)) {
        //     setState(() {
        //       errors.add(kShortPassError);
        //     });
        //     return "";
        //   }
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

  TextFormField buildUsernameFormField() {
    return TextFormField(
      controller: user,
      keyboardType: TextInputType.number,
      onSaved: (newValue) => username = newValue,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kUsernameNullError)) {
          setState(() {
            errors.remove(kUsernameNullError);
          });
        }
        // else if (errors.contains(kInvalidUsernameError)) {
        //   setState(() {
        //     errors.remove(kInvalidUsernameError);
        //   });
        // }
        return null;
      },
      validator: (value) {
        if (value.isEmpty && !errors.contains(kUsernameNullError)) {
          setState(() {
            errors.add(kUsernameNullError);
          });
          return "";
        } else if (value.isEmpty && errors.contains(kUsernameNullError)) {
          setState(() {
            errors.remove(kInvalidUsernameError);
          });
          return "";
        }
        // else {
        //   if (!errors.contains(kInvalidUsernameError)) {
        //     setState(() {
        //       errors.add(kInvalidUsernameError);
        //     });
        //     return "";
        //   }
        // }
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
