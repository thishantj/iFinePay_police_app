import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ifinepay_police_app/components/default_button.dart';
import 'package:ifinepay_police_app/screens/scan_license/scan_license.dart';
import 'package:ifinepay_police_app/sizes_helpers.dart';
import 'package:image_picker/image_picker.dart';

class FineSummaryBody extends StatefulWidget {
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
                  width: displayWidth(context) * 0.04,
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
                  "Driver's name:",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  width: displayWidth(context) * 0.04,
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
                  width: displayWidth(context) * 0.04,
                ),
                Text(
                  "xx XXX XXXX",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: displayHeight(context) * 0.04,
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
              height: displayHeight(context) * 0.04,
            ),
            ScannedFineSheetBlock(image: _image),
            SizedBox(
              height: displayHeight(context) * 0.08,
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
