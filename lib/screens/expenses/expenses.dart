// ignore_for_file: prefer_const_constructors, prefer_const_declarations, sort_child_properties_last

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:money_tracker_app/provider/auth_provider.dart';
import 'package:money_tracker_app/provider/expense_provider.dart';
import 'package:money_tracker_app/provider/income_provider.dart';
import 'package:money_tracker_app/screens/expenses/Add/add_expense_screen.dart';
import 'package:money_tracker_app/screens/expenses/Add/add_income.dart';
import 'package:money_tracker_app/screens/expenses/Add/add_income_screen.dart';
import 'package:money_tracker_app/screens/expenses/list_view_data.dart';
import 'package:money_tracker_app/screens/expenses/pie_chart.dart';
import 'package:money_tracker_app/screens/expenses/pie_chart_data.dart';
import 'package:money_tracker_app/utils/txt_style.dart';
import 'package:money_tracker_app/widgets/app_double_text_widget.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

// GLOBAL VAR FOR WIDTH & HEIGHT
// double? width;
// double? height;

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    IncomeProvider incomeProvider = Provider.of<IncomeProvider>(context, listen: false);
    incomeProvider.getIncome();

    ExpenseProvider expenseProvider = Provider.of<ExpenseProvider>(context, listen: false);
    expenseProvider.getExpense();
  }
  
  @override
  Widget build(BuildContext context) {

    final scaffoldKey = GlobalKey<ScaffoldState>();

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    AuthProvider authProvider = Provider.of(context);
    IncomeProvider incomeProvider = Provider.of(context);
    ExpenseProvider expenseProvider = Provider.of(context);

    //  FOR GETTING TOTAL INCOME
    int getTotalIncome()=> incomeProvider.incomeList.fold(0,(total, item) {
      int? price = item.incomeAmount;
      if(price!=null) return total+price;
      else return total; 
    });

    // FOR GETTING TOTAL EXPENSE
    int getTotalExpense()=> expenseProvider.expenseList.fold(0,(total, item) {
      int? price = item.expenseAmount;
      if(price!=null) return total+price;
      else return total; 
    });

    DateTime dateTime;

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: primary,
      resizeToAvoidBottomInset: true,

      body: SafeArea(
        child: Column(
          children: [

            SizedBox(
              height: height * 0.40,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: height * 0.02,
                    ),
      
                    Text('Monthly Expenses', style: TxtStyle.headLineStyle3),
      
                    SizedBox(height: height * 0.02,),
      
                    // PIE CHART BG CLASS
                    PieChartBG(),
                  ],
                ),
              ),
            ),
      
            SizedBox(height: height * 0.02,),

            // CUSTOM DOUBLE TEXT WIDGET
            AppDoubleTextWidget(
              bigText: 'Total Income', 
              smallText: '${authProvider.userProfileData['currency']} ${getTotalIncome()}', 
              onTap: (){}
            ),

            // CUSTOM DOUBLE TEXT WIDGET
            AppDoubleTextWidget(
              bigText: 'Total Expense', 
              smallText: '${authProvider.userProfileData['currency']} ${getTotalExpense()}', 
              onTap: (){}
            ),

            // CUSTOM DOUBLE TEXT WIDGET
            AppDoubleTextWidget(
              bigText: 'Remaining', 
              smallText: '${authProvider.userProfileData['currency']} ${getTotalIncome() - getTotalExpense()}', 
              onTap: (){}
            ),

            SizedBox(height: height * 0.02,),

            // LIST VIEW DATA CLASS
            ListViewData(),
            
          ],
        ),
      ),
    );
  }
}
