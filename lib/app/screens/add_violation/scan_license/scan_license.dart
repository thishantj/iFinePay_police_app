import 'package:flutter/material.dart';
import 'components/body.dart';

class ScanLicenseScreen extends StatelessWidget {

  static String routeName = "/scan_license";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Scan license",
          textAlign: TextAlign.center,
        ),
      ),
      body: ScanLicenseBody(),
    );
  }
}