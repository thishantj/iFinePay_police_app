import 'package:flutter/material.dart';
import '../../../components/navigation_bloc.dart';
import '../../../components/screenArguments.dart';

import 'components/body.dart';

class ViolationsScreen extends StatefulWidget  with NavigationStates{
  static String routeName = "/violations";

  @override
  _ViolationsScreenState createState() => _ViolationsScreenState();
}

class _ViolationsScreenState extends State<ViolationsScreen> {
  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "License status",
        ),
      ),
      body: ViolationsBody(args: args),
    );
  }
}
