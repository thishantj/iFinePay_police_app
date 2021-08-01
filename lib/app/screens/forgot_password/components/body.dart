import 'package:flutter/material.dart';
import 'package:ifinepay_police_app/app/components/default_button.dart';
import 'package:ifinepay_police_app/app/components/form_error.dart';
import 'package:ifinepay_police_app/app/screens/login/components/custom_suffix_icon.dart';
import 'package:ifinepay_police_app/app/screens/recovery_otp/recovery_otp_screen.dart';
import 'package:ifinepay_police_app/constants.dart';
import 'package:ifinepay_police_app/sizes_helpers.dart';

class ForgotPasswordBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            children: [
              SizedBox(
                height: displayHeight(context) * 0.04,
              ),
              Text(
                "Forgot Password",
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Please enter your user and we will send you a recovery code",
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: displayHeight(context) * 0.1,
              ),
              ForgotPasswordForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class ForgotPasswordForm extends StatefulWidget {
  @override
  _ForgotPasswordFormState createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {

  TextEditingController user = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  List<String> errors = [];
  String telephone;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: user,
            keyboardType: TextInputType.number,
            onSaved: (newValue) => telephone = newValue,
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
              hintStyle: TextStyle(
                fontSize: 13,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSuffixIcon(
                svgIcon: "assets/icons/username.svg",
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          FormError(errors: errors),
          SizedBox(
            height: displayHeight(context) * 0.1,
          ),
          DefaultButton(
            text: "Continue",
            press: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                
                Navigator.pushNamed(context, RecoveryOtpScreen.routeName, arguments: user.text);
              }
            },
          ),
          SizedBox(
            height: displayHeight(context) * 0.1,
          ),
          // NoAccountText(),
        ],
      ),
    );
  }
}
