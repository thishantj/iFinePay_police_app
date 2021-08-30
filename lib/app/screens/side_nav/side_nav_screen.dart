import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifinepay_police_app/app/components/navigation_bloc.dart';
import 'package:ifinepay_police_app/app/screens/home_screen/home_screen.dart';

import 'components/side_nav_body.dart';

class SideNavScreen extends StatelessWidget {
  static String routeName = "/sideNavScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<NavigationBloc>(
        create: (context) => NavigationBloc(HomeScreen()),
        child: Stack(
          children: [
            BlocBuilder<NavigationBloc, NavigationStates>(
              builder: (context, navigationState){
                return navigationState as Widget;
              },
            ),
            SideNavBody(),
          ],
        ),
      ),
    );
  }
}
