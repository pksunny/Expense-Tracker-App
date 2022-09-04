// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:money_tracker_app/screens/expenses/Edit%20Update%20Expense/edit_expense.dart';
import 'package:money_tracker_app/screens/expenses/Add/add_expense.dart';
import 'package:money_tracker_app/screens/expenses/Add/add_income.dart';
import 'package:money_tracker_app/utils/txt_style.dart';
import 'package:money_tracker_app/widgets/custom_button.dart';
import 'package:money_tracker_app/widgets/custom_text_field.dart';

class EditExpenseScreen extends StatefulWidget {
  EditExpenseScreen({super.key, required this.expenseId, required this.expenseName, required this.expenseAmount});

  String expenseId;
  String expenseName;
  int expenseAmount;

  @override
  State<EditExpenseScreen> createState() => _AddIncomeExpenseState();
}

class _AddIncomeExpenseState extends State<EditExpenseScreen> {
  @override
  Widget build(BuildContext context) {

    TextEditingController controller = TextEditingController();

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return ListView(
        children: [
          Container(
            padding: EdgeInsets.all(3.5),
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            // ignore: sort_child_properties_last
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                
                // INCOME
                Container(
                  width: width * 0.85,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(50),
                      color: Colors.white),
                  child: Center(child: Text('Edit Expense')),
                ),
    
                // EXPENSE
                // Container(
                //   width: width * 0.4,
                //   padding: EdgeInsets.symmetric(vertical: 10),
                //   decoration: BoxDecoration(
                //       borderRadius:
                //           BorderRadius.horizontal(right: Radius.circular(50)),
                //       color: Colors.white70),
                //   child: Center(child: Text('Add Expense')),
                // ),
              ],
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: primary,
              // ignore: prefer_const_literals_to_create_immutables
              boxShadow: [
              BoxShadow(
                spreadRadius: -10,
                blurRadius: 17,
                offset: Offset(5, -10),
                color: Colors.white
              ),
              BoxShadow(
                spreadRadius: -2,
                blurRadius: 10,
                offset: Offset(7, 7),
                color: Color.fromRGBO(146, 182, 216, 1)
              ),
            ]
            ),
          ),

          // ADD Expense
          EditExpense(expenseId: widget.expenseId, expenseName: widget.expenseName, expenseAmount: widget.expenseAmount,)
          
        ],
      );
  }
}
