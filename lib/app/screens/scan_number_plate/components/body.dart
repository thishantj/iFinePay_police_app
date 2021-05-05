import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ifinepay_police_app/app/components/default_button.dart';
import 'package:ifinepay_police_app/app/components/driverFineArguments.dart';
import 'package:ifinepay_police_app/app/components/screenArguments.dart';
import 'package:ifinepay_police_app/app/screens/fine_summary/fine_summary_screen.dart';
import 'package:ifinepay_police_app/sizes_helpers.dart';
import 'package:image_picker/image_picker.dart';

String licenseNumber = "";

class ScanNumberPlateBody extends StatefulWidget {

  const ScanNumberPlateBody({
    Key key,
    @required this.args,
  }) : super(key: key);

  final String args;

  @override
  _ScanNumberPlateBodyState createState() => _ScanNumberPlateBodyState();
}

class _ScanNumberPlateBodyState extends State<ScanNumberPlateBody> {
  File _image;


  final imagePicker = ImagePicker();

  Future getPicture() async {
    final image = await imagePicker.getImage(source: ImageSource.camera);

    setState(() {
      _image = File(image.path);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          SizedBox(
            height: displayHeight(context) * 0.01,
          ),
          SizedBox(
            height: displayHeight(context) * 0.2,
            child: Image(
              image: AssetImage(
                "assets/images/car.png",
              ),
            ),
          ),
          DefaultButton(
            text: "Take photo",
            press: () {
              getPicture();
            },
          ),
          SizedBox(
            height: displayHeight(context) * 0.04,
          ),
          ScannedNumberPlateBlock(image: _image),
          SizedBox(
            height: displayHeight(context) * 0.035,
          ),
          NumberPlateBlock(),
          SizedBox(
            height: displayHeight(context) * 0.03,
          ),
          Container(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              onPressed: () {
                setLicenseNumber(widget.args);
                DriverFineArguments dla = new DriverFineArguments(licenseNumber, "extractedText");
                Navigator.pushNamed(context, FineSummary.routeName, arguments: dla);
              },
              child: Icon(
                Icons.arrow_forward_ios_rounded,
              ),
              elevation: 10,
              backgroundColor: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  void setLicenseNumber(String lnum)
  {
    licenseNumber = lnum;
  }
}

class NumberPlateBlock extends StatelessWidget {
  const NumberPlateBlock({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Number plate:",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        SizedBox(
          width: displayWidth(context) * 0.08,
        ),
        Text(
          "xx XXX XXXX",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class ScannedNumberPlateBlock extends StatelessWidget {
  const ScannedNumberPlateBlock({
    Key key,
    @required File image,
  }) : _image = image, super(key: key);

  final File _image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: displayHeight(context) * 0.3,
      child: GridTile(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
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
                        "Number plate not scanned",
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
