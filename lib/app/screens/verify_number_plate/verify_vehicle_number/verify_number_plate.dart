import 'package:flutter/material.dart';
import 'package:ifinepay_police_app/app/components/navigation_bloc.dart';
import 'components/body.dart';

class VerifyNumberPlateScreen extends StatefulWidget with NavigationStates{

  static String routeName = "/verify_number_plate";

  @override
  _VerifyNumberPlateScreenState createState() => _VerifyNumberPlateScreenState();
}

class _VerifyNumberPlateScreenState extends State<VerifyNumberPlateScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Scan number plate",
          textAlign: TextAlign.center,
        ),
      ),
      body: VerifyNumberPlateBody(),
    );
  }
}