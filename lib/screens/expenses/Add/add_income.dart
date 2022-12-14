// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_tracker_app/provider/income_provider.dart';
import 'package:money_tracker_app/screens/dashboard/dashborad.dart';
import 'package:money_tracker_app/utils/txt_style.dart';
import 'package:money_tracker_app/widgets/custom_button.dart';
import 'package:money_tracker_app/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class AddIncome extends StatefulWidget {
  const AddIncome({super.key});

  @override
  State<AddIncome> createState() => _AddIncomeState();
}

class _AddIncomeState extends State<AddIncome> {

  static GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  TextEditingController incomeNameController = TextEditingController();
  TextEditingController incomeAmountController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    IncomeProvider incomeProvider = Provider.of(context);

    
    return Form(
      key: formKey,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        width: width * 0.9,
        // height: height * 0.35,
        decoration: BoxDecoration(
            color: primary,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
            // ignore: prefer_const_literals_to_create_immutables
            boxShadow: [
              BoxShadow(
                  spreadRadius: -10,
                  blurRadius: 17,
                  offset: Offset(-5, -6),
                  color: Colors.white70),
              BoxShadow(
                  spreadRadius: -2,
                  blurRadius: 10,
                  offset: Offset(10, 10),
                  color: Color.fromRGBO(146, 182, 216, 1)),
            ]),
        child: Column(
          children: [
            SizedBox(
              height: height * 0.03,
            ),
    
            // TEXT FIELD TITLE
            CustomTextField(
              controller: incomeNameController,
              hintText: 'Title',
              textInputType: TextInputType.text,
              validator: (value){
                if(value!.isEmpty){
                  return 'Title cannot be empty';
                }
                return null;
              }
            ),
    
            SizedBox(
              height: height * 0.03,
            ),
    
            // TEXT FIELD AMOUNT
            CustomTextField(
              controller: incomeAmountController,
              hintText: 'Amount',
              textInputType: TextInputType.number,
              validator: (value){
                if(value!.isEmpty){
                  return 'Amount cannot be empty';
                }
                return null;
              }
            ),
    
            SizedBox(
              height: height * 0.03,
            ),
    
            // CUSTOM BUTTON
            CustomButton(
              onTap: () {
                if(formKey.currentState!.validate()){
                  incomeProvider.addIncome(
                    incomeNameController.text, 
                    int.parse(incomeAmountController.text),
                  );
                }
              }, 
              text: 'Add Income'
            ),

            SizedBox(height: height * 0.05,),
          ],
        ),
      ),
    );
  }
}
