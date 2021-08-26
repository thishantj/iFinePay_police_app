import 'package:intl/intl.dart';

class FineSheetDataExtraction {
  Map<String, dynamic> extractData(String fineSheetText) {
    if (fineSheetText == null) {
      return null;
    } else {
      final Map<String, dynamic> details = {};
      String currentDate = getCurrentDate();
      String dateInTwoWeeks = getFinalDate();

      details["Violation_id"] = "951321"; //to be completed
      details["Violations"] = "V1";       //to be completed
      details["Vehicle_type"] = "A";      //to be completed
      details["Police_officer"] = getPoliceOfficerId(fineSheetText);
      details["Time_of_offence"] = timeOfOffence();
      details["Date_of_offence"] = currentDate;
      details["Valid_to"] = dateInTwoWeeks;
      details["Court_date"] = dateInTwoWeeks;
      details["Police_station"] = getPoliceStationId(fineSheetText);
      details["Court"] = getCourtId(fineSheetText);
      details["Price"] = 0;

      details.forEach((key, value) {
        print('key = $key : value = $value');
      });

      return details;
    }
  }

  // current date ---------------------------------------------------------------------
  static String getCurrentDate() {
    var date = new DateTime.now().toString();

    var dateParse = DateTime.parse(date);

    var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";

    return formattedDate.toString();
  }
  // -----------------------------------------------------------------------------------

  // time of offence -------------------------------------------------------------------
  static String timeOfOffence() {
    DateTime now = DateTime.now();
    String formattedTime = DateFormat('hh:mm').format(now);

    return formattedTime.toString();
  }
  // -----------------------------------------------------------------------------------

  // Date in 13 days -------------------------------------------------------------------
  static String getFinalDate() {
    var date = new DateTime.now();

    var finalDate = date.add(Duration(days: 13)).toString();

    var dateParse = DateTime.parse(finalDate);

    var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";

    return formattedDate.toString();
  }
  // -----------------------------------------------------------------------------------

  // Get the id of the court -----------------------------------------------------------
  static String getCourtId(String s) {
    List<String> splitted = s.split("\n");
    String filtered = "";

    for (var item in splitted) {
      if (item.startsWith("C") || item.startsWith("c")) {
        //if (item.contains(RegExp(r'[1-9]'), 2)) {
          //print("C2: " + item);
          if (item.length == 4) {
            print("Court id: " + item);
            filtered = item;
          }
        //}
      }
    }

    return filtered;
  }
  // -----------------------------------------------------------------------------------

  // Get the id of the police station --------------------------------------------------
  static String getPoliceStationId(String s) {
    List<String> splitted = s.split("\n");
    String filtered = "";

    for (var item in splitted) {
      if (item.startsWith("PST") || item.startsWith("pst")) {
        print("PST1: " + item);
        //if (item.contains("S", 2) || item.contains("s", 2)) {
          //print("PST2: " + item);
          //if (item.contains("T", 3) || item.contains("t", 3)) {
            //print("PST3: " + item);
            //if (item.contains(RegExp(r'[1-9]'), 4)) {
              //print("PST4: " + item);
              if (item.length == 7) {
                print("Police station id: " + item);
                filtered = item;
              }
            //}
          //}
        //}
      }
    }

    return filtered;
  }
  // -----------------------------------------------------------------------------------

  // Get the id of the police officer --------------------------------------------------
  static String getPoliceOfficerId(String s) {
    List<String> splitted = s.split("\n");
    String filtered = "";

    for (var item in splitted) {
      if (item.startsWith(RegExp(r'[1-9]'))) {
        if (item.length == 6) {
          print("Police officer id: " + item);
          filtered = item;
        }
      }
    }

    return filtered;
  }
  // -----------------------------------------------------------------------------------
}
