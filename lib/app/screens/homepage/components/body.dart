import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ifinepay_police_app/app/screens/scan_license/scan_license.dart';

class HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              children: [
                Card(
                  svgSrc: "assets/icons/username.svg",
                  title: "Check licence",
                  press: () {},
                ),
                Card(
                  svgSrc: "assets/icons/username.svg",
                  title: "Check number plate",
                  press: () {},
                ),
                Card(
                  svgSrc: "assets/icons/username.svg",
                  title: "Add violation",
                  press: () {
                    Navigator.pushNamed(context, ScanLicenseScreen.routeName);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Card extends StatelessWidget {
  final String svgSrc;
  final String title;
  final Function press;

  const Card({
    Key key,
    this.svgSrc,
    this.title,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.cyan,
          borderRadius: BorderRadius.circular(13),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 17),
              blurRadius: 17,
              spreadRadius: -17,
              color: Colors.black45,
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: press,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Spacer(),
                  SvgPicture.asset(svgSrc),
                  Spacer(),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
