import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ifinepay_police_app/app/components/LicenseImageTile.dart';
import 'package:ifinepay_police_app/app/components/screenArguments.dart';
import 'package:ifinepay_police_app/app/components/violation_list_record.dart';
import 'package:ifinepay_police_app/app/screens/add_violation/scan_number_plate/scan_number_plate.dart';
import 'package:ifinepay_police_app/sizes_helpers.dart';

import 'package:http/http.dart' as http;

Color bgColor;

class LicenseStatusBody extends StatefulWidget {
  const LicenseStatusBody({
    Key key,
    @required this.args,
  }) : super(key: key);

  final ScreenArguments args;

  @override
  _LicenseStatusBodyState createState() => _LicenseStatusBodyState();
}

class _LicenseStatusBodyState extends State<LicenseStatusBody> {
  Future getLicenseStatus() async {
    var url = "http://192.168.26.1:444/flutter-crud/readLicence.php";
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
    var url = "http://192.168.26.1:444/flutter-crud/readViolations.php";
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
          Container(
            alignment: Alignment.bottomRight,
            padding: EdgeInsets.only(
              right: 20,
            ),
            child: FloatingActionButton(
              onPressed: () {
                //extractLicenseNumber(args.text);
                Navigator.pushNamed(context, ScanNumberPlateScreen.routeName, arguments: widget.args.text);
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


