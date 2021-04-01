import 'package:flutter/material.dart';
import 'package:ifinepay_police_app/screens/license_status/components/body.dart';

class LicenseStatusScreen extends StatelessWidget {
  static String routeName = "/license_status";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "License status",
        ),
      ),
      body: LicenseStatusBody(),
    );
  }
}
