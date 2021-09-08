import 'package:flutter/material.dart';
import '/sizes_helpers.dart';

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
        borderRadius: BorderRadius.circular(20),
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
                      fontSize: displayHeight(context) * 0.03,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: displayHeight(context) * 0.05,
                  ),
                  Text(
                    alertBody,
                    style: TextStyle(
                      fontSize: displayHeight(context) * 0.02,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: displayHeight(context) * 0.06,
                  ),
                  SizedBox(
                    height: displayHeight(context) * 0.06,
                    width: displayWidth(context) * 0.3,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: alertButtonColour,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        buttonPress();
                      },
                      child: Text(
                        alertButtonText,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: displayHeight(context) * 0.025,
                        ),
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
