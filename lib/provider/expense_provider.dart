
// ignore_for_file: prefer_const_constructors, prefer_final_fields, unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_tracker_app/models/expense_model.dart';
import 'package:money_tracker_app/models/income_model.dart';
import 'package:money_tracker_app/provider/auth_provider.dart';
import 'package:money_tracker_app/screens/dashboard/dashborad.dart';
import 'package:money_tracker_app/widgets/common_dialog.dart';
import 'package:provider/provider.dart';

class ExpenseProvider with ChangeNotifier{

  // ADD EXPENSE IN DATABASE //
  Future<void> addExpense(expenseName, expenseAmount) async {

    DateTime completeDateTime = DateTime.now();
    String onlyDate = completeDateTime.toString();
    String addedDate = onlyDate.toString().substring(0, 10);
    int addedMonth = completeDateTime.month;
    int addedYear = completeDateTime.year;
    
    print('Complete Date Time: $completeDateTime');
    print('Added Date: $addedDate');
    print('Added Month: $addedMonth');
    print('Added Year: $addedYear');

    try {
      CommonDialog.showLoading();
      var response = await FirebaseFirestore.instance
        .collection('expenseList')
        .add({
          'expenseName': expenseName,
          'expenseAmount': expenseAmount,
          'addedDate': addedDate,
          'addedMonth': addedMonth,
          'addedYear': addedYear,
          'user_Id': FirebaseAuth.instance.currentUser!.uid,
        });
      print("Firebase response $response ${FirebaseAuth.instance.currentUser!.uid}");
      CommonDialog.hideLoading();
      Get.offAll(() => DashBoard());
      Get.snackbar(
        "Expense",
        "Expense Added Successfully!",
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.only(top: 20),
      );
    } catch (exception) {
      CommonDialog.hideLoading();
      print("Error Saving Data at firestore $exception");
    }
  }


  // FETCH EXPENSE DATA //
  List<ExpenseModel> expenseList = [];

  Future<void> getExpense() async {

    List<ExpenseModel> newList = [];
    
    QuerySnapshot value = await FirebaseFirestore.instance
      .collection('expenseList')
      .where('user_Id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .get();

    value.docs.forEach(
      (element) {
        print(element.data());
        print('Expense id => ${element.id}');

        ExpenseModel expenseModel = ExpenseModel(
          expenseId: element.id,
          expenseName: element.get('expenseName'), 
          expenseAmount: element.get('expenseAmount'), 
          addedDate: element.get('addedDate'), 
          addedMonth: element.get('addedMonth'),
          addedYear: element.get('addedYear'),
        );
        
        newList.add(expenseModel);

       });

       expenseList = newList;

       
       notifyListeners();
  }

  List<ExpenseModel> get getExpenseList {
    return expenseList;
  }


  // FETCH MAJOR EXPENSE DATA //
  List<ExpenseModel> majorExpenseList = [];

  Future<void> getMajorExpense() async {

    List<ExpenseModel> newList = [];
    
    QuerySnapshot value = await FirebaseFirestore.instance
      .collection('expenseList')
      .where('user_Id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .where('expenseAmount', isGreaterThanOrEqualTo: 500)
      .orderBy('expenseAmount', descending: true)
      // .orderBy('expenseAmount', descending: true)
      .get();

    value.docs.forEach(
      (element) {
        print(element.data());
        print('Expense id => ${element.id}');

        ExpenseModel expenseModel = ExpenseModel(
          expenseId: element.id,
          expenseName: element.get('expenseName'), 
          expenseAmount: element.get('expenseAmount'), 
          addedDate: element.get('addedDate'), 
          addedMonth: element.get('addedMonth'),
          addedYear: element.get('addedYear'),
        );
        
        newList.add(expenseModel);

       });

       majorExpenseList = newList;

       
       notifyListeners();
  }

  List<ExpenseModel> get getMajorExpenseList {
    return majorExpenseList;
  }


  // FETCH DAILY EXPENSE DATA //
  List<ExpenseModel> dailyExpenseList = [];

  DateTime completeDateTime = DateTime.now();
  

  Future<void> getDailyExpense() async {

    String onlyDate = completeDateTime.toString();
    String addedDate = onlyDate.toString().substring(0, 10);

    List<ExpenseModel> newList = [];
    
    QuerySnapshot value = await FirebaseFirestore.instance
      .collection('expenseList')
      .where('user_Id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .where('addedDate', isEqualTo: addedDate)
      // .orderBy('expenseAmount', descending: true)
      .get();

    value.docs.forEach(
      (element) {
        // print(element.data());
        // print('Expense id => ${element.id}');

        ExpenseModel expenseModel = ExpenseModel(
          expenseId: element.id,
          expenseName: element.get('expenseName'), 
          expenseAmount: element.get('expenseAmount'), 
          addedDate: element.get('addedDate'), 
          addedMonth: element.get('addedMonth'),
          addedYear: element.get('addedYear'),
        );
        
        newList.add(expenseModel);

       });

       dailyExpenseList = newList;

       
       notifyListeners();
  }

  List<ExpenseModel> get getDailyExpenseList {
    return dailyExpenseList;
  }

  // EDIT EXPENSE DATA FROM DATABASE //
  Future editExpense(expenseId, expenseName, expenseAmount) async {
    print("Expense Id  $expenseId");
    try {
      CommonDialog.showLoading();
      await FirebaseFirestore.instance
          .collection("expenseList")
          .doc(expenseId)
          .update({"expenseAmount": expenseAmount}).then((_) {
        CommonDialog.hideLoading();
        getExpense();
        Get.back();

        Get.snackbar(
          'Expense', 'Expense Updated', 
          snackPosition: SnackPosition.TOP,
          margin: EdgeInsets.symmetric(vertical: 20)
        );
      });
    } catch (error) {
      CommonDialog.hideLoading();
      CommonDialog.showErrorDialog();

      print(error);
    }
  }

  // DELETE INCOME DATA FROM DATABASE
  Future deleteExpense(expenseId) async {
    print("expense Iddd  $expenseId");
    try {
      CommonDialog.showLoading();
      await FirebaseFirestore.instance
          .collection("expenseList")
          .doc(expenseId)
          .delete()
          .then((_) {
        CommonDialog.hideLoading();
        getExpense();

        Get.back();

        Get.snackbar(
          'Expense', 'Expense Deleted!', 
          snackPosition: SnackPosition.TOP,
          margin: EdgeInsets.symmetric(vertical: 20)
        );

      });
    } catch (error) {
      CommonDialog.hideLoading();
      CommonDialog.showErrorDialog();
      print(error);
    }
  }

}