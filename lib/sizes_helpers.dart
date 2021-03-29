import 'package:flutter/material.dart';

Size displaySize(BuildContext context)
{
  debugPrint('Size = ' + MediaQuery.of(context).size.toString());

  return MediaQuery.of(context).size;
}

double displayHeight(BuildContext context)
{
  return displaySize(context).height;
}

double displayWidth(BuildContext context)
{
  return displaySize(context).width;
}