import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ifinepay_police_app/app/components/ImageTile.dart';

class LicenseImageTile extends StatelessWidget {
  const LicenseImageTile({
    Key key,
    @required this.args,
  }) : super(key: key);

  final File args;

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            color: Colors.greenAccent[400],
          ),
          child: ImageTile(args: args),
        ),
      ),
    );
  }
}
