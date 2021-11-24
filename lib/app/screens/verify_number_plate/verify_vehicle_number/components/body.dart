import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../../api/image_processing_api.dart';
import '../../../../components/default_button.dart';
import '../../../../components/verifyNumberPlateArgument.dart';
import '../../../../screens/verify_number_plate/vehicle_details/vehicle%20details_screen.dart';
import '/sizes_helpers.dart';
import 'package:image_picker/image_picker.dart';

String extractedText = '';

class VerifyNumberPlateBody extends StatefulWidget {
  const VerifyNumberPlateBody({
    Key key,
  }) : super(key: key);

  @override
  _VerifyNumberPlateBodyState createState() => _VerifyNumberPlateBodyState();
}

class _VerifyNumberPlateBodyState extends State<VerifyNumberPlateBody> {
  File _image;

  final imagePicker = ImagePicker();

  Future getPicture() async {

    checkPermission();

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

      Navigator.of(context).pop(); // show dialog closing

      VerifyNumberPlateArguments dla = new VerifyNumberPlateArguments(extractedText);
      Navigator.pushNamed(context, VehicleDetails.routeName, arguments: dla);
    }
    else
    {
      return;
    }
  }

  void checkPermission() async {
    var locationPermission = await Permission.location.status;

    if (!locationPermission.isGranted) {
      await Permission.locationWhenInUse.request();
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
              getPicture();
            },
          ),
        ],
      ),
    );
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