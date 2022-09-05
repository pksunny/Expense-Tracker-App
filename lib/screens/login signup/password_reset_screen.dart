// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_tracker_app/provider/auth_provider.dart';
import 'package:money_tracker_app/screens/dashboard/dashborad.dart';
import 'package:money_tracker_app/screens/login%20signup/signup_screen.dart';
import 'package:money_tracker_app/utils/txt_style.dart';
import 'package:money_tracker_app/widgets/custom_button.dart';
import 'package:money_tracker_app/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class PasswordResetScreen extends StatefulWidget {
  const PasswordResetScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<PasswordResetScreen> {

  // SCAFFOLD //
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // FORM VALIDATION //
  final _formKey = GlobalKey<FormState>();

  // EMAIL & PASSWORD CONTROLLER //
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

    // CIRCULAR PROGRESS INDICATOR FUNCTION //
    @override
    Widget build(BuildContext context) {
      return _uiSetup(context);
    }

    @override
    void dispose(){
      super.dispose();
      emailController.dispose();
      passwordController.dispose();
    }


  @override
  Widget _uiSetup(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    AuthProvider authProvider = Provider.of(context);

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: primary,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
            // width: width * 0.9,
            // height: height * 0.55,
            margin: EdgeInsets.symmetric(horizontal: width * 0.05),
            decoration: BoxDecoration(
              color: Color.fromRGBO(193, 214, 233, 1),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ),
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
      
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  
                  SizedBox(height: height * 0.05,),
                  
                  // EMAIL FIELD
                  CustomTextField(
                    controller: emailController, 
                    hintText: 'Email', 
                    prefixIcon: Icons.email,
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Email cannot be empty';
                      }
                      if(!RegExp(r'\S+@\S+\.\S+').hasMatch(value)){
                        return 'Please enter a valid email address';
                      }
                      return null;
                    }
                  ),

                  SizedBox(height: height * 0.01,),

                  InkWell(
                    onTap: (){
                      Get.snackbar(
                        'Spam Folder', "Kindly check spam folder in email!", 
                        snackPosition: SnackPosition.TOP, 
                        margin: EdgeInsets.symmetric(vertical: 20)
                      );
                    },
                    child: Text("Did'nt get mail?", style: TxtStyle.headLineStyle4.copyWith(color: Colors.blue),),
                  ),
                  
                  SizedBox(height: height * 0.04,),
                  
                  CustomButton(
                    onTap: (){
                      if(_formKey.currentState!.validate()){
                        authProvider.passwordReset(emailController.text);
                      }
                    }, 
                    text: 'Send Request'
                  ),

                  SizedBox(height: height * 0.05,),
                  
                ],
              ),
            ),
          ),
          ),
        ),
      ),
    );
  }
}