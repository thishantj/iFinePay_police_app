import 'package:flutter/material.dart';
import 'package:ifinepay_police_app/app/components/navigation_bloc.dart';
import 'components/body.dart';

class ScanNumberPlateScreen extends StatefulWidget with NavigationStates{

  static String routeName = "/scan_number_plate";

  @override
  _ScanNumberPlateScreenState createState() => _ScanNumberPlateScreenState();
}

class _ScanNumberPlateScreenState extends State<ScanNumberPlateScreen> {
  @override
  Widget build(BuildContext context) {

    final String licenseNumber = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Scan number plate",
          textAlign: TextAlign.center,
        ),
      ),
      body: ScanNumberPlateBody(args: licenseNumber),
    );
  }
}