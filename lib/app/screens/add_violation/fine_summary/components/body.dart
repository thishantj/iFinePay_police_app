import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ifinepay_police_app/api/image_processing_api.dart';
import 'package:ifinepay_police_app/app/components/default_button.dart';
import 'package:ifinepay_police_app/app/components/driverFineArguments.dart';
import 'package:ifinepay_police_app/app/components/fineSheetDataExtraction.dart';
import 'package:ifinepay_police_app/sizes_helpers.dart';
import 'package:image_picker/image_picker.dart';

String licenseNumber = "";
String numberPlate = "";
var flagged;

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
  String extractedText = '';

  final imagePicker = ImagePicker();

  Future getPicture() async {
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
      },
    );

    extractedText = await ImageProcessingApi.recogniseText(_image);
    print("ext: " + extractedText);

    FineSheetDataExtraction f = new FineSheetDataExtraction();
    var data = f.extractData(extractedText);

    data["Place_of_offence"] = locationOfOffence();

    print("Date of offence: " +data["Date_of_offence"]);
    print("Time of offence: " +data["Time_of_offence"]);
    print("Valid from: " +data["Valid_from"]);
    print("Valid to: " +data["Valid_to"]);
    print("Court date: " +data["Court_date"]);
    //print("Place of offence: " +data["Place_of_offence"]);
    locationOfOffence().then((value) => print(value));
    // Navigator.pushNamed(context, ScanLicenseScreen.routeName);
    data.forEach((key, value) {
        print('$key : $value');
      });
  }

  static locationOfOffence() async {

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    var address = await placemarkFromCoordinates(position.latitude, position.longitude, localeIdentifier: "en");

    return address.first.subLocality;
  }

  Future getVehicleFlagged() async {
    var url = "http://192.168.26.1:444/flutter-crud/readNumberplate.php";
    var response = await http.post(Uri.parse(url), body: {
      "numberPlate": widget.args.numberPlate,
    });

    var data = json.decode(response.body).cast<Map<String, dynamic>>();
    // data.forEach((element) => print(element['status']));
    print("data: " + data[0]['flagged']);

    if (int.parse(data[0]['flagged']) == 1) {
      //CustomAlertDialog();
      //Future.delayed(Duration.zero, () => CustomAlertDialog());
      flagged = true;

      showDialog(
        context: context,
        builder: (context) {
          return CustomAlertDialog();
        },
      );

      print("done");
    }
    // ignore: invalid_use_of_protected_member
    (context as Element).reassemble();
  }

  @override
  void initState() {
    super.initState();
    setDriverDetails(widget.args.licenseNumber, widget.args.numberPlate);
    getVehicleFlagged();
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
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: displayHeight(context) * 0.035,
            ),
            SizedBox(
              height: displayHeight(context) * 0.035,
            ),
            ScannedFineSheetBlock(image: _image),
            SizedBox(
              height: displayHeight(context) * 0.035,
            ),
            DefaultButton(
              text: "Submit",
              press: () {
                getPicture();
              },
            ),
          ],
        ),
      ),
    );
  }

  void setDriverDetails(String lnum, String numP) {
    licenseNumber = lnum;
    print("number plate: " + numP);
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
      height: displayHeight(context) * 0.1, //0.3
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
              height: displayHeight(context) * 0.1, //0.3
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
