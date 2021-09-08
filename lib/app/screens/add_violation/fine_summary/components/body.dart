import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../../../../components/navigation_bloc.dart';
import '../../../../../api/image_processing_api.dart';
import '../../../../components/customDialog.dart';
import '../../../../components/dbConnection.dart';
import '../../../../components/default_button.dart';
import '../../../../components/driverFineArguments.dart';
import '../../../../components/fineSheetDataExtraction.dart';
import '/sizes_helpers.dart';
import 'package:image_picker/image_picker.dart';

import 'package:http/http.dart' as http;

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

    var url = DBConnect().conn+"/addFine.php";
    var response = await http.post(Uri.parse(url), body: {
      "violationId": data["Violation_id"],
      "licenseNumber": licenseNumber,
      "numberPlate": numberPlate,
      "violationType": data["Violations"],
      "vehicleType": data["Vehicle_type"],
      "policeOfficerId": data["Police_officer"],
      "offenseTime": data["Time_of_offence"],
      "offenseDate": data["Date_of_offence"],
      "expiryDate": data["Valid_to"],
      "courtDate": data["Court_date"],
      "policeStationId": data["Police_station"],
      "courtId": data["Court"],
      "offenseLocation": data["Place_of_offence"],
      "price": data["Price"],
      "fineSheet": _image,
    });

    var responseData = json.decode(response.body);

    if (responseData == "Success") {
      // Send sms to driver
      BlocProvider.of<NavigationBloc>(context)
                    .add(NavigationEvents.HomePageClickeEvent);
    } else {
      Fluttertoast.showToast(
        msg: "Error in submitting fine sheet",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 12,
      );
    }
  }

  static locationOfOffence() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    var address = await placemarkFromCoordinates(
        position.latitude, position.longitude,
        localeIdentifier: "en");

    return address.first.subLocality;
  }

  Future getVehicleFlagged() async {
    var url = DBConnect().conn+"/readNumberplate.php";
    var response = await http.post(Uri.parse(url), body: {
      "numberPlate": widget.args.numberPlate,
    });

    var data = json.decode(response.body).cast<Map<String, dynamic>>();

    if (int.parse(data[0]['flagged']) == 1) {
      flagged = true;

      showDialog(
        context: context,
        builder: (context) {
          return CustomAlertDialog(
            alertHeading: "Warning !",
            alertBody: "This vehicle is flagged",
            alertButtonColour: Colors.red,
            alertButtonText: "Ok",
            alertAvatarBgColour: Colors.redAccent,
            alertAvatarColour: Colors.white,
            alertAvatarIcon: Icons.warning_amber_rounded,
            buttonPress: () =>
                          {Navigator.of(context).pop()},
          );
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
