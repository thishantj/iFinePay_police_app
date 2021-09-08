import 'package:flutter/material.dart';
import '../../../components/navigation_bloc.dart';
import '../../../components/verifyNumberPlateArgument.dart';
import 'components/body.dart';

class VehicleDetails extends StatelessWidget  with NavigationStates{

  static String routeName = "/vehicle_details";

  @override
  Widget build(BuildContext context) {

    final VerifyNumberPlateArguments args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Vehicle details",
          textAlign: TextAlign.center,
        ),
      ),
      body: VehicleDetailsBody(args: args),
    );
  }
}