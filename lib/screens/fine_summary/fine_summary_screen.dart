import 'package:flutter/material.dart';
import 'package:ifinepay_police_app/screens/fine_summary/components/body.dart';

class FineSummary extends StatelessWidget {

  static String routeName = "/fine_summary";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Fine summary",
          textAlign: TextAlign.center,
        ),
      ),
      body: FineSummaryBody(),
    );
  }
}