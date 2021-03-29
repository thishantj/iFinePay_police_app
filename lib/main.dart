import 'package:flutter/material.dart';
import 'package:ifinepay_police_app/routes.dart';
import 'package:ifinepay_police_app/screens/login/login_screen.dart';
import 'package:ifinepay_police_app/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'iFinePay',
      theme: theme(),
      initialRoute: LoginScreen.routeName,
      routes: routes,
    );
  }
}

