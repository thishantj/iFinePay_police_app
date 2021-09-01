import 'package:flutter/material.dart';
import '../../components/navigation_bloc.dart';

import 'components/body.dart';

class HomeScreen extends StatelessWidget with NavigationStates {
  static String routeName = "/home";

  @override
  Widget build(BuildContext context) {

    //final LoginArguments args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: HomeScreenBody(),
    );
  }
}