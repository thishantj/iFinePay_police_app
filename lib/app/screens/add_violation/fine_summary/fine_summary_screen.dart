import 'package:flutter/material.dart';
import 'package:ifinepay_police_app/app/components/navigation_bloc.dart';
import '../../../components/driverFineArguments.dart';
import 'components/body.dart';

class FineSummary extends StatelessWidget with NavigationStates{

  static String routeName = "/fine_summary";

  @override
  Widget build(BuildContext context) {

    final DriverFineArguments args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Fine summary",
          textAlign: TextAlign.center,
        ),
      ),
      body: FineSummaryBody(args: args),
    );
  }
}