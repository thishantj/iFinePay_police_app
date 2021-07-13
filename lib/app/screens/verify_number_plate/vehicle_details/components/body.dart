import 'package:flutter/material.dart';
import 'package:ifinepay_police_app/app/components/default_button.dart';
import 'package:ifinepay_police_app/app/components/verifyNumberPlateArgument.dart';
import 'package:ifinepay_police_app/app/screens/home_screen/home_screen.dart';
import 'package:ifinepay_police_app/sizes_helpers.dart';

String numberPlate = "";

class VehicleDetailsBody extends StatefulWidget {
  const VehicleDetailsBody({
    Key key,
    @required this.args,
  }) : super(key: key);

  final VerifyNumberPlateArguments args;

  @override
  _VehicleDetailsBodyState createState() => _VehicleDetailsBodyState();
}

class _VehicleDetailsBodyState extends State<VehicleDetailsBody> {

  @override
  void initState() {
    super.initState();
    setDriverDetails(widget.args.numberPlate);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            SizedBox(
              height: displayHeight(context) * 0.04,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Number plate:",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  width: displayWidth(context) * 0.035,
                ),
                Text(
                  numberPlate,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: displayHeight(context) * 0.035,
            ),
            DefaultButton(
              text: "Home",
              press: () {
                Navigator.pushNamed(context, HomeScreen.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }

  void setDriverDetails(String numP) {
    print("number plate: " + numP);
    String t1 = numP.replaceAll(RegExp(r'\n'), ' ');

    numberPlate = t1;
  }
}