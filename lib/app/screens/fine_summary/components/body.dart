import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ifinepay_police_app/app/components/default_button.dart';
import 'package:ifinepay_police_app/app/components/driverFineArguments.dart';
import 'package:ifinepay_police_app/app/screens/scan_license/scan_license.dart';
import 'package:ifinepay_police_app/sizes_helpers.dart';
import 'package:image_picker/image_picker.dart';


String licenseNumber = "";
String numberPlate = "";

class FineSummaryBody extends StatefulWidget {

  const FineSummaryBody({
    Key key,
    @required this.args,
  }) : super(key: key);

  final DriverFineArguments args;

  @override
  _FineSummaryBodyState createState() => _FineSummaryBodyState();
}

class _FineSummaryBodyState extends State<FineSummaryBody> {
  File _image;

  final imagePicker = ImagePicker();

  Future getPicture() async {
    final image = await imagePicker.getImage(source: ImageSource.camera);

    setState(() {
      _image = File(image.path);
    });
  }

  @override
    void initState() {
    super.initState();
    setDriverDetails(widget.args.licenseNumber, widget.args.numberPlate);
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
                  "License number:",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  width: displayWidth(context) * 0.035,
                ),
                Text(
                  licenseNumber,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: displayHeight(context) * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Driver's name:",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  width: displayWidth(context) * 0.035,
                ),
                Text(
                  "xxxxxxxxxxx",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: displayHeight(context) * 0.03,
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
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: displayHeight(context) * 0.035,
            ),
            Container(
              alignment: Alignment.centerRight,
              child: FloatingActionButton(
                onPressed: () {
                  getPicture();
                },
                child: Icon(
                  Icons.add_photo_alternate,
                ),
                elevation: 10,
                backgroundColor: Colors.black,
              ),
            ),
            SizedBox(
              height: displayHeight(context) * 0.035,
            ),
            ScannedFineSheetBlock(image: _image),
            SizedBox(
              height: displayHeight(context) * 0.075,
            ),
            DefaultButton(
              text: "Submit",
              press: () {
                Navigator.pushNamed(context, ScanLicenseScreen.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }

  void setDriverDetails(String lnum, String numP)
  {
    licenseNumber = lnum;

    String t1 = numP.replaceAll(RegExp(r'\n'), ' ');

    numberPlate = t1;
  }
}

class ScannedFineSheetBlock extends StatelessWidget {
  const ScannedFineSheetBlock({
    Key key,
    @required File image,
  })  : _image = image,
        super(key: key);

  final File _image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: displayHeight(context) * 0.3,
      child: GridTile(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              color: Colors.greenAccent[400],
            ),
            child: SizedBox(
              height: displayHeight(context) * 0.3,
              child: Center(
                child: _image == null
                    ? Text(
                        "Fine sheet not scanned",
                        textAlign: TextAlign.center,
                      )
                    : Image.file(_image),
              ),
            ),
          ),
        ),
      ),
    );
  }
}