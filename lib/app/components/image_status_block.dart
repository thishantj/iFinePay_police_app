import 'package:flutter/material.dart';
import 'package:ifinepay_police_app/sizes_helpers.dart';

class ImageStatusBlock extends StatelessWidget {
  const ImageStatusBlock({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: displayHeight(context) * 0.3,
      child: GridTile(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              color: Colors.greenAccent[400],
            ),
            // child: ImageTile(args: args),
          ),
        ),
      ),
    );
  }
}
