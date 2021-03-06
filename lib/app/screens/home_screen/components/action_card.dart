import 'package:flutter/material.dart';
import '/sizes_helpers.dart';

class ActionCard extends StatelessWidget {
  final String img;
  final String title;
  final Function press;

  const ActionCard({
    Key key,
    this.img,
    this.title,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: displayWidth(context) * 0.05,
        left: displayWidth(context) * 0.05,
        bottom: 15.0,
      ),
      child: GestureDetector(
        onTap: press,
        child: Expanded(
          child: Container(
            padding: EdgeInsets.only(
              top: displayHeight(context) * 0.02,
            ),
            height: 180,
            width: 160,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[400],
                  offset: const Offset(
                    4.0,
                    5.0,
                  ),
                  blurRadius: 10.0,
                  spreadRadius: 2.5,
                ),
                BoxShadow(
                  color: Colors.white,
                  offset: const Offset(
                    0.0,
                    0.0,
                  ),
                  blurRadius: 0.0,
                  spreadRadius: 0.0,
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(displayWidth(context) * 0.025),
              child: Column(
                children: [
                  // Image.asset(
                  //   img,
                  //   height: displayHeight(context) * 0.1,
                  // ),
                  Image(
                    image: AssetImage(img),
                    height: displayHeight(context) * 0.1,
                  ),
                  SizedBox(
                    height: displayHeight(context) * 0.01,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: displayWidth(context) * 0.04,
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
