import 'package:flutter/material.dart';
import 'package:ifinepay_police_app/app/components/loginArguments.dart';
import 'package:ifinepay_police_app/app/screens/add_violation/scan_license/scan_license.dart';
import 'package:ifinepay_police_app/app/screens/verify_driver_license/verify_license/verify_license.dart';
import 'package:ifinepay_police_app/app/screens/verify_number_plate/verify_vehicle_number/verify_number_plate.dart';
import 'package:ifinepay_police_app/constants.dart';
import 'package:ifinepay_police_app/sizes_helpers.dart';

import 'action_card.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({
    Key key,
    @required this.args,
  }) : super(key: key);

  final LoginArguments args;

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
              "Hi ${args.username}",
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
                      press: () => Navigator.pushNamed(
                        context,
                        VerifyLicenseScreen.routeName,
                      ),
                    ),
                    ActionCard(
                      img: "assets/images/car.png",
                      title: "Vehicle check",
                      press: () => Navigator.pushNamed(
                        context,
                        VerifyNumberPlateScreen.routeName,
                      ),
                    ),
                    ActionCard(
                      img: "assets/images/add_violation.png",
                      title: "Add fine",
                      press: () => Navigator.pushNamed(
                        context,
                        ScanLicenseScreen.routeName,
                      ),
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
