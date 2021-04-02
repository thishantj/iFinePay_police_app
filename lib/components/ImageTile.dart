import 'package:flutter/material.dart';
import 'package:ifinepay_police_app/screens/scan_license/components/body.dart';

class ImageTile extends StatelessWidget {
  const ImageTile({
    Key key,
    @required this.args,
  }) : super(key: key);

  final ImageArgs args;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.file(args.image),
    );
  }
}