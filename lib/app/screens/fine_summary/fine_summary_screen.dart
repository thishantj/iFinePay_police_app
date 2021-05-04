import 'package:flutter/material.dart';
import 'components/body.dart';

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