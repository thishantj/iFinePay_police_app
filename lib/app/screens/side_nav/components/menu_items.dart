import 'package:flutter/material.dart';
import 'package:ifinepay_police_app/sizes_helpers.dart';

class MenuItems extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function onTap;

  const MenuItems({
    Key key,
    this.icon,
    this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(
          16,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: displayWidth(context) * 0.075,
            ),
            SizedBox(
              width: displayWidth(context) * 0.05,
            ),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: displayWidth(context) * 0.05,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
