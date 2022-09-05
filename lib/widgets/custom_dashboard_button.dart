// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:money_tracker_app/utils/txt_style.dart';

class CustomDashboardButton extends StatelessWidget {
  const CustomDashboardButton({
    Key? key,
    required this.onTap,
    required this.text,
  }) : super(key: key);
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: primary,
            boxShadow: [
              BoxShadow(
                  spreadRadius: -10,
                  blurRadius: 17,
                  offset: Offset(-5, -15),
                  color: Colors.white70),
              BoxShadow(
                  spreadRadius: -2,
                  blurRadius: 10,
                  offset: Offset(10, 10),
                  color: Color.fromRGBO(146, 182, 216, 1)),
            ]),
        child: TextButton(
          onPressed: onTap,
          child: Text(text, style: TxtStyle.headLineStyle3.copyWith(color: Colors.black54),),
        ),
      ),
    );
  }
}
