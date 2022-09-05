
// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_tracker_app/provider/auth_provider.dart';
import 'package:money_tracker_app/screens/dashboard/dashborad.dart';
import 'package:money_tracker_app/screens/login%20signup/login_screen.dart';
import 'package:provider/provider.dart';

class SplashService {

  void isLogin(BuildContext context){

    // AuthProvider authProvider = Provider.of<AuthProvider>(context);
    
    final auth = FirebaseAuth.instance;

    final user = auth.currentUser;

    if(FirebaseAuth.instance.currentUser != null){

      // Timer(Duration(seconds: 3), () => Get.off(() => DashBoard()));
      Timer(Duration(seconds: 3), () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashBoard())));
    } else {

      Timer(Duration(seconds: 3), () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen())));
    }

  }
}