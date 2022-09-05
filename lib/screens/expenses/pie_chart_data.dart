// ignore_for_file: prefer_const_constructors, sort_child_properties_last, unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_tracker_app/provider/auth_provider.dart';
import 'package:money_tracker_app/provider/expense_provider.dart';
import 'package:money_tracker_app/provider/income_provider.dart';
import 'package:money_tracker_app/screens/dashboard/dashborad.dart';
import 'package:money_tracker_app/screens/expenses/expenses.dart';
import 'package:money_tracker_app/screens/expenses/pie_chart.dart';
import 'package:money_tracker_app/utils/txt_style.dart';
import 'package:provider/provider.dart';

// GLOBAL TOTAL AMOUNT VAR
double totalAmount = 0;

class PieChartBG extends StatefulWidget {
  const PieChartBG({super.key});

  @override
  State<PieChartBG> createState() => _PieChartBGState();
}

class _PieChartBGState extends State<PieChartBG> {

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    AuthProvider authProvider = Provider.of(context);
    ExpenseProvider expenseProvider = Provider.of(context);

    // FOR GETTING TOTAL EXPENSE
    int getTotalExpense()=> expenseProvider.expenseList.fold(0,(total, item) {
      int? price = item.expenseAmount;
      if(price!=null) return total+price;
      else return total; 
    });
    print(getTotalExpense());

    return Expanded(
      flex: 4,
      child: LayoutBuilder(
        builder: (context, index){
          return Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(193, 214, 233, 1),
              shape: BoxShape.circle,
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
            child: Stack(
              children: [
                Center(
                  child: SizedBox(
                    width: width * 0.5,
                    child: CustomPaint(
                      child: Center(),
                      // PIE CHART CLASS
                      foregroundPainter: PieChart(
                        expenseModel: expenseProvider.expenseList, 
                        chartWidth: width * 0.3,
                      ),
                    ),
                  ),
                ),

                InkWell(
                   onTap: () {
                    Get.to(() => DashBoard());
                    setState(() {
                      totalAmount = 0;
                    });
                  },
                  child: Center(
                    child: Container(
                      height: height * 0.12,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(193, 214, 233, 1),
                        shape: BoxShape.circle,
                        // ignore: prefer_const_literals_to_create_immutables
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 1,
                            offset: Offset(-1, -1),
                            color: Colors.white
                          ),
                          BoxShadow(
                            spreadRadius: -2,
                            blurRadius: 10,
                            offset: Offset(5, 5),
                            color: Colors.black.withOpacity(0.5),
                          )
                        ]
                      ),
                      child: Center(
                        child: Text('${authProvider.userProfileData['currency']}' + '\n' + '${getTotalExpense()}', style: TxtStyle.headLineStyle4, textAlign: TextAlign.center),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}