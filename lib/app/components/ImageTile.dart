import 'dart:io';

import 'package:flutter/material.dart';

class ImageTile extends StatelessWidget {
  const ImageTile({
    Key key,
    @required this.args,
  }) : super(key: key);

  final File args;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.file(args),
    );
  }
}