// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

Color primary = Color.fromRGBO(193, 214, 233, 1);

class TxtStyle{
  static Color primaryColor = primary;
  static Color textColor = Colors.grey.shade500;
  static Color bgColor = const Color(0xFFeeedf2);
  static Color orangeColor = const Color(0xFF526799);
  static TextStyle textStyle =  TextStyle(fontFamily: 'Montserrat Regular', fontSize: 16, color: Colors.greenAccent.shade400, fontWeight: FontWeight.w500);
  static TextStyle headLineStyle1 =  TextStyle(fontFamily: 'Montserrat Regular', fontSize: 26, color: textColor, fontWeight: FontWeight.bold);
  static TextStyle headLineStyle2 =  TextStyle(fontFamily: 'Montserrat Regular', fontSize: 21, color: textColor, fontWeight: FontWeight.bold);
  static TextStyle headLineStyle3 =  TextStyle(fontFamily: 'Montserrat Medium', fontSize: 17, color: Colors.black54, fontWeight: FontWeight.w500);
  static TextStyle headLineStyle4 =  TextStyle(fontFamily: 'Montserrat Regular', fontSize: 14, color: Colors.grey.shade500, fontWeight: FontWeight.w500); 
}