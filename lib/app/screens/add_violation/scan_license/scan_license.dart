import 'package:flutter/material.dart';
import 'package:ifinepay_police_app/app/components/navigation_bloc.dart';
import 'components/body.dart';

class ScanLicenseScreen extends StatelessWidget with NavigationStates{

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