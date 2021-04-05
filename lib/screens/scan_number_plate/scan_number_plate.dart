import 'package:flutter/material.dart';
import 'package:ifinepay_police_app/screens/scan_number_plate/components/body.dart';

class ScanNumberPlateScreen extends StatelessWidget {

  static String routeName = "/scan_number_plate";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Scan number plate",
          textAlign: TextAlign.center,
        ),
      ),
      body: ScanNumberPlateBody(),
    );
  }
}