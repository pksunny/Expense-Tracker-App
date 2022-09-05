// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:money_tracker_app/models/income_model.dart';
import 'package:money_tracker_app/provider/auth_provider.dart';
import 'package:money_tracker_app/provider/expense_provider.dart';
import 'package:money_tracker_app/provider/income_provider.dart';
import 'package:money_tracker_app/screens/dashboard/drawer_screen.dart';
import 'package:money_tracker_app/screens/dashboard/major_expenses_list_view.dart';
import 'package:money_tracker_app/screens/expenses/Add/add_expense_screen.dart';
import 'package:money_tracker_app/screens/expenses/Add/add_income_screen.dart';
import 'package:money_tracker_app/screens/expenses/expenses.dart';
import 'package:money_tracker_app/screens/expenses/list_view_data.dart';
import 'package:money_tracker_app/screens/expenses/pie_chart.dart';
import 'package:money_tracker_app/screens/expenses/pie_chart_data.dart';
import 'package:money_tracker_app/utils/txt_style.dart';
import 'package:money_tracker_app/widgets/app_double_text_widget.dart';
import 'package:money_tracker_app/widgets/custom_button.dart';
import 'package:money_tracker_app/widgets/custom_dashboard_button.dart';
import 'package:money_tracker_app/widgets/custom_progress_bar.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    IncomeProvider incomeProvider = Provider.of<IncomeProvider>(context, listen: false);
    incomeProvider.getIncome();

    ExpenseProvider expenseProvider = Provider.of<ExpenseProvider>(context, listen: false);
    expenseProvider.getExpense();
    expenseProvider.getMajorExpense();
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    AuthProvider authProvider = Provider.of(context);
    IncomeProvider incomeProvider = Provider.of(context);
    ExpenseProvider expenseProvider = Provider.of(context);

    authProvider.getUserProfileData();

    // FOR GETTING TOTAL INCOME
    int getTotalIncome()=> incomeProvider.incomeList.fold(0,(total, item) {
      int? price = item.incomeAmount;
      if(price!=null) return total+price;
      else return total; 
    });
    // print(getTotalIncome());

    // FOR GETTING TOTAL EXPENSE
    int getTotalExpense()=> expenseProvider.expenseList.fold(0,(total, item) {
      int? price = item.expenseAmount;
      if(price!=null) return total+price;
      else return total; 
    });
    // print(getTotalExpense());

    return Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
        title: Text('Dashboard', style: TxtStyle.headLineStyle3,),
        centerTitle: true,
        backgroundColor: primary,
        elevation: 0,
      ),
    
      drawer: DrawerScreen(),
    
      // floatingActionButton: SpeedDial(
      //   icon: Icons.add_circle_outline_rounded,
      //   activeIcon: Icons.add_circle_outline_rounded,
    
      //   elevation: 20,
      //   animatedIcon: AnimatedIcons.add_event,
      //   backgroundColor: Colors.white70,
      //   foregroundColor: Colors.blue,
      //   children: [
      //     SpeedDialChild(
      //       child: Icon(Icons.add_chart_rounded, color: Colors.blue,),
      //       label: 'Add Income',
      //       backgroundColor: Colors.white70,
      //       onTap: (){
      //         showModalBottomSheet(
      //           elevation: 10,
      //           backgroundColor: primary,
      //           // isScrollControlled: true,
      //           shape: RoundedRectangleBorder(
      //           borderRadius: BorderRadius.only(
      //             topLeft: Radius.circular(15),
      //             topRight: Radius.circular(15),
      //             )
      //           ),
      //           context: context,
      //           builder: (context) {
      //             return Padding(
      //               padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      //               child: AddIncomeScreen(),
      //             );
      //           });
      //       }
      //     ),
    
      //     SpeedDialChild(
      //       child: Icon(Icons.library_add_outlined, color: Colors.blue,),
      //       label: 'Add Expense',
      //       backgroundColor: Colors.white70,
      //       onTap: (){
      //         showModalBottomSheet(
      //               elevation: 10,
      //               backgroundColor: primary,
      //               shape: RoundedRectangleBorder(
      //                   borderRadius: BorderRadius.only(
      //                 topLeft: Radius.circular(15),
      //                 topRight: Radius.circular(15),
      //               )),
      //               context: context,
      //               builder: (context) {
      //                 return Padding(
      //                   padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      //                   child: AddExpenseScreen(),
      //                 );
      //               });
      //       }
      //     ),
      //   ],
      // ),
    
      body: WillPopScope(
        onWillPop: (){
          // Get.snackbar('', 'Press back button again to exit');
          return Future.value(true);
        },
        
        child: SafeArea(
          child: Column(
            children: [

              SizedBox(height: height * 0.04,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    CustomDashboardButton(
                      onTap: (){
                        showModalBottomSheet(
                          elevation: 10,
                          backgroundColor: primary,
                          // isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                            )
                          ),
                          context: context,
                          builder: (context) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                              child: AddIncomeScreen(),
                            );
                          });
                      }, 
                      text: 'Add Income'
                    ),

                    SizedBox(width: width * 0.05,),

                    CustomDashboardButton(
                      onTap: (){
                        showModalBottomSheet(
                          elevation: 10,
                          backgroundColor: primary,
                          // isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                            )
                          ),
                          context: context,
                          builder: (context) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                              child: AddExpenseScreen(),
                            );
                          });
                      }, 
                      text: 'Add Expense'
                    ),
                  ],
                ),
              ),
          
              SizedBox(height: height * 0.02,),
          
              // CUSTOM DOUBLE TEXT WIDGET
              AppDoubleTextWidget(
                bigText: 'Total Budget', 
                smallText: 'Expense', 
                onTap: (){}
              ),
          
              // CUSTOM DOUBLE TEXT WIDGET
              AppDoubleTextWidget(
                bigText: '${authProvider.userProfileData['currency']} ${getTotalIncome()}', 
                smallText: '${authProvider.userProfileData['currency']} ${getTotalExpense()}', 
                onTap: (){}
              ),
          
              SizedBox(height: height * 0.02,),
          
              // CUSTOM PROGRESS BAR
              CustomProgressBar(
                firstText: 'Total Budget', 
                secondText: '${authProvider.userProfileData['currency']} ${getTotalIncome()}', 
                currencyText: '${authProvider.userProfileData['currency']}', 
                progressColor: Colors.blueAccent.shade100,
                percent: 1.0,
              ),
          
              CustomProgressBar(
                firstText: 'Expense', 
                secondText: '${authProvider.userProfileData['currency']} ${getTotalExpense()}', 
                currencyText: '${authProvider.userProfileData['currency']}', 
                progressColor: Colors.redAccent.shade100,
                percent: 1.0,
              ),

              (getTotalIncome() - getTotalExpense()).isNegative ?

              CustomProgressBar(
                firstText: 'Warning', 
                // secondText: '${(getTotalExpense() * 100 / getTotalIncome()).toString()}' + '%', 
                secondText: "Expense overdue",
                currencyText: '${authProvider.userProfileData['currency']}', 
                progressColor: Colors.red,
                percent: (getTotalExpense() / getTotalIncome()) > 1 || (getTotalExpense() - getTotalIncome()) == 0 ? 1.0 : (getTotalExpense() / getTotalIncome()),
              )

              : CustomProgressBar(
                  firstText: 'Overall Use', 
                  // secondText: '${(getTotalExpense() * 100 / getTotalIncome()).toString()}' + '%', 
                  secondText: '${getTotalExpense()}',
                  currencyText: '${authProvider.userProfileData['currency']}', 
                  progressColor: Colors.teal.shade400,
                  percent: (getTotalExpense() / getTotalIncome()) > 1 || (getTotalExpense() - getTotalIncome()) == 0 ? 1.0 : (getTotalExpense() / getTotalIncome()),
                ),
          
              SizedBox(height: height * 0.02,),
          
              // CUSTOM DOUBLE TEXT WIDGET
              AppDoubleTextWidget(
                bigText: 'Remaining', 
                smallText: '${authProvider.userProfileData['currency']} ${(getTotalIncome() - getTotalExpense()) > getTotalIncome() ? '' : getTotalIncome() - getTotalExpense()}', 
                onTap: (){}
              ),
          
              SizedBox(height: height * 0.02,),
          
              Align(
                alignment: Alignment.center,
                child: Text('Major Expenses', style: TxtStyle.headLineStyle2.copyWith(color: Colors.black54),)
              ),
          
              Divider(indent: 90, endIndent: 90, thickness: 2, color: Colors.red,),
          
              SizedBox(height: height * 0.02,),
          
              // MAJOR EXPENSES LIST VIEW
              MajorExpensesListView(),
              
            ],
          ),
        ),
      ),
    );
  }
}