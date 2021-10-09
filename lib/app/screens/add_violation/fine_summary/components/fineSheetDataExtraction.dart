import 'package:intl/intl.dart';

class FineSheetDataExtraction {
  Map<String, dynamic> extractData(String fineSheetText) {
    if (fineSheetText == null) {
      return null;
    } else {
      final Map<String, dynamic> details = {};
      String currentDate = getCurrentDate();
      String dateInTwoWeeks = getFinalDate();
      String courtDate = dateInTwoWeeks;

      details["Violation_id"] = getViolationId(fineSheetText); 
      details["Violations_type"] = getViolationTypes(fineSheetText); 
      details["Time_of_offence"] = timeOfOffence();
      details["Date_of_offence"] = currentDate;
      details["Valid_to"] = dateInTwoWeeks;
      details["Court_date"] = courtDate;
      details["Police_station"] = getPoliceStationId(fineSheetText);
      details["Court"] = getCourtId(fineSheetText);
      details["Price"] = getPrice(fineSheetText);
      details["Payment"] = "not paid";

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
      if (item.toLowerCase().startsWith("c")) {
        if (item.length == 4) {
          filtered = item;
        }
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
      if (item.toLowerCase().startsWith("pst")) {
        print("PST1: " + item);
        if (item.length <= 9) {
          print("Police station id: " + item);
          filtered = item;
        }
      }
    }

    return filtered;
  }
  // -----------------------------------------------------------------------------------

  // Get the id of violation -----------------------------------------------------------
  static String getViolationId(String s) {
    List<String> splitted = s.split("\n");
    String filtered = "";

    for (var item in splitted) {
      if (item.toLowerCase().startsWith("v")) {
        print("V id: " + item);
        if ((int.tryParse(item.substring(1, 1)) != null) == true) {
          print("Violation id: " + item);
          filtered = item;
        }
      }
    }

    return filtered;
  }
  // -----------------------------------------------------------------------------------

  // Get the violation type(s) ---------------------------------------------------------
  static String getViolationTypes(String s) {
    List<String> splitted = s.split("\n");
    String filtered = "";

    for (var item in splitted) {
      if (item.toLowerCase().startsWith("vt")) {
          print("Violation type(s): " + item);
          filtered = item;
      }
    }

    return filtered;
  }
  // -----------------------------------------------------------------------------------

  // Get the price ---------------------------------------------------------------------
  static String getPrice(String s) {
    List<String> splitted = s.split("\n");
    String filtered = "";

    for (var item in splitted) {
      if ((double.tryParse(item.substring(0, item.length)) != null) == true && item.length >= 3) {
        print("Price: " + item);
        filtered = item;
      }
    }

    return filtered.toString();
  }
  // -----------------------------------------------------------------------------------
}
