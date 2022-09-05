import 'package:flutter/material.dart';
import 'package:money_tracker_app/services/spalsh_service.dart';
import 'package:money_tracker_app/utils/txt_style.dart';
import 'package:money_tracker_app/widgets/custom_progress_bar.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class SplashSCreen extends StatefulWidget {
  const SplashSCreen({super.key});

  @override
  State<SplashSCreen> createState() => _SplashSCreenState();
}

class _SplashSCreenState extends State<SplashSCreen> {
  SplashService splasService = SplashService();

  @override
  void initState() {
    super.initState();
    splasService.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    
    return Scaffold(
      backgroundColor: primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Manage your expense',
              style: TxtStyle.headLineStyle3,
            ),
            Text(
              'Effectively',
              style: TxtStyle.headLineStyle3.copyWith(color: Colors.blueGrey),
            ),

            SizedBox(height: height * 0.05,),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: height * 0.05),
              child: LinearPercentIndicator(
                  animation: true,
                  animationDuration: 2400,
                  lineHeight: 30.0,
                  percent: 1.0,
                  center: Text("Loading...",style: TxtStyle.headLineStyle4.copyWith(color: Colors.white)),
                  // linearStrokeCap: LinearStrokeCap.round,
                  barRadius: Radius.circular(20),
                  progressColor: Colors.blue,
                  backgroundColor: Colors.cyan,
              ),
            ),

          ],
        ),
      ),
    );
  }
}
