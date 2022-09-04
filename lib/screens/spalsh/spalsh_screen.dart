import 'package:flutter/material.dart';
import 'package:money_tracker_app/services/spalsh_service.dart';
import 'package:money_tracker_app/utils/txt_style.dart';

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
    return Scaffold(
      backgroundColor: primary,
      
      body: Center(
        child: Text('Money Tracker', style: TxtStyle.headLineStyle3,),
      ),
    );
  }
}