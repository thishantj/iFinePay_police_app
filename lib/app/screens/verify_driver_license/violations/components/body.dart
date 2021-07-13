import 'package:flutter/material.dart';
import 'package:ifinepay_police_app/app/components/default_button.dart';
import 'package:ifinepay_police_app/app/components/screenArguments.dart';
import 'package:ifinepay_police_app/app/screens/home_screen/home_screen.dart';
import 'package:ifinepay_police_app/sizes_helpers.dart';

import 'LicenseImageTile.dart';
import 'violation_list_record.dart';

class ViolationsBody extends StatelessWidget {
  const ViolationsBody({
    Key key,
    @required this.args,
  }) : super(key: key);

  final ScreenArguments args;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: displayHeight(context) * 0.3,
            child: LicenseImageTile(args: args.image),
          ),
          SizedBox(
            height: displayHeight(context) * 0.04,
          ),
          SizedBox(
            height: displayHeight(context) * 0.04,
          ),
          Text(
            "Violations",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                ViolationListRecord(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: DefaultButton(
              text: "Home",
              press: () {
                  Navigator.pushNamed(context, HomeScreen.routeName);
              },
            ),
          ),
          SizedBox(
            height: displayHeight(context) * 0.02,
          ),
        ],
      ),
    );
  }
}
