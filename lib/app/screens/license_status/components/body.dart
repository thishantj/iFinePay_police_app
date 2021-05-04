import 'package:flutter/material.dart';
import 'package:ifinepay_police_app/app/components/screenArguments.dart';
import 'package:ifinepay_police_app/app/screens/scan_number_plate/scan_number_plate.dart';
import 'package:ifinepay_police_app/sizes_helpers.dart';

import 'LicenseImageTile.dart';
import 'violation_list_record.dart';

class LicenseStatusBody extends StatelessWidget {
  const LicenseStatusBody({
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
            height: displayHeight(context) * 0.08,
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
                ViolationListRecord(),
              ],
            ),
          ),
          Container(
            alignment: Alignment.bottomRight,
            padding: EdgeInsets.only(
              right: 20,
            ),
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, ScanNumberPlateScreen.routeName);
              },
              child: Icon(
                Icons.add,
              ),
              elevation: 10,
              backgroundColor: Colors.black,
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