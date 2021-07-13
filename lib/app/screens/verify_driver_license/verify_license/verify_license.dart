import 'package:flutter/material.dart';
import 'components/body.dart';

class VerifyLicenseScreen extends StatelessWidget {

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