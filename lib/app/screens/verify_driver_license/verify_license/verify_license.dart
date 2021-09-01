import 'package:flutter/material.dart';
import '../../../components/navigation_bloc.dart';
import 'components/body.dart';

class VerifyLicenseScreen extends StatelessWidget with NavigationStates{

  static String routeName = "/verify_license";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Verify license",
          textAlign: TextAlign.center,
        ),
      ),
      body: VerifyLicenseBody(),
    );
  }
}