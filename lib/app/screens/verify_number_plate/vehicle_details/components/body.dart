import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../components/navigation_bloc.dart';
import '../../../../components/customDialog.dart';
import '../../../../components/dbConnection.dart';
import '../../../../components/default_button.dart';
import '../../../../components/verifyNumberPlateArgument.dart';
import '/sizes_helpers.dart';

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
    var url = DBConnect().conn + "/readNumberplate.php";
    var response = await http.post(Uri.parse(url), body: {
      "numberPlate": widget.args.numberPlate,
    });

    var data = json.decode(response.body).cast<Map<String, dynamic>>();

    print("data: " + data[0]['flagged']);

    if (int.parse(data[0]['flagged']) == 1) {
      flagged = true;

      showDialog(
        context: context,
        builder: (context) {
          return CustomAlertDialog(
            alertHeading: "Warning !",
            alertBody: "This vehicle is flagged",
            alertButtonColour: Colors.red,
            alertButtonText: "Ok",
            alertAvatarBgColour: Colors.redAccent,
            alertAvatarColour: Colors.white,
            alertAvatarIcon: Icons.warning_amber_rounded,
            buttonPress: () => {Navigator.of(context).pop()},
          );
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
                BlocProvider.of<NavigationBloc>(context)
                            .add(NavigationEvents.ScanLicenseClickeEvent);
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
