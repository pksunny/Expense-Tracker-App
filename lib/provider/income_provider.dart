
// ignore_for_file: prefer_const_constructors, prefer_final_fields, unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_tracker_app/models/income_model.dart';
import 'package:money_tracker_app/provider/auth_provider.dart';
import 'package:money_tracker_app/screens/dashboard/dashborad.dart';
import 'package:money_tracker_app/widgets/common_dialog.dart';
import 'package:provider/provider.dart';

class IncomeProvider with ChangeNotifier{

  // ADD INCOME IN DATABASE //
  Future<void> addIncome(incomeName, incomeAmount) async {

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
        .collection('incomeList')
        .add({
          'incomeName': incomeName,
          'incomeAmount': incomeAmount,
          'addedDate': addedDate,
          'addedMonth': addedMonth,
          'addedYear': addedYear,
          'user_Id': FirebaseAuth.instance.currentUser!.uid,
        });
      print("Firebase response $response ${FirebaseAuth.instance.currentUser!.uid}");
      CommonDialog.hideLoading();
      Get.offAll(() => DashBoard());
      Get.snackbar(
        "Income",
        "Income Added Successfully!",
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.only(top: 20),
      );
    } catch (exception) {
      CommonDialog.hideLoading();
      print("Error Saving Data at firestore $exception");
    }
  }


  // FETCH INCOME DATA //
  List<IncomeModel> incomeList = [];

  Future<void> getIncome() async {

    List<IncomeModel> newList = [];
    
    QuerySnapshot value = await FirebaseFirestore.instance
      .collection('incomeList')
      .where('user_Id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .get();

    value.docs.forEach(
      (element) {
        // print(element.data());
        // print('${element.id}');

        IncomeModel incomeModel = IncomeModel(
          incomeId: element.id,
          incomeName: element.get('incomeName'), 
          incomeAmount: element.get('incomeAmount'), 
          addedDate: element.get('addedDate'), 
          addedMonth: element.get('addedMonth'),
          addedYear: element.get('addedYear'),
        );
        
        newList.add(incomeModel);

       });

       incomeList = newList;

       
       notifyListeners();
  }

  List<IncomeModel> get getIncomeList {
    return incomeList;
  }

  

  // EDIT INCOME DATA FROM DATABASE //
  Future editIncome(incomeId, incomeName, incomeAmount) async {
    print("Income Id  $incomeId");
    try {
      CommonDialog.showLoading();
      await FirebaseFirestore.instance
          .collection("incomeList")
          .doc(incomeId)
          .update({"incomeAmount": incomeAmount}).then((_) {
        CommonDialog.hideLoading();
        getIncome();
        Get.back();

        Get.snackbar(
          'Income', 'Income Updated', 
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
  Future deleteIncome(incomeId) async {
    print("Income Iddd  $incomeId");
    try {
      CommonDialog.showLoading();
      await FirebaseFirestore.instance
          .collection("incomeList")
          .doc(incomeId)
          .delete()
          .then((_) {
        CommonDialog.hideLoading();
        getIncome();

        Get.back();

        Get.snackbar(
          'Income', 'Income Deleted!', 
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