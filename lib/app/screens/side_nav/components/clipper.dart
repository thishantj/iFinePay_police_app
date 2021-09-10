import 'package:flutter/material.dart';

class CustomMenuClipper extends CustomClipper<Path>
{
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.white;

    final width = size.width;
    final height = size.height;

    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, height * 0.08, height * 0.10, height * 0.16);
    path.quadraticBezierTo(width - width * 0.01, height/2 - height * 0.20, width, height/2);
    path.quadraticBezierTo(width + width * 0.01, height/2 + height * 0.20, 10, height - height * 0.16);
    path.quadraticBezierTo(0, height - height * 0.08, 0, height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
  
}