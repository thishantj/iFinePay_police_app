import 'package:flutter/material.dart';
import '../../../components/form_error.dart';
import '../../../components/default_button.dart';
import '../../../screens/reset_password/reset_password.dart';
import '/constants.dart';
import '/sizes_helpers.dart';

class RecoveryOtpForm extends StatefulWidget {
  const RecoveryOtpForm({
    Key key,
    @required this.args,
  }) : super(key: key);

  final args;

  @override
  _RecoveryOtpFormState createState() => _RecoveryOtpFormState();
}

class _RecoveryOtpFormState extends State<RecoveryOtpForm> {
  FocusNode pin2FocusNode;
  FocusNode pin3FocusNode;
  FocusNode pin4FocusNode;
  List<String> errors = [];
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
  }

  @override
  void dispose() {
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
    super.dispose();
  }

  void nextField({String value, FocusNode focusNode}) {
    if (value.length == 1) {
      focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: displayWidth(context) * 0.15,
                height: displayHeight(context) * 0.1,
                child: TextFormField(
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    fontSize: displayWidth(context) * 0.08,
                  ),
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    if (value.isNotEmpty && errors.contains(kOTPNullError)) {
                      setState(() {
                        errors.remove(kOTPNullError);
                        nextField(value: value, focusNode: pin2FocusNode);
                      });
                    }
                    else if(value.isNotEmpty && !errors.contains(kOTPNullError))
                    {
                      setState(() {
                        nextField(value: value, focusNode: pin2FocusNode);
                      });
                    }
                    return null;
                  },
                  validator: (value) {
                    if (value.isEmpty && !errors.contains(kOTPNullError)) {
                      setState(() {
                        errors.add(kOTPNullError);
                      });
                      return "";
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                width: displayWidth(context) * 0.15,
                height: displayHeight(context) * 0.1,
                child: TextFormField(
                  focusNode: pin2FocusNode,
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    fontSize: displayWidth(context) * 0.08,
                  ),
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    if (value.isNotEmpty && errors.contains(kOTPNullError)) {
                      setState(() {
                        errors.remove(kOTPNullError);
                        nextField(value: value, focusNode: pin3FocusNode);
                      });
                    }
                    else if(value.isNotEmpty && !errors.contains(kOTPNullError))
                    {
                      setState(() {
                        nextField(value: value, focusNode: pin3FocusNode);
                      });
                    }
                    return null;
                  },
                  validator: (value) {
                    if (value.isEmpty && !errors.contains(kOTPNullError)) {
                      setState(() {
                        errors.add(kOTPNullError);
                      });
                      return "";
                    } 
                    return null;
                  },
                ),
              ),
              SizedBox(
                width: displayWidth(context) * 0.15,
                height: displayHeight(context) * 0.1,
                child: TextFormField(
                  focusNode: pin3FocusNode,
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    fontSize: displayWidth(context) * 0.08,
                  ),
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    if (value.isNotEmpty && errors.contains(kOTPNullError)) {
                      setState(() {
                        errors.remove(kOTPNullError);
                        nextField(value: value, focusNode: pin4FocusNode);
                      });
                    }
                    else if(value.isNotEmpty && !errors.contains(kOTPNullError))
                    {
                      setState(() {
                        nextField(value: value, focusNode: pin4FocusNode);
                      });
                    }
                    return null;
                  },
                  validator: (value) {
                    if (value.isEmpty && !errors.contains(kOTPNullError)) {
                      setState(() {
                        errors.add(kOTPNullError);
                      });
                      return "";
                    } 
                    return null;
                  },
                ),
              ),
              SizedBox(
                width: displayWidth(context) * 0.15,
                height: displayHeight(context) * 0.1,
                child: TextFormField(
                  focusNode: pin4FocusNode,
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    fontSize: displayWidth(context) * 0.08,
                  ),
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    if (value.isNotEmpty && errors.contains(kOTPNullError)) {
                      setState(() {
                        errors.remove(kOTPNullError);
                        pin4FocusNode.unfocus();
                      });
                    }
                    else if(value.isNotEmpty && !errors.contains(kOTPNullError))
                    {
                      setState(() {
                        pin4FocusNode.unfocus();
                      });
                    }
                    return null;
                  },
                  validator: (value) {
                    if (value.isEmpty && !errors.contains(kOTPNullError)) {
                      setState(() {
                        errors.add(kOTPNullError);
                      });
                      return "";
                    } 
                    return null;
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: displayHeight(context) * 0.04,
          ),
          FormError(errors: errors),
          SizedBox(
            height: displayHeight(context) * 0.04,
          ),
          DefaultButton(
            text: "Continue",
            press: () {
              if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  
                  Navigator.pushNamed(context, ResetPasswordScreen.routeName,
                  arguments: widget.args);
                }
            },
          ),
        ],
      ),
    );
  }
}
