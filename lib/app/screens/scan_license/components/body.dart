import 'package:flutter/material.dart';
import 'package:ifinepay_police_app/api/image_processing_api.dart';
import 'package:ifinepay_police_app/app/components/default_button.dart';
import 'package:ifinepay_police_app/app/components/screenArguments.dart';
import 'package:ifinepay_police_app/app/screens/license_status/license_status_screen.dart';
import 'package:ifinepay_police_app/constants.dart';
import 'package:ifinepay_police_app/sizes_helpers.dart';

import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ScanLicenseBody extends StatefulWidget {
  @override
  _ScanLicenseBodyState createState() => _ScanLicenseBodyState();
}

class _ScanLicenseBodyState extends State<ScanLicenseBody> {
  File _image;
  String extractedText = '';

  final imagePicker = ImagePicker();

  Future getPicture() async {

    checkPermission();

    final image = await imagePicker.getImage(source: ImageSource.camera);

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

    ScreenArguments sa = new ScreenArguments(_image, extractedText);

    Navigator.pushNamed(context, LicenseStatusScreen.routeName, arguments: sa);
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
            Text(
              "Scan driver's license",
              textAlign: TextAlign.center,
              style: headingStyle,
            ),
            SizedBox(
              height: displayHeight(context) * 0.02,
            ),
            SizedBox(
              height: displayHeight(context) * 0.6,
              child: Center(
                child: _image == null
                    ? Text(
                        "Driver's license not scanned",
                        textAlign: TextAlign.center,
                      )
                    : Image.file(_image),
              ),
            ),
            //  _image == null ? Text("No image selected") : Image.file(_image),
            SizedBox(
              height: displayHeight(context) * 0.04,
            ),
            DefaultButton(
              text: "Take photo",
              press: () {
                getPicture();
              },
            ),
          ],
        ),
      ),
    );
  }

  void checkPermission() async
  {
    var locationPermission = await Permission.location.status;
    var cameraPermission = await Permission.camera.status;

    if(!locationPermission.isGranted)
    {
      await Permission.locationWhenInUse.request();
    }

    if(!cameraPermission.isGranted)
    {
      await Permission.camera.request();
    }
  }
}

class ImageArgs {
  final File image;

  ImageArgs(this.image);
}
