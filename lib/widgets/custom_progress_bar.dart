// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:money_tracker_app/utils/txt_style.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class CustomProgressBar extends StatefulWidget {
  CustomProgressBar({super.key, required this.firstText, required this.secondText, required this.currencyText, required this.progressColor, required this.percent});

  String firstText;
  String secondText;
  String currencyText;
  Color progressColor;
  double percent;

  @override
  State<CustomProgressBar> createState() => _CustomProgressBarState();
}

class _CustomProgressBarState extends State<CustomProgressBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: LinearPercentIndicator(
        animation: true,
        animationDuration: 2000,
        lineHeight: 40.0,
        percent: widget.percent,
        center: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.firstText,
                  style: TxtStyle.headLineStyle4.copyWith(color: Colors.white)),
              Text("${widget.secondText}",
                  style: TxtStyle.headLineStyle4.copyWith(color: Colors.white)),
              Text(widget.currencyText, style: TxtStyle.headLineStyle4.copyWith(color: Colors.white),),
            ],
          ),
        ),
        barRadius: Radius.circular(10),
        progressColor: widget.progressColor,
        // backgroundColor: kNeumorphicColors[index]
      ),
    );
  }
}
