// ---->>>> WITHOUT DATATABLE CHECKBOX <<<<---- //

// ignore_for_file: prefer_const_constructors, prefer_const_declarations

import 'package:flutter/material.dart';
import 'package:money_tracker_app/provider/auth_provider.dart';
import 'package:money_tracker_app/provider/expense_provider.dart';
import 'package:money_tracker_app/provider/income_provider.dart';
import 'package:money_tracker_app/screens/expenses/Edit%20Update%20Expense/edit_expense_screen.dart';
import 'package:money_tracker_app/screens/expenses/Edit%20Update%20Expense/edit_income.dart';
import 'package:money_tracker_app/screens/expenses/Edit%20Update%20Expense/edit_income_screen.dart';
import 'package:money_tracker_app/screens/expenses/Add/add_income_screen.dart';
import 'package:money_tracker_app/screens/expenses/pie_chart.dart';
import 'package:money_tracker_app/utils/txt_style.dart';
import 'package:provider/provider.dart';

class EditUpdateExpense extends StatefulWidget {
  const EditUpdateExpense({ Key? key}) : super(key: key);

  @override
  State<EditUpdateExpense> createState() => _EditExpenseState();
}

class _EditExpenseState extends State<EditUpdateExpense> {

  @override
  Widget build(BuildContext context) {
    
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    IncomeProvider incomeProvider = Provider.of(context);
    ExpenseProvider expenseProvider = Provider.of(context);
    AuthProvider authProvider = Provider.of(context);

    return Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Your Expenses', style: TxtStyle.headLineStyle3,),
        elevation: 0.0,
        backgroundColor: primary,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [

            //INCOME
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
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
              child: Column(
                children: [

                  Text('Income', style: TxtStyle.headLineStyle1.copyWith(color: Colors.black54),),
                  Divider(indent: width * 0.35, endIndent: width * 0.35, thickness: 2,),
              
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),

                    child: incomeProvider.incomeList.isEmpty ?
                    
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          
                          SizedBox(height: height * 0.03,),

                          Text("Currently you did'nt add any", style: TxtStyle.headLineStyle3,),
                          Text("Income!", style: TxtStyle.headLineStyle3.copyWith(color: Colors.blueGrey,),),
                          Icon(Icons.cancel_outlined, size: 50, color: Colors.blueGrey,),

                          SizedBox(height: height * 0.03,)
                        ],
                      )
                    
                    : DataTable(
                      columnSpacing: 35.0,
                      columns: [
                        DataColumn(label: Text('Income', style: TxtStyle.headLineStyle4.copyWith(color: Colors.black54),)),
                        DataColumn(label: Text('Amount', style: TxtStyle.headLineStyle4.copyWith(color: Colors.black54),)),
                        DataColumn(label: Text('Edit', style: TxtStyle.headLineStyle4.copyWith(color: Colors.black54),)),
                        DataColumn(label: Text('Delete', style: TxtStyle.headLineStyle4.copyWith(color: Colors.black54),)),
                      ],
                      rows: List.generate(incomeProvider.incomeList.length, (index) {
                        final income = incomeProvider.incomeList[index].incomeName;
                        final amount = '${incomeProvider.incomeList[index].incomeAmount} ${authProvider.userProfileData['currency']}';
                    
                        return DataRow(
                          cells: [
                          DataCell(Text(income)),
                          DataCell(Text(amount.toString())),
                          DataCell(
                            Icon(Icons.edit_outlined, color: Colors.blue,),
                            onTap: () {
                              showModalBottomSheet(
                                elevation: 10,
                                backgroundColor: primary,
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
                                    child: EditIncomeScreen(
                                      incomeId: incomeProvider.incomeList[index].incomeId, 
                                      incomeName: incomeProvider.incomeList[index].incomeName, 
                                      incomeAmount: incomeProvider.incomeList[index].incomeAmount,),
                                  );
                              });
                            }
                          ),
                          DataCell(
                            Icon(Icons.delete_forever, color: Colors.red,),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  backgroundColor: primary,
                                  title: Text("Income", style: TxtStyle.headLineStyle3),
                                  content: Text("Are you sure to delete this income?", style: TxtStyle.headLineStyle3),
                                  actions: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(ctx).pop();
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                color: primary,
                                                // ignore: prefer_const_literals_to_create_immutables
                                                boxShadow: [
                                                  BoxShadow(
                                                    spreadRadius: -8,
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
                                            child: Text('No', style: TxtStyle.headLineStyle3.copyWith(color: Colors.green.shade300)),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            incomeProvider.deleteIncome(incomeProvider.incomeList[index].incomeId);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                color: primary,
                                                // ignore: prefer_const_literals_to_create_immutables
                                                boxShadow: [
                                                  BoxShadow(
                                                    spreadRadius: -8,
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
                                            child: Text('Yes', style: TxtStyle.headLineStyle3.copyWith(color: Colors.red.shade300)),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            }
                          ),
                        ]
                        );
                      }
                      
                      ),
                    ),
                  ),

                ],
              ),
            ),

            // EXPENSE

            SizedBox(height: height * 0.05,),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                color: primary,
                // ignore: prefer_const_literals_to_create_immutables
                boxShadow: [
                BoxShadow(
                  spreadRadius: -10,
                  blurRadius: 17,
                  offset: Offset(5, 5),
                  color: Colors.white
                ),
                BoxShadow(
                  spreadRadius: -10,
                  blurRadius: 10,
                  offset: Offset(5, -10),
                  color: Color.fromRGBO(146, 182, 216, 1)
                ),
              ]
              ),
              child: Column(
                children: [

                  SizedBox(height: height * 0.02,),

                  Text('Expense', style: TxtStyle.headLineStyle1.copyWith(color: Colors.black54),),
                  Divider(indent: width * 0.35, endIndent: width * 0.35, thickness: 2,),
              
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),

                    child: expenseProvider.expenseList.isEmpty ?  
                    
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          
                          SizedBox(height: height * 0.03,),

                          Text("Currently you did'nt add any", style: TxtStyle.headLineStyle3,),
                          Text("Expense!", style: TxtStyle.headLineStyle3.copyWith(color: Colors.blueGrey,),),
                          Icon(Icons.cancel_outlined, size: 50, color: Colors.blueGrey,),

                          SizedBox(height: height * 0.03,)
                        ],
                      )
                    
                    : DataTable(
                      columnSpacing: 25.0,
                      columns: [
                        DataColumn(label: Text('Expense', style: TxtStyle.headLineStyle4.copyWith(color: Colors.black54),)),
                        DataColumn(label: Text('Amount', style: TxtStyle.headLineStyle4.copyWith(color: Colors.black54),)),
                        DataColumn(label: Text('Edit', style: TxtStyle.headLineStyle4.copyWith(color: Colors.black54),)),
                        DataColumn(label: Text('Delete', style: TxtStyle.headLineStyle4.copyWith(color: Colors.black54),)),
                      ],
                      rows: List.generate(expenseProvider.expenseList.length, (index) {
                        final expense = expenseProvider.expenseList[index].expenseName;
                        final amount = '${authProvider.userProfileData['currency']} ${expenseProvider.expenseList[index].expenseAmount}';
                    
                        return DataRow(
                          cells: [
                          DataCell(Text(expense)),
                          DataCell(Text(amount)),
                          DataCell(
                            Icon(Icons.edit_outlined, color: Colors.blue,),
                            onTap: () {
                              showModalBottomSheet(
                                elevation: 10,
                                backgroundColor: primary,
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
                                    child: EditExpenseScreen(
                                      expenseId: expenseProvider.expenseList[index].expenseId,
                                      expenseName: expenseProvider.expenseList[index].expenseName, 
                                      expenseAmount: expenseProvider.expenseList[index].expenseAmount
                                    ),
                                  );
                              });
                            }
                          ),
                          DataCell(
                            Icon(Icons.delete_forever, color: Colors.red,),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  backgroundColor: primary,
                                  title: Text("Expense", style: TxtStyle.headLineStyle3),
                                  content: Text("Are you sure to delete this expense?", style: TxtStyle.headLineStyle3),
                                  actions: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(ctx).pop();
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                color: primary,
                                                // ignore: prefer_const_literals_to_create_immutables
                                                boxShadow: [
                                                  BoxShadow(
                                                    spreadRadius: -8,
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
                                            child: Text('No', style: TxtStyle.headLineStyle3.copyWith(color: Colors.green.shade300)),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            expenseProvider.deleteExpense(expenseProvider.expenseList[index].expenseId);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                color: primary,
                                                // ignore: prefer_const_literals_to_create_immutables
                                                boxShadow: [
                                                  BoxShadow(
                                                    spreadRadius: -8,
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
                                            child: Text('Yes', style: TxtStyle.headLineStyle3.copyWith(color: Colors.red.shade300)),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            }
                          ),
                        ]
                        );
                      }
                      
                      ),
                    ),
                  ),

                ],
              ),
            ),
      
            
          ], 
        ),
          ),
      ),
    );
  } 
}



