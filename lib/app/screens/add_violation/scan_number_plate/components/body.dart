import 'dart:io';

import 'package:flutter/material.dart';
import '../../../../../api/image_processing_api.dart';
import '../../../../components/default_button.dart';
import '../../../../components/driverFineArguments.dart';
import '../../../../screens/add_violation/fine_summary/fine_summary_screen.dart';
import '/sizes_helpers.dart';
import 'package:image_picker/image_picker.dart';

String licenseNumber = "";
String extractedText = '';

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
    final image = await imagePicker.pickImage(source: ImageSource.camera);

    if(image != null)
    {
      setState(() {
        _image = File(image.path);
      });

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Center(
              child: CircularProgressIndicator(),
            );
          });

      extractedText = await ImageProcessingApi.recogniseText(_image);

      DriverFineArguments dla = new DriverFineArguments(licenseNumber, extractedText);
      Navigator.pushNamed(context, FineSummary.routeName, arguments: dla);
    }
    else
    {
      return;
    }
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
          SizedBox(
            height: displayHeight(context) * 0.04,
          ),
          ScannedNumberPlateBlock(image: _image),
          SizedBox(
            height: displayHeight(context) * 0.04,
          ),
          DefaultButton(
            text: "Take photo",
            press: () {
              setLicenseNumber(widget.args);
              getPicture();
            },
          ),
        ],
      ),
    );
  }

  void setLicenseNumber(String lnum) {
    licenseNumber = lnum;
  }
}

class ScannedNumberPlateBlock extends StatelessWidget {
  const ScannedNumberPlateBlock({
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
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              color: Colors.white,
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