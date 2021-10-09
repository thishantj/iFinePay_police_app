import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../components/navigation_bloc.dart';
import '../../../components/user.dart';
import '/constants.dart';
import '/sizes_helpers.dart';

import 'action_card.dart';

class HomeScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: displayHeight(context) * 0.1,
            ),
            Text(
              // "Hi ${args.username}",
              "Hi ${User().getUname()}",
              textAlign: TextAlign.center,
              style: headingStyle,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: 2,
                    mainAxisSpacing: displayHeight(context) * 0.04,
                    crossAxisSpacing: displayWidth(context) * 0.06,
                  ),
                  children: [
                    ActionCard(
                      img: "assets/images/licence.png",
                      title: "Licence check",
                      press: () {
                        BlocProvider.of<NavigationBloc>(context)
                            .add(NavigationEvents.ScanLicenseClickeEvent);
                      },
                    ),
                    ActionCard(
                      img: "assets/images/car.png",
                      title: "Vehicle check",
                      press: () {
                        BlocProvider.of<NavigationBloc>(context)
                            .add(NavigationEvents.ScanNumberPlateClickeEvent);
                      },
                    ),
                    ActionCard(
                      img: "assets/images/add_violation.png",
                      title: "Add fine",
                      press: () {
                        BlocProvider.of<NavigationBloc>(context)
                            .add(NavigationEvents.AddFineClickeEvent);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
