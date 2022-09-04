// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_tracker_app/provider/auth_provider.dart';
import 'package:money_tracker_app/provider/expense_provider.dart';
import 'package:money_tracker_app/provider/income_provider.dart';
import 'package:money_tracker_app/screens/dashboard/drawer_screen.dart';
import 'package:money_tracker_app/screens/dashboard/major_expenses_list_view.dart';
import 'package:money_tracker_app/screens/expenses/expenses.dart';
import 'package:money_tracker_app/screens/expenses/list_view_data.dart';
import 'package:money_tracker_app/screens/expenses/pie_chart.dart';
import 'package:money_tracker_app/screens/expenses/pie_chart_data.dart';
import 'package:money_tracker_app/screens/expenses/specific%20date%20expense/daily_expense_list_view.dart';
import 'package:money_tracker_app/utils/txt_style.dart';
import 'package:money_tracker_app/widgets/app_double_text_widget.dart';
import 'package:money_tracker_app/widgets/custom_button.dart';
import 'package:money_tracker_app/widgets/custom_progress_bar.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class DailyExpense extends StatefulWidget {
  const DailyExpense({super.key});

  @override
  State<DailyExpense> createState() => _DailyExpenseState();
}

class _DailyExpenseState extends State<DailyExpense> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    IncomeProvider incomeProvider = Provider.of<IncomeProvider>(context, listen: false);
    incomeProvider.getIncome();

    ExpenseProvider expenseProvider = Provider.of<ExpenseProvider>(context, listen: false);
    expenseProvider.getExpense();
    expenseProvider.getDailyExpense();
  }

  DateTime dateTime = DateTime.now();

  void _showDatePicker(){

    showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(2000), 
      lastDate: DateTime(2025),
    ).then((value) {
      setState(() {
        dateTime = value!;
        Get.to(() => DailyExpense());
      });
    });
  }


  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    AuthProvider authProvider = Provider.of(context);
    IncomeProvider incomeProvider = Provider.of(context);
    ExpenseProvider expenseProvider = Provider.of(context);

    expenseProvider.getDailyExpense();

    expenseProvider.completeDateTime = dateTime;
    // print('Expense Prvider Complete Date Time is :${expenseProvider.completeDateTime}');

    // print('Daily Expense List ${expenseProvider.dailyExpenseList.length}');

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

    // FOR GETTING DAILY TOTAL EXPENSE
    int getDailyTotalExpense()=> expenseProvider.dailyExpenseList.fold(0,(total, item) {
      int? price = item.expenseAmount;
      if(price!=null) return total+price;
      else return total; 
    });

    print('Daily Expense Total is ${getDailyTotalExpense()}');

    return Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
        title: Text('DailyExpense', style: TxtStyle.headLineStyle3,),
        centerTitle: true,
        backgroundColor: primary,
        elevation: 0,

        // leading: IconButton(
        //   onPressed: (){
        //     Get.to(() => Expenses());
        //   }, 
        //   icon: Icon(Icons.arrow_back, color: TxtStyle.textColor,)
        // ),
      ),

      drawer: DrawerScreen(),

      body: SafeArea(
        child: Column(
          children: [

            SizedBox(height: height * 0.05,),

            // CUSTOM DOUBLE TEXT WIDGET
            AppDoubleTextWidget(
              bigText: 'Total Budget', 
              smallText: 'Expense', 
              onTap: (){}
            ),

            // // CUSTOM DOUBLE TEXT WIDGET
            AppDoubleTextWidget(
              bigText: '${authProvider.userProfileData['currency']} ${getTotalIncome()}', 
              smallText: '${authProvider.userProfileData['currency']} ${getTotalExpense()}', 
              onTap: (){}
            ),

            // SizedBox(height: height * 0.02,),

            // // CUSTOM PROGRESS BAR
            // CustomProgressBar(
            //   firstText: 'Total Budget', 
            //   secondText: '7500', 
            //   icon: Icons.attach_money_rounded, 
            //   progressColor: Colors.blueAccent.shade100,
            //   percent: 1.0,
            // ),

            // CustomProgressBar(
            //   firstText: 'Expense', 
            //   secondText: '6340', 
            //   icon: Icons.attach_money_rounded, 
            //   progressColor: Colors.redAccent.shade100,
            //   percent: 1.0,
            // ),

            // CustomProgressBar(
            //   firstText: 'Overall Use', 
            //   secondText: '${6340 * 100 / 7500}'.substring(0, 5) + '%', 
            //   icon: Icons.attach_money_rounded, 
            //   progressColor: Colors.teal.shade400,
            //   percent: 6340 / 7500,
            // ),

            // SizedBox(height: height * 0.02,),

            // // CUSTOM DOUBLE TEXT WIDGET
            // AppDoubleTextWidget(
            //   bigText: 'Remaining', 
            //   smallText: '\$${7500 - 6340}', 
            //   onTap: (){}
            // ),

            SizedBox(height: height * 0.02,),

            // CHOOSE DATE PICKER
            Center(
              child: CustomButton(
                onTap: (){
                  _showDatePicker();
                  // Get.to(() => Expenses());
                }, 
                text: 'Choose Date'
              ),
            ),
            // Divider(indent: 90, endIndent: 90, thickness: 2, color: Colors.red,),

            SizedBox(height: height * 0.02,),

            // Text(expenseProvider.completeDateTime.toString().substring(0, 10), style: TxtStyle.headLineStyle3,),
            Text(DateFormat.yMMMMd().format(expenseProvider.completeDateTime), style: TxtStyle.headLineStyle3,),

            SizedBox(height: height * 0.02,),

            // CUSTOM DOUBLE TEXT WIDGET
            AppDoubleTextWidget(
              bigText: 'Daily Expense', 
              smallText: '${authProvider.userProfileData['currency']} ${getDailyTotalExpense()}', 
              onTap: (){}
            ),

            SizedBox(height: height * 0.02,),

            // MAJOR EXPENSES LIST VIEW
            DailyExpenseListView()
            
          ],
        ),
      ),
    );
  }
}