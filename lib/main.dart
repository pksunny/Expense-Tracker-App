// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_tracker_app/provider/auth_provider.dart';
import 'package:money_tracker_app/provider/expense_provider.dart';
import 'package:money_tracker_app/provider/income_provider.dart';
import 'package:money_tracker_app/screens/dashboard/dashborad.dart';
import 'package:money_tracker_app/screens/expenses/Edit%20Update%20Expense/edit_update_expense.dart';
import 'package:money_tracker_app/screens/expenses/Add/add_income_screen.dart';
import 'package:money_tracker_app/screens/expenses/expenses.dart';
import 'package:money_tracker_app/screens/login%20signup/login_screen.dart';
import 'package:money_tracker_app/screens/login%20signup/signup_screen.dart';
import 'package:money_tracker_app/screens/spalsh/spalsh_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    final Future<FirebaseApp> _initilaization = Firebase.initializeApp();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => IncomeProvider()),
        ChangeNotifierProvider(create: (context) => ExpenseProvider()),
      ],

      child: GetMaterialApp (
      debugShowCheckedModeBanner: false,
      // initialRoute: RoutesName.signin,
      // onGenerateRoute: Routes.generateRoute,
      home: FutureBuilder(
          future: _initilaization,
          builder: ((context, snapshot) {
            if(snapshot.hasError){
              return Center(
                child: Text('Not Connected'),
              );
            }

            if(snapshot.connectionState == ConnectionState.done){
              return SplashSCreen();
              // return LoginDesignPage();
              // return Center(
              //   child: Text('Connected Successfully!'),
              // );
            }
            
            return Center(
              child: CircularProgressIndicator(),
            );
          })
          ),
    ),
    );
  }
}