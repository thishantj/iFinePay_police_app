import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../components/customDialog.dart';
import '../../../components/user.dart';
import '../../../components/dbConnection.dart';
import '../../../components/default_button.dart';
import '../../../components/form_error.dart';
import '../../forgot_password/forgot_password_screen.dart';
import '../../side_nav/side_nav_screen.dart';
import '/constants.dart';
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
    try {
      var url = DBConnect().conn + "/login.php";
      var response = await http.post(Uri.parse(url), body: {
        "username": user.text,
        "password": pass.text,
      });

      Navigator.of(context).pop(); // show dialog closing

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        if (data == "Success") {
          User user = new User();
          user.setUname(int.parse(username));

          if (remember == true) {
            final SharedPreferences sharedPreferences =
                await SharedPreferences.getInstance();
            sharedPreferences.setInt("user", int.parse(username));

            Navigator.pushNamed(context, SideNavScreen.routeName);
          } else {
            Navigator.pushNamed(context, SideNavScreen.routeName);
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
    } on Error catch (e) {
      print('General Error: $e');
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
  bool remember = true;
  final List<String> errors = [];

  @override
  void initState() {
    super.initState();
    getValidationData().whenComplete(() async {
      if (finalUser != null) {
        Navigator.pushNamed(context, SideNavScreen.routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          displayWidth(context) * 0.05,
          0,
          displayWidth(context) * 0.05,
          0,
        ),
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
                Text(
                  "Remember me",
                  style: TextStyle(
                    fontSize: displayWidth(context) * 0.035,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () => Navigator.popAndPushNamed(
                    context,
                    ForgotPasswordScreen.routeName,
                  ),
                  child: Text(
                    "Forgot password",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: displayWidth(context) * 0.035,
                    ),
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
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      });
                  login();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      style: TextStyle(
        fontSize: displayWidth(context) * 0.045,
      ),
      obscureText: true,
      controller: pass,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kPassNullError)) {
          setState(() {
            errors.remove(kPassNullError);
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
        } else if (value.isEmpty && errors.contains(kPassNullError)) {
          setState(() {
            errors.remove(kShortPassError);
          });
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        labelStyle: TextStyle(
          fontSize: displayWidth(context) * 0.04,
          color: Colors.grey[700],
        ),
        hintText: "Enter password",
        hintStyle: TextStyle(
          fontSize: displayWidth(context) * 0.03,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          svgIcon: "assets/icons/password.svg",
        ),
      ),
    );
  }

  TextFormField buildUsernameFormField() {
    return TextFormField(
      style: TextStyle(
        fontSize: displayWidth(context) * 0.045,
      ),
      controller: user,
      keyboardType: TextInputType.number,
      onSaved: (newValue) => username = newValue,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kUsernameNullError)) {
          setState(() {
            errors.remove(kUsernameNullError);
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
        } else if (value.isEmpty && errors.contains(kUsernameNullError)) {
          setState(() {
            errors.remove(kInvalidUsernameError);
          });
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Username",
        labelStyle: TextStyle(
          fontSize: displayWidth(context) * 0.04,
          color: Colors.grey[700],
        ),
        hintText: "Enter username",
        hintStyle: TextStyle(
          fontSize: displayWidth(context) * 0.03,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          svgIcon: "assets/icons/username.svg",
        ),
      ),
    );
  }
}
