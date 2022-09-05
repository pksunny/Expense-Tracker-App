// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker_app/models/expense_model.dart';
import 'package:money_tracker_app/provider/expense_provider.dart';
import 'package:provider/provider.dart';

class PieChart extends CustomPainter{

  List<ExpenseModel> expenseModel;
  final double chartWidth;

  PieChart({required this.expenseModel, required this.chartWidth});

  @override
  void paint(Canvas canvas, Size size){

    Offset center =  Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);

    var paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = chartWidth / 2;

    double total = 0;
    expenseModel.forEach((expense) => total += expense.expenseAmount);

    double startRadian = -pi / 2;

    for(var index = 0; index < expenseModel.length; index++){

      final currentCategory = expenseModel.elementAt(index);
      final sweepRadian = currentCategory.expenseAmount / total * 2 * pi;
      paint.color = kNeumorphicColors.elementAt(index % expenseModel.length);
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius), 
        startRadian, 
        sweepRadian, 
        false, 
        paint
      );
      startRadian += sweepRadian;
    }

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class Category{
  String name;
  double amount;

  Category({required this.name, required this.amount});
}

final kCategories = [
  Category(name: 'Grocery', amount: 700.00),
  Category(name: 'Online Shopping', amount: 400.00),
  Category(name: 'Eating', amount: 1100.00),
  Category(name: 'Bills', amount: 100.00),
  Category(name: 'School fee', amount: 150.00),
  Category(name: 'Travel', amount: 200.00),
  Category(name: 'Shopping', amount: 50.00),
  Category(name: 'Subscription', amount: 40.00),
  Category(name: 'Fee', amount: 10.00),
  Category(name: 'Other', amount: 20.00),
];

final kNeumorphicColors = [
  Colors.purple.withOpacity(0.9),
  Colors.blueAccent.withOpacity(0.9),
  Colors.brown.withOpacity(0.9),
  Colors.pinkAccent.withOpacity(0.9),
  Colors.blueGrey.withOpacity(0.9),
  Colors.cyan.withOpacity(0.9),
  Colors.deepPurple.withOpacity(0.9),
  Colors.green.withOpacity(0.9),
  Colors.indigo.withOpacity(0.9),
  Colors.lightGreen.withOpacity(0.9),
  Colors.lime.withOpacity(0.9),
  Colors.orange.withOpacity(0.9),
  Colors.pink.withOpacity(0.9),
  Colors.purpleAccent.withOpacity(0.9),
  Colors.deepPurpleAccent.withOpacity(0.9),
  Colors.red.withOpacity(0.9),
  Colors.teal.withOpacity(0.9),
  // Color.fromRGBO(46, 198, 255, 1).withOpacity(0.9),
  // Color.fromRGBO(123, 201, 82, 1).withOpacity(0.9),
  // Color.fromRGBO(255, 171, 67, 1).withOpacity(0.9),
  // Color.fromRGBO(252, 91, 57, 1).withOpacity(0.9),
  // Color.fromRGBO(139, 135, 130, 1).withOpacity(0.9),
  // Color.fromARGB(255, 255, 199, 46).withOpacity(0.9),
  // Color.fromARGB(255, 99, 235, 27).withOpacity(0.9),
  // Color.fromARGB(255, 17, 231, 213).withOpacity(0.9),
  // Color.fromARGB(255, 196, 3, 255).withOpacity(0.9),
  // Color.fromARGB(255, 255, 0, 157).withOpacity(0.9),
];