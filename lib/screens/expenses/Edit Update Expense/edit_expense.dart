// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:money_tracker_app/provider/expense_provider.dart';
import 'package:money_tracker_app/utils/txt_style.dart';
import 'package:money_tracker_app/widgets/custom_button.dart';
import 'package:money_tracker_app/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class EditExpense extends StatefulWidget {
  EditExpense({super.key, required this.expenseId, required this.expenseName, required this.expenseAmount});

  String expenseId;
  String expenseName;
  int expenseAmount;

  @override
  State<EditExpense> createState() => _EditExpenseState();
}

class _EditExpenseState extends State<EditExpense> {

  static GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  TextEditingController expenseNameController = TextEditingController();
  TextEditingController expenseAmountController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    ExpenseProvider expenseProvider = Provider.of(context);

    
    return Form(
      key: formKey,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        width: width * 0.9,
        // height: height * 0.3,
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
              controller: expenseNameController,
              hintText: widget.expenseName,
              textInputType: TextInputType.text,
            ),
    
            SizedBox(
              height: height * 0.03,
            ),
    
            // TEXT FIELD AMOUNT
            CustomTextField(
              controller: expenseAmountController,
              hintText: widget.expenseAmount.toString(),
              textInputType: TextInputType.number,
            ),
    
            SizedBox(
              height: height * 0.03,
            ),
    
            // CUSTOM BUTTON
            CustomButton(
              onTap: () {
                if(formKey.currentState!.validate()){
                  expenseProvider.editExpense(
                    widget.expenseId, 
                    expenseNameController.text,
                    int.parse(expenseAmountController.text),
                  );
                }
              }, 
              text: 'Update Expense'
            ),

            SizedBox(
              height: height * 0.03,
            ),
          ],
        ),
      ),
    );
  }
}
