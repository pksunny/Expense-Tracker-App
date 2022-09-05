// ignore_for_file: prefer_const_constructors

import 'package:awesome_dropdown/awesome_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_tracker_app/provider/auth_provider.dart';
import 'package:money_tracker_app/provider/expense_provider.dart';
import 'package:money_tracker_app/utils/txt_style.dart';
import 'package:money_tracker_app/widgets/custom_button.dart';
import 'package:money_tracker_app/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class EditCurrency extends StatefulWidget {
  EditCurrency({super.key, required this.userListId, required this.email, required this.currency});

  String userListId;
  String email;
  String currency;

  @override
  State<EditCurrency> createState() => _EditCurrencyState();
}

class _EditCurrencyState extends State<EditCurrency> {

  static GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController currencyController = TextEditingController();

  // DROP DOWN LIST

    final dropDownList = ['PKR', 'INR', 'EUR', 'AUD', 'BGP', 'USD'];
    String selectedItem = '';
    bool isBackPressedOrTouchedOutSide = true;
    bool isDropDownOpened = true;


  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    AuthProvider authProvider = Provider.of(context);

    
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
              controller: emailController,
              hintText: widget.email,
              prefixIcon: Icons.email,
              textInputType: TextInputType.text,
              readOnly: true,
            ),
    
            SizedBox(
              height: height * 0.03,
            ),
    
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: AwesomeDropDown(
                dropDownList: dropDownList,
                elevation: 10,
                dropDownBGColor: primary,
                dropDownListTextStyle: TxtStyle.headLineStyle3,
                dropDownTopBorderRadius: 10,
                dropDownBorderRadius: 10,
                dropDownBottomBorderRadius: 10,
                selectedItemTextStyle: TxtStyle.headLineStyle3,
                selectedItem: widget.currency,
                isPanDown: true,
                onDropDownItemClick: (item) {
                  selectedItem = item;
                },
                dropStateChanged: (isOpened) {
                  isDropDownOpened = isOpened;
                  if (!isOpened) {
                    isBackPressedOrTouchedOutSide = false;
                  }
                },
                isBackPressedOrTouchedOutSide: isBackPressedOrTouchedOutSide,
              ),
            ),

            SizedBox(
              height: height * 0.03,
            ),

            CustomButton(
              onTap: (){
                if (formKey.currentState!.validate()) {
                    if (selectedItem.isNotEmpty) {
                      print('if => $selectedItem');
                      print(emailController.text);
                      print(currencyController.text);

                      authProvider.editCurrency(widget.userListId, widget.email, selectedItem);
                      
                    } else if (selectedItem.isEmpty) {
                      print('else => $selectedItem');
                      Get.snackbar(
                        'Currency',
                        'Currency cannot be empty',
                        margin: EdgeInsets.only(top: 20),
                      );
                    }
                  }
              }, 
              text: 'Update Currency'
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
