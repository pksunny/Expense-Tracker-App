// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_tracker_app/provider/auth_provider.dart';
import 'package:money_tracker_app/screens/dashboard/dashborad.dart';
import 'package:money_tracker_app/screens/dashboard/drawer_screen.dart';
import 'package:money_tracker_app/screens/expenses/expenses.dart';
import 'package:money_tracker_app/screens/expenses/specific%20date%20expense/daily_expense.dart';
import 'package:money_tracker_app/screens/login%20signup/login_screen.dart';
import 'package:money_tracker_app/screens/profile/currency%20edit/edit_currency.dart';
import 'package:money_tracker_app/screens/profile/currency%20edit/edit_currency_screen.dart';
import 'package:money_tracker_app/utils/txt_style.dart';
import 'package:money_tracker_app/widgets/custom_drawer_list_tile.dart';
import 'package:provider/provider.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    AuthProvider authProvider = Provider.of(context);

    authProvider.getUserProfileData();

    return Scaffold(
      backgroundColor: primary,
      drawer: DrawerScreen(),
      appBar: AppBar(
        backgroundColor: primary,
        elevation: 0.0,
        title: Text('My Profile', style: TxtStyle.headLineStyle3,),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: height * 0.1,
                  color: primary,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: primary,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50)
                      ),
                      // ignore: prefer_const_literals_to_create_immutables
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: -5,
                          blurRadius: 17,
                          offset: Offset(5, -10),
                          color: Colors.white
                        ),
                        BoxShadow(
                          spreadRadius: -5,
                          blurRadius: 17,
                          offset: Offset(5, 10),
                          color: Color.fromRGBO(146, 182, 216, 1)
                        ),
                      ]
                    ),
                    child: ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [

                            SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [

                                // SizedBox(width: 50,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [

                                        Text('Email: ', style: TxtStyle.headLineStyle3,),
                                        Text('${authProvider.userProfileData['email']}', style: TxtStyle.headLineStyle3.copyWith(color: Colors.blueGrey)),
                                      ],
                                    ),
                                    
                                    Row(
                                      children: [

                                        Text('Currency: ', style: TxtStyle.headLineStyle3,),
                                        Text('${authProvider.userProfileData['currency']}', style: TxtStyle.headLineStyle3.copyWith(color: Colors.blueGrey)),

                                        InkWell(
                                          child: CircleAvatar(
                                            radius: 15,
                                            backgroundColor: primary,
                                            child: Icon(Icons.edit, size: 20,),
                                          ),
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
                                                  child: EditCurrencyScreen(
                                                    userListId: authProvider.userProfileData['userListId'], 
                                                    userEmail: authProvider.userProfileData['email'], 
                                                    userCurrency: authProvider.userProfileData['currency']
                                                  ),
                                                );
                                              });
                                          },
                                        )
                                      ],
                                    )
                                  ],
                                ),

                                // CircleAvatar(
                                //   radius: 20,
                                //   backgroundColor: Colors.teal,
                                //   child: Icon(
                                //     Icons.edit,
                                //     color: Colors.white,
                                //   ),
                                // ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(
                              height: 1,
                            ),
                            CustomDrawerListTile(
                              icon: Icons.dashboard_sharp,
                              title: 'Dashboard',
                              onTap: () {
                                Get.to(() => DashBoard());
                              }
                            ),
                            CustomDrawerListTile(
                              icon: Icons.assignment_outlined,
                              title: 'Your Daily Expense',
                              onTap: () {
                                Get.to(() => DailyExpense());
                              }
                            ),
                            CustomDrawerListTile(
                              icon: Icons.auto_graph,
                              title: 'Your Monthly Expense',
                              onTap: () {
                                Get.to(() => Expenses());
                              }
                            ),
                            
                            CustomDrawerListTile(
                              icon: Icons.login_outlined,
                              title: 'Logout',
                              onTap: () {
                                authProvider.signOut();
                              }
                            ),
                            
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            // Positioned(
            //   top: height * 0.1,
            //   left: width * 0.1,
            //   child: CircleAvatar(
            //     radius: 55,
            //     backgroundColor: Colors.black38,
            //     child: CircleAvatar(
            //       radius: 50,
            //       backgroundColor: primary,
            //       backgroundImage: AssetImage("assets/images/logo.png"),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
