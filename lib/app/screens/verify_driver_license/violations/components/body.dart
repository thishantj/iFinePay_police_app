import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../components/customDialog.dart';
import '../../../../components/navigation_bloc.dart';
import '../../../../components/LicenseImageTile.dart';
import '../../../../components/dbConnection.dart';
import '../../../../components/default_button.dart';
import '../../../../components/screenArguments.dart';
import '../../../../components/violation_list_record.dart';
import '/sizes_helpers.dart';

import 'package:http/http.dart' as http;

Color bgColor;
String status = "Good";

class ViolationsBody extends StatefulWidget {
  const ViolationsBody({
    Key key,
    @required this.args,
  }) : super(key: key);

  final ScreenArguments args;

  @override
  _ViolationsBodyState createState() => _ViolationsBodyState();
}

class _ViolationsBodyState extends State<ViolationsBody> {
  Future getLicenseStatus() async {
    try {
      var url = DBConnect().conn + "/readLicence.php";
      var response = await http.post(Uri.parse(url), body: {
        "licenseNumber": widget.args.text,
      });

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        if (int.parse(data) == 1) {
          setState(() {
            bgColor = Colors.greenAccent[400];
            status = "Valid";
          });

          print("done");
        } else if (int.parse(data) == 0) {
          setState(() {
            bgColor = Colors.redAccent[400];
            status = "Blocked";
          });
        }
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return CustomAlertDialog(
              alertHeading: "Warning !",
              alertBody: "Server error. Please try again !",
              alertButtonColour: Colors.red,
              alertButtonText: "Ok",
              alertAvatarBgColour: Colors.redAccent,
              alertAvatarColour: Colors.white,
              alertAvatarIcon: Icons.error,
              buttonPress: () => {Navigator.of(context).pop()},
            );
          },
        );
      }
    } on SocketException catch (e) {
      print('Socket Error: $e');
      showDialog(
        context: context,
        builder: (context) {
          return CustomAlertDialog(
            alertHeading: "Warning !",
            alertBody: "No internet. Please check your connectivity !",
            alertButtonColour: Colors.red,
            alertButtonText: "Ok",
            alertAvatarBgColour: Colors.redAccent,
            alertAvatarColour: Colors.white,
            alertAvatarIcon: Icons.error,
            buttonPress: () => {Navigator.of(context).pop()},
          );
        },
      );
    } on Error catch (e) {
      print('General Error: $e');
      showDialog(
        context: context,
        builder: (context) {
          return CustomAlertDialog(
            alertHeading: "Warning !",
            alertBody: "Server error. Please try again !",
            alertButtonColour: Colors.red,
            alertButtonText: "Ok",
            alertAvatarBgColour: Colors.redAccent,
            alertAvatarColour: Colors.white,
            alertAvatarIcon: Icons.error,
            buttonPress: () => {Navigator.of(context).pop()},
          );
        },
      );
    }
  }

  Future getViolations() async {
    try {
      var url = DBConnect().conn + "/readViolations.php";
      var response = await http.post(Uri.parse(url), body: {
        "licenseNumber": widget.args.text,
      });

      var data = json.decode(response.body).cast<Map<String, dynamic>>();
      // data.forEach((element) => print(element));
      // print("data: " + data[0]['violation_id']);
      // print("data: " + data[0]['price']);
      // print("data: " + data[0]['payment']);

      return data;
    } on SocketException catch (e) {
      print('Socket Error: $e');
      showDialog(
        context: context,
        builder: (context) {
          return CustomAlertDialog(
            alertHeading: "Warning !",
            alertBody: "No internet. Please check your connectivity !",
            alertButtonColour: Colors.red,
            alertButtonText: "Ok",
            alertAvatarBgColour: Colors.redAccent,
            alertAvatarColour: Colors.white,
            alertAvatarIcon: Icons.error,
            buttonPress: () => {Navigator.of(context).pop()},
          );
        },
      );
    } on Error catch (e) {
      print('General Error: $e');
      showDialog(
        context: context,
        builder: (context) {
          return CustomAlertDialog(
            alertHeading: "Warning !",
            alertBody: "Server error. Please try again !",
            alertButtonColour: Colors.red,
            alertButtonText: "Ok",
            alertAvatarBgColour: Colors.redAccent,
            alertAvatarColour: Colors.white,
            alertAvatarIcon: Icons.error,
            buttonPress: () => {Navigator.of(context).pop()},
          );
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getLicenseStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: displayHeight(context) * 0.2,
            child: LicenseImageTile(
              args: widget.args.image,
            ),
          ),
          SizedBox(
            height: displayHeight(context) * 0.04,
          ),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: displayWidth(context) * 0.1),
            child: Row(
              children: [
                Text(
                  "License status: ",
                  style: TextStyle(
                    fontSize: displayWidth(context) * 0.05,
                  ),
                ),
                SizedBox(
                  width: displayWidth(context) * 0.03,
                ),
                Icon(
                  Icons.assignment_late,
                  size: displayWidth(context) * 0.1,
                  color: bgColor,
                ),
                Text(
                  status,
                  style: TextStyle(
                    fontSize: displayWidth(context) * 0.05,
                    fontWeight: FontWeight.bold,
                    color: bgColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: displayHeight(context) * 0.06,
          ),
          Text(
            "Violations",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: getViolations(),
              builder: (context, snapshot) {
                if (snapshot.hasError) print(snapshot.error);
                return snapshot.hasData
                    ? ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          List list = snapshot.data;
                          return ViolationListRecord(
                            violationId: list[index]['violation_id'],
                            price: list[index]['price'],
                            payment: list[index]['payment'],
                          );
                        },
                      )
                    : Text("");
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: DefaultButton(
              text: "Home",
              press: () {
                BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.HomePageClickeEvent);
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
