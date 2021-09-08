import 'package:flutter/material.dart';
import 'package:ifinepay_police_app/sizes_helpers.dart';

import '../../constants.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key key,
    this.text,
    this.press,
  }) : super(key: key);
  final String text;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: displayHeight(context) * 0.07,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: kPrimaryColor,
          shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
        ),
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(
            fontSize: displayWidth(context) * 0.045,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}