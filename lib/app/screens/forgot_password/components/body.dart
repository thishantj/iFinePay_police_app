import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../components/default_button.dart';
import '../../../components/form_error.dart';
import '../../../screens/login/components/custom_suffix_icon.dart';
import '../../../screens/recovery_otp/recovery_otp_screen.dart';
import '/constants.dart';
import '/sizes_helpers.dart';

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
                height: displayHeight(context) * 0.05,
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
      child: Padding(
        padding: EdgeInsets.only(
          left: displayWidth(context) * 0.05,
          right: displayWidth(context) * 0.05,
        ),
        child: Column(
          children: [
            SvgPicture.asset(
              'assets/images/forgot_pasword.svg',
              height: displayHeight(context) * 0.25,
              width: displayWidth(context) * 0.25,
            ),
            SizedBox(
              height: displayHeight(context) * 0.05,
            ),
            TextFormField(
              style: TextStyle(
                fontSize: displayWidth(context) * 0.045,
              ),
              controller: user,
              keyboardType: TextInputType.number,
              onSaved: (newValue) => telephone = newValue,
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
                } else if (value.isEmpty &&
                    errors.contains(kUsernameNullError)) {
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
                  color: Colors.black,
                ),
                hintText: "Enter your username",
                hintStyle: TextStyle(
                  fontSize: displayWidth(context) * 0.03,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixIcon: CustomSuffixIcon(
                  svgIcon: "assets/icons/username.svg",
                ),
              ),
            ),
            SizedBox(
              height: displayHeight(context) * 0.02,
            ),
            FormError(errors: errors),
            SizedBox(
              height: displayHeight(context) * 0.06,
            ),
            DefaultButton(
              text: "Continue",
              press: () {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();

                  Navigator.pushNamed(context, RecoveryOtpScreen.routeName,
                      arguments: user.text);
                }
              },
            ),
            SizedBox(
              height: displayHeight(context) * 0.1,
            ),
            // NoAccountText(),
          ],
        ),
      ),
    );
  }
}
