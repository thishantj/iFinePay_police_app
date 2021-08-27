import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ifinepay_police_app/app/components/LicenseImageTile.dart';
import 'package:ifinepay_police_app/app/components/dbConnection.dart';
import 'package:ifinepay_police_app/app/components/default_button.dart';
import 'package:ifinepay_police_app/app/components/screenArguments.dart';
import 'package:ifinepay_police_app/app/components/violation_list_record.dart';
import 'package:ifinepay_police_app/app/screens/home_screen/home_screen.dart';
import 'package:ifinepay_police_app/sizes_helpers.dart';

import 'package:http/http.dart' as http;

Color bgColor;

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
    var url = DBConnect().conn+"d/readLicence.php";
    var response = await http.post(Uri.parse(url), body: {
      "licenseNumber": widget.args.text,
    });

    var data = json.decode(response.body).cast<Map<String, dynamic>>();
    // data.forEach((element) => print(element['status']));
    print("data: " + data[0]['status']);

    if (int.parse(data[0]['status']) == 1) {
      bgColor = Colors.greenAccent[400];
      print("done");
    } else if (int.parse(data[0]['status']) == 0) {
      bgColor = Colors.redAccent[400];
    }
    // ignore: invalid_use_of_protected_member
    //(context as Element).reassemble();
  }

  Future getViolations() async {
    var url = DBConnect().conn+"/readViolations.php";
    var response = await http.post(Uri.parse(url), body: {
      "licenseNumber": widget.args.text,
    });

    var data = json.decode(response.body).cast<Map<String, dynamic>>();
    data.forEach((element) => print(element));
    print("data: "+data[0]['violation_id']);
    print("data: "+data[0]['price']);
    
    return data;
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
            height: displayHeight(context) * 0.3,
            child: LicenseImageTile(
              args: widget.args.image,
              colorr: bgColor,
            ),
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
