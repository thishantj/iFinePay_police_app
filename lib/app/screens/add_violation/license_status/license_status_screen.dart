import 'package:flutter/material.dart';
import '../../../components/screenArguments.dart';

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
