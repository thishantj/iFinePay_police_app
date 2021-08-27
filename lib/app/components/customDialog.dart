import 'package:flutter/material.dart';
import 'package:ifinepay_police_app/sizes_helpers.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    Key key,
    @required this.alertHeading,
    this.alertBody,
    this.alertButtonText,
    this.alertButtonColour,
    this.alertAvatarBgColour,
    this.alertAvatarColour,
    this.alertAvatarIcon,
    this.buttonPress,
  }) : super(key: key);

  final String alertHeading;
  final String alertBody;
  final String alertButtonText;
  final Color alertButtonColour;
  final Color alertAvatarBgColour;
  final Color alertAvatarColour;
  final IconData alertAvatarIcon;
  final Function buttonPress;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: displayHeight(context) * 0.40,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
              child: Column(
                children: [
                  Text(
                    alertHeading,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    alertBody,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: alertButtonColour,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                      buttonPress();
                    },
                    child: Text(
                      alertButtonText,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            child: CircleAvatar(
              backgroundColor: alertAvatarBgColour,
              radius: 50,
              child: Icon(
                alertAvatarIcon,
                size: 50,
                color: alertAvatarColour,
              ),
            ),
            top: -50,
          ),
        ],
      ),
    );
  }
}
