import 'package:flutter/material.dart';
import 'package:ifinepay_police_app/app/components/screenArguments.dart';
import 'package:ifinepay_police_app/app/screens/scan_license/components/body.dart';

import 'components/body.dart';

class LicenseStatusScreen extends StatefulWidget {
  static String routeName = "/license_status";

  @override
  _LicenseStatusScreenState createState() => _LicenseStatusScreenState();
}

class _LicenseStatusScreenState extends State<LicenseStatusScreen> {
  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "License status",
        ),
      ),
      body: LicenseStatusBody(args: args),
    );
  }
}