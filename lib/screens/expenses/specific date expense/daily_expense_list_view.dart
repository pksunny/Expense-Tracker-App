import 'package:flutter/material.dart';

// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_tracker_app/models/income_model.dart';
import 'package:money_tracker_app/provider/auth_provider.dart';
import 'package:money_tracker_app/provider/expense_provider.dart';
import 'package:money_tracker_app/provider/income_provider.dart';
import 'package:money_tracker_app/screens/expenses/expenses.dart';
import 'package:money_tracker_app/screens/expenses/pie_chart.dart';
import 'package:money_tracker_app/screens/expenses/pie_chart_data.dart';
import 'package:money_tracker_app/utils/txt_style.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

// DAILY EXPENSE
double dailyAmount = 0.0;

class DailyExpenseListView extends StatefulWidget {
  const DailyExpenseListView({super.key});

  @override
  State<DailyExpenseListView> createState() => _DailyExpenseListViewState();
}

class _DailyExpenseListViewState extends State<DailyExpenseListView> {

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   getSum();
  // }


  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    ExpenseProvider expenseProvider = Provider.of(context);
    IncomeProvider incomeProvider = Provider.of(context);
    AuthProvider authProvider = Provider.of(context);

    // FOR GETTING TOTAL INCOME
    int getTotalIncome()=> incomeProvider.incomeList.fold(0,(total, item) {
      int? price = item.incomeAmount;
      if(price!=null) return total+price;
      else return total; 
    });


    // FOR GETTING DAILY TOTAL EXPENSE
    int getTotalExpense()=> expenseProvider.dailyExpenseList.fold(0,(total, item) {
      int? price = item.expenseAmount;
      if(price!=null) return total+price;
      else return total; 
    });

    return Expanded(
      child: expenseProvider.dailyExpenseList.isEmpty ?

      Container(
        width: width * 0.9,
        margin: EdgeInsets.symmetric(vertical: height * 0.2),
        decoration: BoxDecoration(
          color: Color.fromRGBO(193, 214, 233, 1),
          borderRadius: BorderRadius.circular(15),
            // ignore: prefer_const_literals_to_create_immutables
            boxShadow: [
              BoxShadow(
                spreadRadius: -10,
                blurRadius: 17,
                offset: Offset(5, -10),
                color: Colors.white),
                BoxShadow(
                  spreadRadius: -2,
                  blurRadius: 10,
                  offset: Offset(7, 7),
                  color: Color.fromRGBO(146, 182, 216, 1)),
            ]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(DateFormat.yMMMMd().format(expenseProvider.completeDateTime), style: TxtStyle.headLineStyle3,),
            Text('NO EXPENSE ON THIS DATE', style: TxtStyle.headLineStyle3,),
            Icon(Icons.cancel_outlined, size: 50, color: Colors.blueGrey,),
          ],
        ),
      )

      : ListView.builder(
        itemCount: expenseProvider.dailyExpenseList.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 10,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomRight: Radius.circular(15))),
            child: Container(
              decoration: BoxDecoration(
                  color: Color.fromRGBO(193, 214, 233, 1),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomRight: Radius.circular(15)),

                  // ignore: prefer_const_literals_to_create_immutables
                  boxShadow: [
                    BoxShadow(
                        spreadRadius: -10,
                        blurRadius: 17,
                        offset: Offset(-5, -5),
                        color: Colors.white),
                    BoxShadow(
                        spreadRadius: -2,
                        blurRadius: 10,
                        offset: Offset(3, 10),
                        color: Color.fromRGBO(146, 182, 216, 1)),
                  ]),
              child: ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                leading: Container(
                  padding: EdgeInsets.only(right: 12.0),
                  decoration: BoxDecoration(
                      border: Border(
                          right: BorderSide(
                              width: 1.0, color: kNeumorphicColors[index]))),
                  child: Text(authProvider.userProfileData['currency'],style: TxtStyle.headLineStyle3.copyWith(color: kNeumorphicColors[index]),),
                ),
                title: Text(
                  expenseProvider.dailyExpenseList[index].expenseName,
                  style: TxtStyle.headLineStyle3.copyWith(color: Colors.white),
                ),
                // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                subtitle: Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    // Icon(Icons.linear_scale,
                    //     color: kNeumorphicColors[index]),

                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: LinearPercentIndicator(
                          animation: true,
                          animationDuration: 2000,
                          lineHeight: 20.0,
                          percent: (expenseProvider.dailyExpenseList[index].expenseAmount / getTotalIncome()) > 1 ? 1.0 : (expenseProvider.dailyExpenseList[index].expenseAmount / getTotalIncome()),
                          // percent: 1.0,
                          center: Text(
                              "${(expenseProvider.dailyExpenseList[index].expenseAmount * 100 / getTotalIncome())}".substring(0, 5) + "%",
                              style: TxtStyle.headLineStyle4
                                  .copyWith(color: Colors.white)),
                          // linearStrokeCap: LinearStrokeCap.round,
                          barRadius: Radius.circular(20),
                          progressColor: Colors.redAccent.shade100,
                          backgroundColor: kNeumorphicColors[index]),
                    )),
                  ],
                ),

                trailing: Stack(
                  children: [
                    Container(
                      width: width * 0.2,
                      // color: Colors.black,
                      child: Center(
                        child: Text('${authProvider.userProfileData['currency']} ${expenseProvider.dailyExpenseList[index].expenseAmount}',
                            style: TxtStyle.headLineStyle3
                                .copyWith(color: Colors.white)),
                      ),
                    ),
                    Positioned(
                      // top: 20,
                      bottom: -8,
                      right: -13,

                      child: Container(
                        width: width * 0.1,
                        height: height * 0.03,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.fromBorderSide(BorderSide(
                                color:
                                    kNeumorphicColors[index].withOpacity(0.3),
                                width: 5))),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
