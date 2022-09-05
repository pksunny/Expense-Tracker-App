import 'package:flutter/material.dart';

// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_tracker_app/provider/auth_provider.dart';
import 'package:money_tracker_app/provider/expense_provider.dart';
import 'package:money_tracker_app/provider/income_provider.dart';
import 'package:money_tracker_app/screens/expenses/expenses.dart';
import 'package:money_tracker_app/screens/expenses/pie_chart.dart';
import 'package:money_tracker_app/screens/expenses/pie_chart_data.dart';
import 'package:money_tracker_app/utils/txt_style.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class MajorExpensesListView extends StatefulWidget {
  const MajorExpensesListView({super.key});

  @override
  State<MajorExpensesListView> createState() => _MajorExpensesListViewState();
}

class _MajorExpensesListViewState extends State<MajorExpensesListView> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    IncomeProvider incomeProvider = Provider.of<IncomeProvider>(context, listen: false);
    incomeProvider.getIncome();

    ExpenseProvider expenseProvider = Provider.of<ExpenseProvider>(context, listen: false);
    expenseProvider.getMajorExpense();
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    AuthProvider authProvider = Provider.of(context);
    IncomeProvider incomeProvider = Provider.of(context);
    ExpenseProvider expenseProvider = Provider.of(context);

    // FOR GETTING TOTAL INCOME
    int getTotalIncome()=> incomeProvider.incomeList.fold(0,(total, item) {
      int? price = item.incomeAmount;
      if(price!=null) return total+price;
      else return total; 
    });
    // print(getTotalIncome());


    return Expanded(
      child: expenseProvider.majorExpenseList.isEmpty ?

      Container(
        width: width * 0.9,
        margin: EdgeInsets.symmetric(vertical: height * 0.05),
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
            Text("Currently you don't have any", style: TxtStyle.headLineStyle3,),
            Text("Major Expense!", style: TxtStyle.headLineStyle3.copyWith(color: Colors.blueGrey,),),
            Icon(Icons.cancel_outlined, size: 50, color: Colors.blueGrey,),
          ],
        ),
      ) 

      :
      
      ListView.builder(
        itemCount: expenseProvider.majorExpenseList.length,
        itemBuilder: (context, index) {
          if(expenseProvider.majorExpenseList.length == 0){
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
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
                  child: Text(authProvider.userProfileData['currency'], style: TxtStyle.headLineStyle4.copyWith(color: kNeumorphicColors[index]),),
                ),
                title: Text(
                  expenseProvider.majorExpenseList[index].expenseName,
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
                          percent: (expenseProvider.majorExpenseList[index].expenseAmount / getTotalIncome()) > 1 ? 1.0 : (expenseProvider.majorExpenseList[index].expenseAmount / getTotalIncome()),
                          // percent: 1.0,
                          center: Text(
                              "${(expenseProvider.majorExpenseList[index].expenseAmount * 100 / getTotalIncome()).toString() == 'Infinity' ? '+100' : (expenseProvider.majorExpenseList[index].expenseAmount * 100 / getTotalIncome()).toString().substring(0, 4)}" + "%",
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
                        child: Text('${authProvider.userProfileData['currency']} ${expenseProvider.majorExpenseList[index].expenseAmount}',
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

          }
        },
      ),
    );
  }
}
