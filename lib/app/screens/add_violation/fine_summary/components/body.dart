import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../../../../components/user.dart';
import '../../../../components/navigation_bloc.dart';
import '../../../../../api/image_processing_api.dart';
import '../../../../components/customDialog.dart';
import '../../../../components/dbConnection.dart';
import '../../../../components/default_button.dart';
import '../../../../components/driverFineArguments.dart';
import 'fineSheetDataExtraction.dart';
import '/sizes_helpers.dart';
import 'package:image_picker/image_picker.dart';

import 'package:http/http.dart' as http;

String licenseNumber = "";
String numberPlate = "";
String driverName = "";
String competentToDrive = "";
String location = "";
String district = "";
String province = "";
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
    final image = await imagePicker.pickImage(source: ImageSource.camera);

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

    try {
      var url = DBConnect().conn + "/addFine.php";
      var response = await http.post(Uri.parse(url), body: {
        "violationId": data["Violation_id"],
        "licenseNumber": licenseNumber,
        "numberPlate": numberPlate,
        "violationType": data["Violations_type"],
        "vehicleType": competentToDrive,
        "policeOfficerId": User().getUname().toString(),
        "offenseTime": data["Time_of_offence"],
        "offenseDate": data["Date_of_offence"],
        "expiryDate": data["Valid_to"],
        "courtDate": data["Court_date"],
        "policeStationId": data["Police_station"],
        "courtId": data["Court"],
        "offenseLocation": location,
        "price": data["Price"],
        "fineSheet": _image,
        "payment": data["Payment"],
        "district": district,
        "province": province,
      });

      var responseData = json.decode(response.body);

      if (responseData == "Success") {
        updateDriverLicenseStatus();

        //BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.HomePageClickeEvent);
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
    } on SocketException catch (e) {
      print('Socket Error: $e');
      showDialog(
        context: context,
        builder: (context) {
          return CustomAlertDialog(
            alertHeading: "Warning !",
            alertBody: "No internet. Please check your connectivity !",
            alertButtonColour: Colors.red,
            alertButtonText: "Ok",
            alertAvatarBgColour: Colors.redAccent,
            alertAvatarColour: Colors.white,
            alertAvatarIcon: Icons.error,
            buttonPress: () => {Navigator.of(context).pop()},
          );
        },
      );
    } on Error catch (e) {
      print('General Error: $e');
      showDialog(
        context: context,
        builder: (context) {
          return CustomAlertDialog(
            alertHeading: "Warning !",
            alertBody: "Server error. Please try again !",
            alertButtonColour: Colors.red,
            alertButtonText: "Ok",
            alertAvatarBgColour: Colors.redAccent,
            alertAvatarColour: Colors.white,
            alertAvatarIcon: Icons.error,
            buttonPress: () => {Navigator.of(context).pop()},
          );
        },
      );
    }
  }

  Future updateDriverLicenseStatus() async {
    try {
      var url = DBConnect().conn + "/updateDriverLicenseStatus.php";
      var response = await http.post(Uri.parse(url), body: {
        "licenseNumber": licenseNumber,
      });

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        if (data == "Success") {
          //updateDriverLicenseStatus();

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
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return CustomAlertDialog(
              alertHeading: "Warning !",
              alertBody: "Server error. Please try again !",
              alertButtonColour: Colors.red,
              alertButtonText: "Ok",
              alertAvatarBgColour: Colors.redAccent,
              alertAvatarColour: Colors.white,
              alertAvatarIcon: Icons.error,
              buttonPress: () => {Navigator.of(context).pop()},
            );
          },
        );
      }
    } on SocketException catch (e) {
      print('Socket Error: $e');
      showDialog(
        context: context,
        builder: (context) {
          return CustomAlertDialog(
            alertHeading: "Warning !",
            alertBody: "No internet. Please check your connectivity !",
            alertButtonColour: Colors.red,
            alertButtonText: "Ok",
            alertAvatarBgColour: Colors.redAccent,
            alertAvatarColour: Colors.white,
            alertAvatarIcon: Icons.error,
            buttonPress: () => {Navigator.of(context).pop()},
          );
        },
      );
    } on Error catch (e) {
      print('General Error: $e');
      showDialog(
        context: context,
        builder: (context) {
          return CustomAlertDialog(
            alertHeading: "Warning !",
            alertBody: "Server error. Please try again !",
            alertButtonColour: Colors.red,
            alertButtonText: "Ok",
            alertAvatarBgColour: Colors.redAccent,
            alertAvatarColour: Colors.white,
            alertAvatarIcon: Icons.error,
            buttonPress: () => {Navigator.of(context).pop()},
          );
        },
      );
    }
  }

  Future locationOfOffence() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    var address = await placemarkFromCoordinates(
        position.latitude, position.longitude,
        localeIdentifier: "en");

    setState(() {
      location = address.first.locality;
      district = address.first.subAdministrativeArea;
      province = address.first.administrativeArea;
    });

    return address.first.locality;
  }

  Future getVehicleFlagged() async {
    try {
      var url = DBConnect().conn + "/readNumberplate.php";
      var response = await http.post(Uri.parse(url), body: {
        "numberPlate": widget.args.numberPlate,
      });

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        if (int.parse(data) == 1) {
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
                buttonPress: () => {Navigator.of(context).pop()},
              );
            },
          );
        }
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return CustomAlertDialog(
              alertHeading: "Warning !",
              alertBody: "Server error. Please try again !",
              alertButtonColour: Colors.red,
              alertButtonText: "Ok",
              alertAvatarBgColour: Colors.redAccent,
              alertAvatarColour: Colors.white,
              alertAvatarIcon: Icons.error,
              buttonPress: () => {Navigator.of(context).pop()},
            );
          },
        );
      }
    } on SocketException catch (e) {
      print('Socket Error: $e');
      showDialog(
        context: context,
        builder: (context) {
          return CustomAlertDialog(
            alertHeading: "Warning !",
            alertBody: "No internet. Please check your connectivity !",
            alertButtonColour: Colors.red,
            alertButtonText: "Ok",
            alertAvatarBgColour: Colors.redAccent,
            alertAvatarColour: Colors.white,
            alertAvatarIcon: Icons.error,
            buttonPress: () => {Navigator.of(context).pop()},
          );
        },
      );
    } on Error catch (e) {
      print('General Error: $e');
      showDialog(
        context: context,
        builder: (context) {
          return CustomAlertDialog(
            alertHeading: "Warning !",
            alertBody: "Server error. Please try again !",
            alertButtonColour: Colors.red,
            alertButtonText: "Ok",
            alertAvatarBgColour: Colors.redAccent,
            alertAvatarColour: Colors.white,
            alertAvatarIcon: Icons.error,
            buttonPress: () => {Navigator.of(context).pop()},
          );
        },
      );
    }
  }

  Future getDriverName() async {
    try {
      var url = DBConnect().conn + "/readDrivername.php";
      var response = await http.post(Uri.parse(url), body: {
        "licenseNumber": widget.args.licenseNumber,
      });

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        if (data != null) {
          setState(() {
            driverName = data;
          });
        }
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return CustomAlertDialog(
              alertHeading: "Warning !",
              alertBody: "Server error. Please try again !",
              alertButtonColour: Colors.red,
              alertButtonText: "Ok",
              alertAvatarBgColour: Colors.redAccent,
              alertAvatarColour: Colors.white,
              alertAvatarIcon: Icons.error,
              buttonPress: () => {Navigator.of(context).pop()},
            );
          },
        );
      }
    } on SocketException catch (e) {
      print('Socket Error: $e');
      showDialog(
        context: context,
        builder: (context) {
          return CustomAlertDialog(
            alertHeading: "Warning !",
            alertBody: "No internet. Please check your connectivity !",
            alertButtonColour: Colors.red,
            alertButtonText: "Ok",
            alertAvatarBgColour: Colors.redAccent,
            alertAvatarColour: Colors.white,
            alertAvatarIcon: Icons.error,
            buttonPress: () => {Navigator.of(context).pop()},
          );
        },
      );
    } on Error catch (e) {
      print('General Error: $e');
      showDialog(
        context: context,
        builder: (context) {
          return CustomAlertDialog(
            alertHeading: "Warning !",
            alertBody: "Server error. Please try again !",
            alertButtonColour: Colors.red,
            alertButtonText: "Ok",
            alertAvatarBgColour: Colors.redAccent,
            alertAvatarColour: Colors.white,
            alertAvatarIcon: Icons.error,
            buttonPress: () => {Navigator.of(context).pop()},
          );
        },
      );
    }
  }

  Future getVehicleTypes() async {
    try {
      var url = DBConnect().conn + "/readVehicleTypes.php";
      var response = await http.post(Uri.parse(url), body: {
        "licenseNumber": widget.args.licenseNumber,
      });

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        print("data: " + data);

        if (data != null) {
          setState(() {
            competentToDrive = data;
          });
        }
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return CustomAlertDialog(
              alertHeading: "Warning !",
              alertBody: "Server error. Please try again !",
              alertButtonColour: Colors.red,
              alertButtonText: "Ok",
              alertAvatarBgColour: Colors.redAccent,
              alertAvatarColour: Colors.white,
              alertAvatarIcon: Icons.error,
              buttonPress: () => {
                Navigator.of(context).pop(),
              },
            );
          },
        );
      }
    } on SocketException catch (e) {
      print('Socket Error: $e');
      showDialog(
        context: context,
        builder: (context) {
          return CustomAlertDialog(
            alertHeading: "Warning !",
            alertBody: "No internet. Please check your connectivity !",
            alertButtonColour: Colors.red,
            alertButtonText: "Ok",
            alertAvatarBgColour: Colors.redAccent,
            alertAvatarColour: Colors.white,
            alertAvatarIcon: Icons.error,
            buttonPress: () => {Navigator.of(context).pop()},
          );
        },
      );
    } on Error catch (e) {
      print('General Error: $e');
      showDialog(
        context: context,
        builder: (context) {
          return CustomAlertDialog(
            alertHeading: "Warning !",
            alertBody: "Server error. Please try again !",
            alertButtonColour: Colors.red,
            alertButtonText: "Ok",
            alertAvatarBgColour: Colors.redAccent,
            alertAvatarColour: Colors.white,
            alertAvatarIcon: Icons.error,
            buttonPress: () => {
              Navigator.of(context).pop(),
            },
          );
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    setDriverDetails(widget.args.licenseNumber, widget.args.numberPlate);

    setState(() {
      locationOfOffence();
      getDriverName();
      getVehicleFlagged();
      getVehicleTypes();
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
                    fontSize: displayWidth(context) * 0.04,
                  ),
                ),
                Text(
                  licenseNumber,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: displayWidth(context) * 0.04,
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
                    fontSize: displayWidth(context) * 0.04,
                  ),
                ),
                Text(
                  driverName,
                  style: TextStyle(
                    fontSize: displayWidth(context) * 0.04,
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
                    fontSize: displayWidth(context) * 0.04,
                  ),
                ),
                Text(
                  numberPlate,
                  style: TextStyle(
                    fontSize: displayWidth(context) * 0.04,
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
