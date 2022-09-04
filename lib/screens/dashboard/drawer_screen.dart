// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_tracker_app/provider/auth_provider.dart';
import 'package:money_tracker_app/screens/dashboard/dashborad.dart';
import 'package:money_tracker_app/screens/expenses/Edit%20Update%20Expense/edit_update_expense.dart';
import 'package:money_tracker_app/screens/expenses/expenses.dart';
import 'package:money_tracker_app/screens/expenses/specific%20date%20expense/daily_expense.dart';
import 'package:money_tracker_app/screens/profile/my_profile.dart';
import 'package:money_tracker_app/utils/txt_style.dart';
import 'package:money_tracker_app/widgets/custom_drawer_list_tile.dart';
import 'package:provider/provider.dart';

class DrawerScreen extends StatefulWidget {
  DrawerScreen({super.key,});

  // FirebaseAuthMethods? firebaseAuthMethods;

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // AuthProvider authProvider = Provider.of(context);
    // authProvider.getUserProfileData();

  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    AuthProvider authProvider = Provider.of(context);

    authProvider.getUserProfileData();

    return Drawer(
      backgroundColor: primary,
      child: SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
            color: primary,
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
          ]
          ),
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: primary),
                child: Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    // CircleAvatar(
                    //   backgroundColor: Colors.black38,
                    //   radius: 45,
                    //   child: CircleAvatar(
                    //     radius: 40,
                    //     backgroundColor: primary,
                    //     backgroundImage: AssetImage("assets/images/lives.png"),
                    //   ),
                    // ),
                    // SizedBox(
                    //   width: width * 0.02,
                    // ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome',
                          style: TxtStyle.headLineStyle1.copyWith(color: Colors.black54),
                        ),
      
                        SizedBox(
                          height: height * 0.02,
                        ),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text(authProvider.userProfileData['email'], style: TxtStyle.headLineStyle3.copyWith(color: Colors.blueGrey),),
                            Text('currency: ${authProvider.userProfileData['currency']}', style: TxtStyle.headLineStyle3.copyWith(color: Colors.blueGrey)),
                          ]
                              
                        ),
                        // FOR DISPLAY USER PROFILE DATA
                        // Column(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children:
                        //       firebaseAuthMethods.getUserProfileList.map((e) {
                        //     return profileColumn(
                        //       e.user_name,
                        //       e.email,
                        //     );
                        //   }).toList(),
                        // )
      
                        // Container(
                        //   height: ScreenSize(context).height * 0.05,
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(15),
                        //     border: Border.all(color: Colors.white, width: 2),
                        //   ),
                        //   child: OutlinedButton(
                        //     onPressed: (){},
                        //     child: Text('Login', style: TextStylz.drawerLoginName,),
      
                        //   ),
      
                        // )
                      ],
                    )
                  ],
                ),
              ),
              CustomDrawerListTile(
                icon: Icons.space_dashboard_rounded,
                title: 'Dashboard',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DashBoard()));
                },
              ),
              CustomDrawerListTile(
                icon: Icons.graphic_eq_rounded,
                title: 'Expense Graph',
                onTap: () {
                  Get.to(Expenses());
                },
              ),
              CustomDrawerListTile(
                icon: Icons.edit_calendar_outlined,
                title: 'Edit Expense',
                onTap: () {
                  Get.to(() => EditUpdateExpense());
                },
              ),
              CustomDrawerListTile(
                icon: Icons.calendar_month_outlined,
                title: 'Daily Expense',
                onTap: () {
                  Get.to(() => DailyExpense());
                },
              ),
              CustomDrawerListTile(
                icon: Icons.person,
                title: 'My Profile',
                onTap: () {
                  Get.to(() => MyProfile());
                },
              ),
              // CustomDrawerListTile(
              //   icon: Icons.notifications_active_outlined,
              //   title: 'Notifications',
              //   onTap: () {},
              // ),
              // CustomDrawerListTile(
              //   icon: Icons.star_border,
              //   title: 'Rating & Review',
              //   onTap: () {},
              // ),
              // CustomDrawerListTile(
              //   icon: Icons.favorite_border,
              //   title: 'Wishlist',
              //   onTap: () {
              //     // Get.to(() => WishList());
              //   },
              // ),
              // CustomDrawerListTile(
              //   icon: Icons.note_alt_outlined,
              //   title: 'Raise a Complaint',
              //   onTap: () {},
              // ),
              // CustomDrawerListTile(
              //   icon: Icons.format_quote_rounded,
              //   title: 'FAQs',
              //   onTap: () {},
              // ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Contact Support', style: TxtStyle.headLineStyle4,),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Row(
                      children: [
                        Text('Call us:', style: TxtStyle.headLineStyle4,),
                        Text('+92312151515', style: TxtStyle.headLineStyle4,),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Row(
                      children: [
                        Text('Mail us:', style: TxtStyle.headLineStyle4,),
                        Text('mail@gmail.com', style: TxtStyle.headLineStyle4,),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget profileColumn(username, email) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(username, style: TxtStyle.headLineStyle3,), 
        Text(email, style: TxtStyle.headLineStyle3,)
      ],
    );
  }
}
