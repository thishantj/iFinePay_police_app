import 'package:flutter/material.dart';
import 'package:ifinepay_police_app/sizes_helpers.dart';

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
      padding: const EdgeInsets.only(right: 15.0, left: 15.0, bottom: 15.0),
      child: GestureDetector(
        onTap: press,
        child: Expanded(
          child: Container(
            padding: EdgeInsets.only(top: displayHeight(context) * 0.02,),
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
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Image.asset(
                    img,
                    height: displayHeight(context) * 0.1,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 12,
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
