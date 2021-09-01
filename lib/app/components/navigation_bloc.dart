import 'package:flutter_bloc/flutter_bloc.dart';
import '../screens/add_violation/scan_license/scan_license.dart';
import '../screens/home_screen/home_screen.dart';
import '../screens/verify_driver_license/verify_license/verify_license.dart';
import '../screens/verify_number_plate/verify_vehicle_number/verify_number_plate.dart';

enum NavigationEvents {
  HomePageClickeEvent,
  ScanLicenseClickeEvent,
  ScanNumberPlateClickeEvent,
  AddFineClickeEvent,
}

abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  NavigationBloc(NavigationStates initialState) : super(HomeScreen());

  //NavigationStates get initialState => HomeScreen();

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async*{
    
    switch (event)
    {
      case NavigationEvents.HomePageClickeEvent: yield HomeScreen();
      break;
      case NavigationEvents.ScanLicenseClickeEvent: yield VerifyLicenseScreen();
      break;
      case NavigationEvents.ScanNumberPlateClickeEvent: yield VerifyNumberPlateScreen();
      break;
      case NavigationEvents.AddFineClickeEvent: yield ScanLicenseScreen();
      break;
      
    }
  }
}
