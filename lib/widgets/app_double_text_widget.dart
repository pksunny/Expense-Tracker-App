// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:money_tracker_app/utils/txt_style.dart';

class AppDoubleTextWidget extends StatelessWidget {
  final String bigText;
  final String smallText;
  final VoidCallback onTap;

  const AppDoubleTextWidget(
      {super.key, required this.bigText, required this.smallText, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            bigText,
            style: TxtStyle.headLineStyle3.copyWith(color: Colors.black54)
          ),
          InkWell(
              onTap: onTap,
              child: Text(
                smallText,
                style: TxtStyle.headLineStyle3.copyWith(color: Colors.black54)
              )
          )
        ],
      ),
    );
  }
}
