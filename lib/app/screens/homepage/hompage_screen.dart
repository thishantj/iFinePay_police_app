import 'package:flutter/material.dart';

import 'components/body.dart';

class HomePageScreen extends StatelessWidget {

  static String routeName = "/scan_license";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home page",
          textAlign: TextAlign.center,
        ),
      ),
      body: HomePageBody(),
    );
  }
}