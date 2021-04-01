import 'package:flutter/material.dart';
import 'package:ifinepay_police_app/screens/scan_license/components/body.dart';

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