import 'package:flutter/material.dart';
import 'package:ifinepay_police_app/api/image_processing_api.dart';
import 'package:ifinepay_police_app/app/components/customDialog.dart';
import 'package:ifinepay_police_app/app/components/default_button.dart';
import 'package:ifinepay_police_app/app/components/screenArguments.dart';
import 'package:ifinepay_police_app/app/screens/add_violation/license_status/license_status_screen.dart';
import 'package:ifinepay_police_app/constants.dart';
import 'package:ifinepay_police_app/sizes_helpers.dart';

import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

String lnumber = "";

class ScanLicenseBody extends StatefulWidget {
  @override
  _ScanLicenseBodyState createState() => _ScanLicenseBodyState();
}

class _ScanLicenseBodyState extends State<ScanLicenseBody> {
  File _image;
  String extractedText = '';

  final imagePicker = ImagePicker();

  Future getPicture() async {

    showDialog(
        context: context,
        builder: (context) {
          return CustomAlertDialog(
            alertHeading: "Information !",
            alertBody: "Please enable auto-rotation and location before taking picture",
            alertButtonColour: Colors.blue,
            alertButtonText: "Ok",
            alertAvatarBgColour: Colors.blueAccent,
            alertAvatarColour: Colors.white,
            alertAvatarIcon: Icons.info_outline_rounded,
          );
        },
    );

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

    extractLicenseNumber(extractedText);

    ScreenArguments sa = new ScreenArguments(_image, lnumber);

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

  void extractLicenseNumber(String s)
  {
    List<String> splitted = s.split(" ");
    List<String> filtered = List<String>.filled(50, "", growable: true);
    
    for(var item in splitted)
    {
      if(item.startsWith("B"))
      {
        if(item.contains(RegExp(r'[1-9]'), 2))
        {
          if(item.length == 8)
          {
            print("Result: "+item);
            filtered.add(item);
            lnumber = item;
          }
        }
      }
    }

    print("lnumber: " + lnumber);
  }
}

class ImageArgs {
  final File image;

  ImageArgs(this.image);
}
