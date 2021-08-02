import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ifinepay_police_app/app/components/customDialog.dart';
import 'package:ifinepay_police_app/app/components/default_button.dart';
import 'package:ifinepay_police_app/app/components/verifyNumberPlateArgument.dart';
import 'package:ifinepay_police_app/app/screens/home_screen/home_screen.dart';
import 'package:ifinepay_police_app/sizes_helpers.dart';

import 'package:http/http.dart' as http;

String numberPlate = "";
var flagged;

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

  Future getVehicleFlagged() async {
    var url = "http://192.168.26.1:444/flutter-crud/readNumberplate.php";
    var response = await http.post(Uri.parse(url), body: {
      "numberPlate": widget.args.numberPlate,
    });

    var data = json.decode(response.body).cast<Map<String, dynamic>>();
    // data.forEach((element) => print(element['status']));
    print("data: " + data[0]['flagged']);

    if (int.parse(data[0]['flagged']) == 1) {
      //CustomAlertDialog();
      //Future.delayed(Duration.zero, () => CustomAlertDialog());
      flagged = true;

      showDialog(
        context: context,
        builder: (context) {
          return CustomAlertDialog();
        },
      );

      print("done");
    }
    // ignore: invalid_use_of_protected_member
    (context as Element).reassemble();
  }

  @override
  void initState() {
    super.initState();
    setDriverDetails(widget.args.numberPlate);
    getVehicleFlagged();
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